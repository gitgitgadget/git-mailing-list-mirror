From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Stable ab/i18n branch
Date: Fri, 15 Oct 2010 05:35:44 +0000
Message-ID: <AANLkTinafhoohf4yfFpTMonwKcTAqW513vq4Cqd--ogr@mail.gmail.com>
References: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
	<AANLkTimr73DUBBwdj9MXOQQ=O-vmyyEZpgwdHmRsGG_-@mail.gmail.com>
	<20101014200027.GA18813@burratino>
	<AANLkTim-2V_XtWVLFbWS_A-0rFNmuDvtR58aanxKL-O2@mail.gmail.com>
	<20101014205413.GD28958@burratino>
	<AANLkTi=LEzQu5_EyJ_ncRmsHfufG=AnEv9+eTQuqh5W7@mail.gmail.com>
	<20101015000749.GD29494@burratino>
	<AANLkTim0a7J5L1dtZNYTG7strEhjitZein5CVQayZFRh@mail.gmail.com>
	<20101015052810.GB21830@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 07:35:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6cxK-0000z0-OP
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 07:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371Ab0JOFfq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 01:35:46 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55062 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab0JOFfp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 01:35:45 -0400
Received: by fxm4 with SMTP id 4so220556fxm.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 22:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=X5xQNj4/jaabVEdJ213ZXlA5ngTA9qP5dK5w/1j3tq8=;
        b=P/2xR62UuyUFhYXAPToqUxYiSZKULMXgkJzXt0i45KqknOfTKzys3fgmMbBb9alv2k
         A7xppk1kVhJuNi4utBxyJW1xaQYu5VNJnxDDinWboHFERNJxfSjWipxK7FqVL0IOOtza
         mGTWQHJdxXRn4VvPfZxvPibkOLInJb6zqxd3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BbHt8fL15BDRxn/QATKU1c+XrPFOZluPrf2hyIUaeinrCXAu9umniNN6YzFzLfMJkN
         Qmsi+l9hsltQ5btae6trHsLqDRsPFu/C6ps9T2ZPgCrsahgtGDoWDsWyCQl1JJ3smJs1
         8JDlk/zJEXpv6x0ZrgaJmnxlO4NsaaU0XhBSQ=
Received: by 10.102.83.1 with SMTP id g1mr79332mub.47.1287120944187; Thu, 14
 Oct 2010 22:35:44 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Thu, 14 Oct 2010 22:35:44 -0700 (PDT)
In-Reply-To: <20101015052810.GB21830@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159097>

On Fri, Oct 15, 2010 at 05:28, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> No benefit? The benefit is that the program they previously either
>> didn't understand or understood poorly is now talking to them in the=
ir
>> native language. That's a pretty big benefit.
>
> And for the languages that are not translated yet?

Yeah those would get odd regressions with no benefit, unfortunately.

> Don't get me wrong --- I'm only trying to give a sense of what it is
> like for a user to experience a regression. =C2=A0It is generally lit=
tle
> solace that someone else's use case is supported better.

Understood. And it's certainly good that these things are pointed out.

>> =C2=A0 =C2=A0 =C2=A0 So unless someone else is interested in helping=
 audit all that
>> code, providing a printf() fallback on glibc etc. it'll block the i1=
8n
>> series.
>
> Oh, I never meant to say that this should be a blocker. =C2=A0Only th=
at
> there really are costs and benefits to weigh.
>
> Much more important than the known bugs are the unknown bugs ---
> you've heard this before, I think. =C2=A0The way to get rid of unknow=
n bugs
> (aside from inspecting code) is to get users.
>
> For example, if Gerrit doesn't mind, I would like to apply your
> patches to experimental once the version being staged for squeeze
> clears from there.

That would be great. Let me know if I can help with that in some way.

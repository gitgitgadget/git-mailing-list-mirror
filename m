From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Stable ab/i18n branch
Date: Fri, 15 Oct 2010 00:28:10 -0500
Message-ID: <20101015052810.GB21830@burratino>
References: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
 <AANLkTimr73DUBBwdj9MXOQQ=O-vmyyEZpgwdHmRsGG_-@mail.gmail.com>
 <20101014200027.GA18813@burratino>
 <AANLkTim-2V_XtWVLFbWS_A-0rFNmuDvtR58aanxKL-O2@mail.gmail.com>
 <20101014205413.GD28958@burratino>
 <AANLkTi=LEzQu5_EyJ_ncRmsHfufG=AnEv9+eTQuqh5W7@mail.gmail.com>
 <20101015000749.GD29494@burratino>
 <AANLkTim0a7J5L1dtZNYTG7strEhjitZein5CVQayZFRh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 07:31:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6ctL-0007zH-RT
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 07:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237Ab0JOFbi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 01:31:38 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41337 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab0JOFbh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 01:31:37 -0400
Received: by qwa26 with SMTP id 26so194285qwa.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 22:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1Tt1xa+Sa+U66DMBoQK7PGzyJAw6LZO2NdTvyuCt8nA=;
        b=Gg5gwsFZibUVQInEWe7elc6Bj9PEfm+RmHL7JJyGvyT/u7lW13Bvsn1wG57f1Jf2AZ
         +iLJNEO57WuNPz7W87F9NTmC0LZTnThoSXKYVzoG8KKKhfXYTCpxGnPXo+/mYDYdlw0+
         ZCutrrLbrIZtSBSZZWqyIELP1zxxMPu+SYapI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=xYq0Wdq4srYEUnhbkVyUgOhVqPRr6kQE3ubnOSK+K30YzvrJHaJlUDl1+Zg3LnL8wE
         +lChgYMxxtuxSGMSj1yWVvohP8A1KBol70O42nREEPQNZfF3tzxWV+ZsF5aWgSLzTBKF
         CCcTtqcU9mfd4i4gvGVzmXMmBph4zhtoawGhA=
Received: by 10.229.221.77 with SMTP id ib13mr247774qcb.226.1287120696582;
        Thu, 14 Oct 2010 22:31:36 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id z30sm422344yhc.9.2010.10.14.22.31.34
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Oct 2010 22:31:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim0a7J5L1dtZNYTG7strEhjitZein5CVQayZFRh@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159095>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> No benefit? The benefit is that the program they previously either
> didn't understand or understood poorly is now talking to them in thei=
r
> native language. That's a pretty big benefit.

And for the languages that are not translated yet?

Don't get me wrong --- I'm only trying to give a sense of what it is
like for a user to experience a regression.  It is generally little
solace that someone else's use case is supported better.

>       So unless someone else is interested in helping audit all that
> code, providing a printf() fallback on glibc etc. it'll block the i18=
n
> series.

Oh, I never meant to say that this should be a blocker.  Only that
there really are costs and benefits to weigh.

Much more important than the known bugs are the unknown bugs ---
you've heard this before, I think.  The way to get rid of unknown bugs
(aside from inspecting code) is to get users.

=46or example, if Gerrit doesn't mind, I would like to apply your
patches to experimental once the version being staged for squeeze
clears from there.

Other interested people can attract users in other ways --- by
providing documentation, tarballs, ...

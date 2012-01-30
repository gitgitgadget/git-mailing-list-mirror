From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/3] completion: remove unused code
Date: Mon, 30 Jan 2012 12:38:35 +0200
Message-ID: <CAMP44s2ooo1uArhhtJkX3S9N=iE4MNJivMSvr3hsOkxFmJupFA@mail.gmail.com>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
	<1327880479-25275-4-git-send-email-felipe.contreras@gmail.com>
	<20120130025014.GA15944@burratino>
	<CAMP44s1bZeednbHfqXANZR5zVVvGwjRpuV5TFmnh212FD7E-Vg@mail.gmail.com>
	<871uqh3a8s.fsf@thomas.inf.ethz.ch>
	<25ea208e-353d-48f7-a849-143689fb2be6@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <jch2355@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 11:38:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrodF-0003Bn-Ub
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 11:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646Ab2A3Kih convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 05:38:37 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:57429 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751097Ab2A3Kih convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 05:38:37 -0500
Received: by lagu2 with SMTP id u2so2094450lag.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 02:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=G8UEV4G2EW/GQGVChH2nQqAwoju9BL8ewHRDD88zcCc=;
        b=uWkBjtMbUdaj7e3J0YQkQnLJ3yuZ+taTQsW832+NTUFnQo518K3tQf8EZTJrJbv/Cr
         7PcBHWPPJXV1zIfFOkCbb4VGKnDfcjEhuhYu4L8fsHVSniPTBGHebOZbx0vINiHBxyBX
         v85aWgWHtzBTKz204u59LCTXNAgyTex0BljBQ=
Received: by 10.152.147.103 with SMTP id tj7mr8924678lab.3.1327919915797; Mon,
 30 Jan 2012 02:38:35 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Mon, 30 Jan 2012 02:38:35 -0800 (PST)
In-Reply-To: <25ea208e-353d-48f7-a849-143689fb2be6@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189337>

On Mon, Jan 30, 2012 at 10:22 AM, Junio C Hamano <jch2355@gmail.com> wr=
ote:
> Thomas Rast <trast@inf.ethz.ch> wrote:
>>Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> No reason. I hope they read the mailing list, otherwise I'll resend
>>> and CC them. A get_maintainers script, or something like that would
>>> make things easier.
>>
>>I simply use
>>
>> =C2=A0git shortlog -sn --no-merges v1.7.0.. -- contrib/completion/
>>
>>(In many parts the revision limiter can be omitted without losing muc=
h,
>>but e.g. here this drops Shawn who hasn't worked on it since 2009.)
>
> Or "--since=3D1.year", which you can keep using forever without adjus=
ting.

Perhaps something like that can be stored in a script somewhere in
git's codebase so that people can set sendemail.cccmd to that.

--=20
=46elipe Contreras

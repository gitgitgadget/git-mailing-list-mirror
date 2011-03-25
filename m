From: Vicent Marti <vicent@github.com>
Subject: Re: git2 cli (GSOC)
Date: Fri, 25 Mar 2011 15:00:38 +0200
Message-ID: <AANLkTimHpRFSYTgiqiPonQGiEVZtkCeX_tJcVjjnNSaX@mail.gmail.com>
References: <20110324020232.GA10441@jakstys.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-13?Q?Motiejus_Jak=F0tys?= <desired.mta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 14:01:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q36dW-0006Ev-2C
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 14:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976Ab1CYNBA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2011 09:01:00 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49393 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab1CYNA7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2011 09:00:59 -0400
Received: by wya21 with SMTP id 21so1075352wya.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 06:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Q64CuXs/W1XzSev79g92s6eOzx8BJYcKFF9yZWCZf6g=;
        b=XzLPmqB5EzNrhk2PJ0DzjJpzEECtVl8sLa5opl1PBrB96abJktyd9eTdAtbFrr5bJg
         nwALkhE3M4xstF3Y/2qJjweqyq7u9tTapo1aoAsGGQl0RSoPO4lpsFfkgRPrB3Tgv+c/
         iyg1trdZAMRKWojSfpzfpcYX2rkms8Sl0ImeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=Hxb/+GpVebmd9VbWboDF3l2XGaX3cFsvgE4MIpvt6Gq8WOjESKn5+mjh91v72dUFjg
         Uz0YjI7iTQR3Wezu7lTzbIFzMLAcXLNpLZXtprwcU0wMGF+XFRV7Gu7ZJnvCnvoWlJEx
         oJCtF7PhnFwJsIYqSS8mHkZAM4tiJ7RiAjtEw=
Received: by 10.216.205.13 with SMTP id i13mr694639weo.36.1301058058181; Fri,
 25 Mar 2011 06:00:58 -0700 (PDT)
Received: by 10.216.243.7 with HTTP; Fri, 25 Mar 2011 06:00:38 -0700 (PDT)
In-Reply-To: <20110324020232.GA10441@jakstys.lt>
X-Google-Sender-Auth: AnDz_ecXHNKUuueDUMrGyjg61Js
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169984>

Yo Motiejus,

sorry I missed this. That's quite the headstart you got going here
(although maybe a little bit too ambitious). Of course there's people
interested on mentoring this -- make sure you submit a proper
application on Melange when the application period opens, and we'll
look into it with more detail.

Cheers,
Vicent Marti



2011/3/24 Motiejus Jak=C5=A1tys <desired.mta@gmail.com>:
> Hello folks,
>
> IMHO libgit2 is the best thing happening in Git world. Why? In world =
of
> good software:
>
> 1) You implement a prototype of a thing (e83c516 probably)
> 2) See it's cool
> 3) Make it work and and all others start using it
> 4) Clean it up
> 5) Make it run on your watch.
>
> libgit started git's way to (4). Note: I'm not saying git is "bad". I=
t
> has just hell too many dependencies for a watch. =C2=A0When libgit2 a=
nd git2
> are mature enough, it will run on Android and my watch.
>
> There were some ideas in this mailing list about merging libgit2 to g=
it
> a couple of days ago. I think that's pointless, it should be the othe=
r
> way around. Git features should get to libgit2 and git2.
>
> Working is better than talking, so I created a git2 cli prototype[1].=
 It
> has one feature, which is (should be?) equivalent to:
> =C2=A0 =C2=A0$ git rev-list HEAD
>
> You can run it like this:
> =C2=A0 =C2=A0$ git2 rev-list <anything>
>
> I created a very, very rough draft of git2.c. Thanks Jeff King for
> advise[3] starting with a basic plumbing command. Those couple of hou=
rs
> were quite interesting, because none of the human-readable API
> documentation examples[4] I've tried actually worked. :)
>
> We have some architecture questions to answer before getting started.
> Are we aiming for a distributed 100s of executables architecture
> (current git), or single huge binary (linux/busybox)? I would count f=
or
> single executable due to higher portability. However, plugging git2 f=
or
> git unit tests should require more thought.
>
> Build configuration. Git-send-email is not really a must-have for an
> embedded device, so we should be able to specify these features in
> configure-time. How do you think it should be taken care of?
> 1) <buildtool> configure =C2=A0--disable-everything --enable-email
> 2) make menuconfig and enjoy the blue screen of choice
> 3) ?
>
> Build tool. I am not against waf (I've chosen waf for SoundPatty), I'=
ve
> been using it, but it's too clumsy for me. Is it me that lacks
> experience and it's a great tool, or am I not the only one who someti=
mes
> feels confused and pissed off when trying to do some really simple
> things? Should I stick to waf because libgit2 uses waf?
>
> I want to do this hell a lot. I'm a student and I have C++
> experience[2]. Actually I think it's not really my taste, since it is
> too high-level for me. I love C and currently I am a full-time Python
> web developer (django/friends)... I couldn't sleep for the last two
> nights because libgit2 peaked my interest and my performance at work =
was
> quite terrible. I see you are + for this tool as I am, so we might ha=
ve
> some great work together. Anyone would like to be a mentor?
>
> About me.. I already told quite a lot, but you can find more info
> (probably that means only CV) in my personal websites[5][6].
>
> [1] https://github.com/Motiejus/git2/
> [2] https://github.com/Motiejus/SoundPatty/
> [3] http://marc.info/?l=3Dgit&m=3D130081966214059&w=3D4
> [4] http://libgit2.github.com/api.html
> [5] http://m.jakstys.lt/
> [6] https://github.com/Motiejus/ :-)
>
> Regards,
> Motiejus Jak=C5=A1tys
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

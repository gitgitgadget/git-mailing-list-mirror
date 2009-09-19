From: James Sadler <freshtonic@gmail.com>
Subject: Re: SmartGit, a new GUI front-end for Git
Date: Sat, 19 Sep 2009 18:58:08 +1000
Message-ID: <e5e204700909190158y48b9c162ncea29f4b1635dc18@mail.gmail.com>
References: <4AB38D64.9010903@syntevo.com> <4AB48E25.8020504@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Sat Sep 19 10:58:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Movm0-0002hW-0v
	for gcvg-git-2@lo.gmane.org; Sat, 19 Sep 2009 10:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433AbZISI6H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Sep 2009 04:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753159AbZISI6G
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Sep 2009 04:58:06 -0400
Received: from mail-px0-f189.google.com ([209.85.216.189]:63836 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbZISI6F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Sep 2009 04:58:05 -0400
Received: by pxi27 with SMTP id 27so1124881pxi.22
        for <git@vger.kernel.org>; Sat, 19 Sep 2009 01:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Dok5pat3y0+ieif4wzCma6bNS2z6McPsFk1bLQmKt8k=;
        b=ZP+qoHq+CEdf47qfETXUk8hnCJT/0yoVE3lAeqKfpMmplFFDLNCG3VPx5XSrqb1BeU
         V8a0xZR8H2ZLJrktbDxD6WsHkosqW38ShkfhqpusW+aStnomCVVhtHbyB1hUKl2oD9gT
         2GIQvDTnR+WNfifQkFLMnGjt8SgRqjuvnRFoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eUTtH0vF4SK4Lxe2T+IgdDmkEMNn6Pu93MyfZZQiHK6f9XEM7zJWPeBhtQ3jxm/Xbf
         1LRlXG2FPWE0FBNKFB0UNtY0BlV4s0YD6TcChvU+kYQBW0dHUg7LI2OffMGj/fOCF9eO
         Wdw1kwBw/FVcVUU4uPkN/6Y3+G7M+MdWRkjV4=
Received: by 10.140.163.7 with SMTP id l7mr162733rve.166.1253350688949; Sat, 
	19 Sep 2009 01:58:08 -0700 (PDT)
In-Reply-To: <4AB48E25.8020504@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128821>

Hi Thomas,

I just launched SmartGit, and it ate my ~/.gitconfig.  Luckily I had a
backup (full of my own aliases and colour settings etc.).

SmartGit replaced mine with a ~/.gitconfig containing _only_ my name
and email settings.  Not good.  I would bet that 99% of all people on
this list have their own customized version of ~/.gitconfig and
SmartGit is probably going to eat it.  If it helps, I am running OS X.

James.

2009/9/19 Thomas Singer <thomas.singer@syntevo.com>:
> Hi all,
>
> We would like to announce a new milestone build of our Git client "Sm=
artGit"
> (don't be offended by the name, it's historically based) which we fee=
l is
> ready now for a broader audience. SmartGit is quite stable and we wan=
t to
> invite everyone who is interested in giving it a try:
>
> =C2=A0http://www.syntevo.com/smartgit/index.html
>
> Please don't expect all Git features and options implemented. We have
> tried to first concentrate on the most important ones - from our rath=
er
> novice Git perspective.
>
> SmartGit runs on all operating systems which support a full Java 1.5
> implementation, including virtually all Linux versions, OS X 10.4 - 1=
0.6 and
> Windows 2000 or newer. It requires a Git installation, although a cou=
ple of
> time-critical operations are handled by the JGit library.
>
> We appreciate your feed-back in our mailing list
>
> =C2=A0http://www.syntevo.com/smartgit/community.html
>
> or directly to us (smartgit@syntevo.com). SmartGit 1.0 is planned to =
be
> released free of charge for non-commercial use or to active members o=
f the
> Open Source community. Each pre-release build expires 3 months after =
the
> build-date.
>
> At this occasion I would also like to express my appreciation to the
> community for this great DVCS you have built. Approx. a 3/4 year ago =
I've
> started to use Git. Although I had some starting problems with it usi=
ng the
> Git command line (mostly on Windows), I need to say that over time I =
really
> fell in love with Git and its elaborate foundations and feature set.
>
> --
> Best regards,
> Thomas Singer
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> syntevo GmbH
> http://www.syntevo.com
> http://blog.syntevo.com
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
James

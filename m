From: g2 <gerald.gutierrez@gmail.com>
Subject: Re: How to jump between two repositories ...
Date: Tue, 4 Dec 2007 22:44:27 -0800
Message-ID: <33CB0252-20C7-4AF2-AEB3-2EAC20ED830B@gmail.com>
References: <C6AF7922-B2F7-42EB-B5DD-25353BC0AF2A@gmail.com> <3DD4D3BA-67B3-4AFC-AD24-799384D54408@pp.inet.fi>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
X-From: git-owner@vger.kernel.org Wed Dec 05 07:45:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izo07-0004iB-5i
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 07:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbXLEGoe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 01:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbXLEGoe
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 01:44:34 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:55354 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbXLEGod convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Dec 2007 01:44:33 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3495735rvb
        for <git@vger.kernel.org>; Tue, 04 Dec 2007 22:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=WOMGT2WhjUyxQrua7VhVoUGr6UPxaKlUVJZ+RO4QjIU=;
        b=mUYC8TTn2qZztLzoFflRiRBUxbFRYRvD85cY/xNK4n50QB3ucM41Jec4O0zqFZ/gqiwVHcAXFZH9aoErrpDTh6lQvS7hosB1XEzj1vN6SGSZ5dqisMypMkfTT0nRqlyaoNHGBzJ2Dl3+yg/hVzQHaIYsLfyHRzDDrscb1VbOXDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=oLh9Nl0e9Uu0HJL7e/2uKg3ACyti3ExmuGjXq/nTW1rKtGO1ABEKbJmDZN31jnU/J9pc5ID1myycQu2ENU3bjMG+kjnFMoX6lHIjjqSsZtOS29zoRe+nwnN0cRaiMx0wGWNCKDcMpy2ldpDn317iwNuI4If5qCplkwDFY5dLNaM=
Received: by 10.140.207.2 with SMTP id e2mr921460rvg.1196837073043;
        Tue, 04 Dec 2007 22:44:33 -0800 (PST)
Received: from ?192.168.0.200? ( [70.79.106.215])
        by mx.google.com with ESMTPS id f28sm208633rvb.2007.12.04.22.44.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2007 22:44:30 -0800 (PST)
In-Reply-To: <3DD4D3BA-67B3-4AFC-AD24-799384D54408@pp.inet.fi>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67107>


What I am gathering from this is that I can use git in two ways: 1) as =
=20
"just another svn" bare git repository, or 2) only pull and don't =20
push, because push causes confusion. I'd be happy to only ever use =20
pull, but I have one machine behind a firewall and can't pull. I can =20
push to a bare git repository like the svn model, but then I would =20
just use svn. What's the value of "push" then?


On 4-Dec-07, at 10:20 PM, V=E4in=F6 J=E4rvel=E4 wrote:

> On Dec 5, 2007, at 07:59, g2 wrote:
>
>> I am currently working on some code at the office that I also want =20
>> to work with at home. Seems like a good candidate for git. So I =20
>> created a repository at work and did a "git clone" at home. I've =20
>> run into some strange behaviour that I don't understand and would =20
>> appreciate if someone can clarify for me.
>>
>> Imagine this scenario. At work:
>> git init
>> edit test.c
>> git add test.c
>> git commit
>>
>> Then at home:
>> git clone <work git url>
>> edit test.c
>> git commit -a
>> git push
>>
>> At this point, I wanted to push my changes back to my work =20
>> repository so I can continue work the next day. So at home, I did a =
=20
>> git push. I expect that my work repository has the newest material, =
=20
>> but I find that when I do "git status" at work the next day, it =20
>> tells me that my test.c is "modified" and has already staged it for =
=20
>> commit. I need to do a "git reset" followed by "git checkout" to =20
>> update my work folder to the latest stuff.
>
> Did you clone a bare repository and push to it?
>
> Here is an excerpt from Git User's Manual:
> "Note that the target of a "push" is normally a bare repository. You =
=20
> can also push to a repository that has a checked-out working tree, =20
> but the working tree will not be updated by the push. This may lead =20
> to unexpected results if the branch you push to is the currently =20
> checked-out branch!"
>
> So to push to your work repository, you should create an =20
> intermediary repository between the work and home repositories. You =20
> can create it by running:
> $ git clone --bare /git/work/ /git/work.git/
>
> Then you clone normally from the bare repository and pushing to it =20
> works fine. After you have pushed your changes to the bare =20
> repository, you'll have to pull them to the work repository to get =20
> the updates, just like you would do with any public repository.
>
> Another option would be to pull from your home repository to the =20
> work repository, if you can access your home computer from the work =20
> computer.
>
> --
> V=E4in=F6
>

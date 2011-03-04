From: "Hillel (Sabba) Markowitz" <sabbahillel@gmail.com>
Subject: Newbie question about setting up git repository from svn (git svn)
Date: Fri, 4 Mar 2011 10:57:21 -0500
Message-ID: <AANLkTi=UG4oq4QHhKoDOi9+4bhF1TDy4Z26ORj9Bdcwc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 16:57:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvXNp-000741-8x
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 16:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278Ab1CDP5Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2011 10:57:25 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:33559 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932264Ab1CDP5X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2011 10:57:23 -0500
Received: by vxi39 with SMTP id 39so2120355vxi.19
        for <git@vger.kernel.org>; Fri, 04 Mar 2011 07:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=AqJu2goCkqDFzS0nZ+iFFR/FdjNHGaTGQuI00MFEcjo=;
        b=GM7dnepJDssltgeoL+jXu/0CrYiuT6SBvMzI6dXIWZRKcwl337NrdfZrdAQXWhYUlu
         HMo6JIziTdZ2auWcR8HOY0rjqwA31ad9a3qzsCu5iWzhFaTp2ELS5HmGl9cIYyaQ3ajB
         rxeC88BJIiAxmCyjsUWUbkE+ts0VQx78v9/yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=CwYWo0DdhZMNeJmM97ri5KL7meCFcGeJ6K/WOUwa60ZJcWk34ravqDBfZQ5C/Cg61R
         K89BznOPtzlU7Bd+91+VhRY3VLvbRVbwqp3FQtmAl2ymfSmWwjEdBnNnFgi96XEfPFtR
         uiW6BV0D4T8IOSoZ0U+GW2SyWOw5roEmf2eBU=
Received: by 10.52.89.101 with SMTP id bn5mr1191222vdb.121.1299254241933; Fri,
 04 Mar 2011 07:57:21 -0800 (PST)
Received: by 10.52.158.9 with HTTP; Fri, 4 Mar 2011 07:57:21 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168443>

Please respond directly to sabbahillel@gmail.com as I do not have time
to follow this mailing list.


I am attempting to set up a git repository based on an svn repository.
The idea would be that the members of the project would be able to use
git exclusively with the central git repository acting as the
coordinator. This git server would be the only one capable of issuing
the git svn dcommit and git svn rebase and the members of the project
would not have to worry about it. Eventually, the subversion
repository would be transferred to git.

I created a separate Ubuntu VM in order to set up the git repository.
I used "git svn clone -s" to set up MyProject.git on "gitserver"

The command "git branch -a" shows
* master
  remotes/branch1
  remotes/branch2
  remotes/trunk


I then went to my main VM and used ssh to clone the repository

git clone gitserver:/opt/git/MyProject
cd MyProject
git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/master

How do I check out the trunk or appropriate branches from the remote?
I am probably misreading the documentation. Would it be

git checkout -b branch1

does the master on the remote (and here) actually point to the trunk by=
 default?
should I checkout the branches on "gitserver"?

I also do not see how I can get the list of branches from the remote
location.without having to do an ssh into the gitserver, cd to the
repository directory, and use a 'branch -a' there. Is there a way to
ask for this information? I have not yet been successful in setting up
gitosis yet because this is on an internal company intranet and I do
not have a valid machine name for my accounts as everything is being
done on VMs. Thus, my public key ends with
"sabbahillel@desktop-ubuntu" rather than an actual machine name or
address.

Would you have a pointer to a HOW-TO that discusses this.

Thanks for any help that you can give me.

--
=C2=A0 =C2=A0 =C2=A0=C2=A0 Sabba=C2=A0 =C2=A0=C2=A0 -=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =D7=A1=D7=91=D7=90 =D7=94=D7=9C=D7=9C=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 -=C2=A0 =C2=A0=C2=A0 Hillel
Hillel (Sabba) Markowitz | Said the fox to the fish, "Join me ashore"
=C2=A0SabbaHillel@gmail.com | The fish are the Jews, Torah is our water
http://sabbahillel.blogspot.com

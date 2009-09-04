From: "armencho@gmail.com" <armencho@gmail.com>
Subject: .git and retrieving full source tree for own project(s)
Date: Fri, 4 Sep 2009 21:52:07 +0200
Message-ID: <981b72360909041252i29551a5chb8b3a2a5c6444ee3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 04 21:52:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjepp-0004Qs-8A
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 21:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933926AbZIDTw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 15:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933922AbZIDTw2
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 15:52:28 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:55623 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933911AbZIDTw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 15:52:26 -0400
Received: by ewy2 with SMTP id 2so730556ewy.17
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 12:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=T36zGNFDoKzr45gy6f3W80/LngnqZDz3SzaOfFFCJHk=;
        b=xCvtueG2MauIGGIUCEJUS/84it5/ik6fKMUX5bFY6X2DYQZKzX+wDIhvDIpEhROLH1
         ymHm6rDmT1KGjb+5VNd33R5oyYuzbOFBQviYq12sOOyqcBoZtGWoUUtVwYw6Ts/oawvE
         iUEowzpvIjBotQ6k+tKPEvUT98NOxglHDR1CA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=cDsyqMpgcK4eZ+FlG1qteUiLQrShebgY4lWGLnDdiRxZjbDQIK90RBztapk8BBEUrA
         FcZI49EPkSpIphTbq7kVM2Azj53bxncqNapFH28kAvA7eycU00cobiQL+3KpxMFghoaz
         8LLnR0cxgTTRSh7LUVpipWwdJzcTTT+5V5Q1o=
Received: by 10.216.11.138 with SMTP id 10mr2283930wex.51.1252093947083; Fri, 
	04 Sep 2009 12:52:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127764>

Hi all,

I just started with git and suprisingly or unsurprisingly everything
works, and I love it. I had been working on a software project, and i
ran "git init" in its source tree, which created the ".git". I added
all files with "git add ." and first-time committed them all using
"git commit -a -m "Imported project files". I also did couple three
commits after that and well, everything works.

What I am wondering about is, what is gits identity for a repository?
I don't share or publish the source directory anywhere, and just for
testing I removed everything but the ".git" directory and tried "git
checkout" and "git checkout master". To my surprise, the files in
repository did NOT reappear, contrary to what I thought. Doesn't
checkout update/recreate the project file tree according to the
"trunk" snapshot?

Now, I did all this just out of curiosity, but to my understanding
everything that is needed for working with the project is stored in
".git", right? Even if all project files mysteriously disappear, "git
checkout" should bring the copy of master branch back, no? If not,
what is the way to tell git I want full copy of a snapshot?

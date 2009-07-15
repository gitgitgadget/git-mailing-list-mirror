From: Paul Richards <paul.richards@gmail.com>
Subject: How to manage multiple personal projects
Date: Wed, 15 Jul 2009 17:00:41 +0100
Message-ID: <a1138db30907150900j7d6152ebs755d83adf7717287@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 15 18:00:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR6uZ-0000ob-5b
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 18:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208AbZGOQAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 12:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbZGOQAo
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 12:00:44 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:39531 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbZGOQAn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 12:00:43 -0400
Received: by bwz28 with SMTP id 28so1509151bwz.37
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 09:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=F/rZTljDbE7toe0/3a8h962DjVJzZ2rBP4F4IdeeyfI=;
        b=X1BwMo5wnpYfNC5oL0tycUef9SG6VJ6y4aURsBk2/hhbDU3sXKBXyu1IgWIwGsB4TW
         XzCgWFulxLlNE+kggxHVQ5fN0YorGUvRvwS8ouXLPYgj6msvQL/eBZl0a7IDeFFDKrtY
         GhM4J+oXbgVK5NZSaFjSumt+rAf3oJ134j7Q4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Z4TZ1gx0QtbYYH/+pFRyajDi5tur49lVJJTEvi8i9T/LF5svV5symLCANqqWS8mNOc
         1chvVAp3DWGVbwniR3v+qTUeyx82nh0Aym26e90RejzVK+XiBlRHADI2rKTM/R622+QV
         U/Z74t/xztWmCn6jYNka2Cy5DNh9Cs3uf0O0w=
Received: by 10.204.70.19 with SMTP id b19mr7710916bkj.62.1247673641383; Wed, 
	15 Jul 2009 09:00:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123324>

Hi,
I am currently using Subversion for my personal projects but am very
interested in moving to a DVCS (most likely Git).  The only
reservation I have is that I'm not sure how to map my current workflow
to Git.

Currently I have a single Subversion repository which holds all of my
work.  Typically when I experiment with something new I create a
directory at the top level of my repository, and start hacking away.
9 times out of 10 these experiments run for a few days then are never
touched again.  The directory will just sit there forever more in my
repository.  Occasionally one of these "projects" will keep me
interested for a while longer and so it will grow into something that
I work on for a longer period and I might publish. Publishing a URL
for a single project from my repository is very easy, as I can give a
URL which points to just the correct directory within the repository.
The third party doesn't see all my other junk unless they explicitly
navigate up the URL, nor do they end up checking out lots of stuff
related to other projects.

In short, with Subversion a single repository can hold multiple
projects very easily for me.  I myself typically just check out my
entire repository, but when I send links to others I typically only
send them the URL for the project of interest.

With Git, I'm not sure how this would work.  From what I understand
about branches and tags in Git is that they apply to the whole
repository.  And so it would not be advisable to store multiple
projects in a single repository.  I could choose to ignore this, and
store all my small projects in a single Git repository anyway, but I'm
not sure how I'd then allow others to checkout just a single project
directory.  (I presume they wouldn't be able to)

I believe the correct choice with Git is to create a repository per
project.  This would work OK for me, but I worry about the shear
number of repositories I'd end up creating.  Part of the nice thing
with my current Subversion setup is that starting a new project is
very easy and cheap, I don't create a new repository each time.

I think what might work with Git (and for which I'd like some advice)
is something inbetween.  I could have a single Git repository to hold
my small experiment projects where initially is where I always start
my work by creating a new directory.  Then if any of them start to
mature, I could move the project out into it's own repository for
real.  Would Git support this in some way tracking changes from one
repo to the other?  Or would I end up having to "replay" all the
commits from one repo to the other?

Thanks for reading so far, I'd appreciate any advice people have for this.

My Subersion repository is (temporarily) available publicly:
http://pauldoo.dyndns.org/svn/

Hopefully you might see how small many of these little projects are.
Occasionally though they grow into something larger that I do publish
(e.g. Proffy, Pigeon, Tuner).

-- 
Paul Richards

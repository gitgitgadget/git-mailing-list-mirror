From: Marc Singer <elf@buici.com>
Subject: Bootstrapping into git, commit gripes at me
Date: Fri, 8 Jul 2005 16:07:50 -0700
Message-ID: <20050708230750.GA23847@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jul 09 01:14:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dr23P-0004G9-HK
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 01:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbVGHXJU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 19:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262958AbVGHXJT
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 19:09:19 -0400
Received: from florence.buici.com ([206.124.142.26]:25065 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S262960AbVGHXHv
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 19:07:51 -0400
Received: (qmail 25092 invoked by uid 1000); 8 Jul 2005 23:07:50 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In working through a usage example on my way to producing bonafide
patches, I've found that commit is complaining.  Here's what I've done.

  o Fetched and built cogito-0.12
  o Fetched (rsync) Linus' tree
  o Created a working directory, linux-2.6
  o linked .git in the working directory to the .git directory fetched
    from the net.
  o # git checkout -f v2.6.11
  o # cat ../old-patch-file | patch -p1

Then, according to Jeff's instructions, I have to perform
get-update-cache with the name of each file I changed.  Is that really
the way?

  o # git-update-cache LIST_OF_CHANGED_FILES

Now I commit.

  o # git commit

I am presented with an editor session with the list of changed files
already present.  IfI add a comment and leave the editor, I'm told

   fatal: 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c is not a valid 'commit' object

If I don't edit the comment, it doesn't give an error but I don't
think the changes are committed because I can invoke git commit again.

Am I off track?

Cheers.

P.S.  vger isn't letting me subscribe ATM.  Please copy me with
      replies.

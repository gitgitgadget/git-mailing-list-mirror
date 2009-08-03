From: skillzero@gmail.com
Subject: How to fetch all remote branches from remote?
Date: Mon, 3 Aug 2009 15:20:43 -0700
Message-ID: <2729632a0908031520n71514fffne0667c6b229f836f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 00:20:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY5tj-0001Rs-EQ
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 00:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993AbZHCWUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 18:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754987AbZHCWUo
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 18:20:44 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:46101 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbZHCWUn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 18:20:43 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1878620qwh.37
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 15:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=/yg4QnMQO7U84dcCNyGvCCTmJJncNQfhqprulC8He9o=;
        b=IHGhQ6rTdxh9bFUgB+djSPeIPz3NVJmibbrCeornmRQTLiBzsgt5i5eZU91y9Kc1zO
         4VR6VVJQAEyMi5BfOzBPOB2en3m+F8b5RdtaF6cIw1rJf8bQ03TJ2+czTkgwn9zf0DT7
         DUfS7is57vENj8dZ8+B3myQtruK8dkn7Lam3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=sOEfzkob/l2Jn87C0eUAt5CVJgWqAdkKaDcQXtPomO9OejX4//1CVNPkLUrOHipWta
         gsMwo7b62tDTS0HguS7LsXmz/PGR7W/Gt56EZGwnrezxgKdvmEP/+9hmvPIa9+4huHdZ
         AqIJlpKqcKDMMH0WIEJmFCj9I6KR6jzTFF+So=
Received: by 10.224.45.195 with SMTP id g3mr5329071qaf.168.1249338043901; Mon, 
	03 Aug 2009 15:20:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124731>

Is there a way to fetch all the remote branches of a remote? I have
one computer that cloned a repository from a server and I want clone
that computer's repository to another computer, but it only brings
over the local branches from the clone. I'd like to also get all the
remote branches so it's the same as if I had cloned directly from the
server. Just as if I had cp -R'd the .git folder (except with the
remote tracking info I get when I clone). The source computer's
repository is using git-svn so I'm trying to make a copy of that
repository in a way that I can just push and pull changes to the
intermediate git svn repository then later do the final git svn
dcommit.

Is the best way to just copy the whole .git folder to the destination
computer and then add the original as a remote? That's a last resort
for me because as new svn branches are created, I'd like to pick them
up when I do git pull's from the second computer.

From: mail@glenstark.net
Subject: (unknown)
Date: Tue, 26 Aug 2014 04:16:17 -0700
Message-ID: <e1b2b0f6c0bdf4585f8e14ebacd68937.squirrel@webmail.glenstark.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 13:16:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMEjx-0000cS-CM
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 13:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757596AbaHZLQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 07:16:37 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:41832 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757552AbaHZLQg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Aug 2014 07:16:36 -0400
Received: from homiemail-a6.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 072B390383
	for <git@vger.kernel.org>; Tue, 26 Aug 2014 04:16:36 -0700 (PDT)
Received: from homiemail-a6.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a6.g.dreamhost.com (Postfix) with ESMTP id 2938C598070
	for <git@vger.kernel.org>; Tue, 26 Aug 2014 04:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=glenstark.net; h=
	message-id:date:subject:from:to:mime-version:content-type:
	content-transfer-encoding; s=glenstark.net; bh=UK9RdI/cXmPhUra6L
	jGIS/J7DlU=; b=Ug01ms8w0wkPXlbr0SsXNa5lQxX4+PY5hoNeYL1PcqJc4Uui3
	zqkexHKHcXLnaeQFGmDElqjB/7Xnt/Bsc+ioIcbcKF+g7PUxFZmNE2Q7rCZ9a5k6
	Ky/clrOVoEK5xUN5Me9sJCNjW9YiMIBQE6p2rwLy+DzsmfbiGDCSsyFMP4=
Received: from webmail.glenstark.net (caiajhbihbdd.dreamhost.com [208.97.187.133])
	(Authenticated sender: mail@glenstark.net)
	by homiemail-a6.g.dreamhost.com (Postfix) with ESMTPA id 1891C59806B
	for <git@vger.kernel.org>; Tue, 26 Aug 2014 04:16:17 -0700 (PDT)
Received: from 62.2.75.66 (proxying for 62.2.75.66)
        (SquirrelMail authenticated user mail@glenstark.net)
        by webmail.glenstark.net with HTTP;
        Tue, 26 Aug 2014 04:16:17 -0700
Subject: 
User-Agent: SquirrelMail/1.4.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255888>

Hi everyone.

Normally if I am tracking a file in a Directory which satisfies one of my
.gitignore rules, I can just add them via "git add foo", and I have no
issues.

For example, let me create a new repo.  I create a directory "lib"
containing file "foo.txt", and a Directory "lib2" with a file "bar.txt". 
I add and commit both files.

Now I create a .gitignore file containing the rule "lib*/".  I modify
lib/foo.txt and lib2/bar.txt.  I do "git status" and I'm informed that
foo.txt and bar.txt are modified.  So far so good.

The following commands work as expected:
 git add lib/foo.txt
 git add lib2/bar.txt

But if I instead do:
  git add lib/foo.txt lib2/bar.txt

I get the following response:
  The following paths are ignored by one of your .gitignore files:
  lib
  lib2

I have verified this behavior in git 1.9.3 and 2.1.0.  Is this desired
behavior or is it a bug?  If it is desired behavior, could someone please
describe the utility to me?

Many thanks for your excellent work

Glen Stark

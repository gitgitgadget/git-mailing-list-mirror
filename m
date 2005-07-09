From: Marco Costalba <mcostalba@yahoo.it>
Subject: qgit-0.7
Date: Sat, 9 Jul 2005 01:15:12 -0700 (PDT)
Message-ID: <20050709081512.33503.qmail@web26306.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Jul 09 10:15:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrAUx-0003Wz-7T
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 10:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbVGIIPR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 04:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263167AbVGIIPR
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 04:15:17 -0400
Received: from web26306.mail.ukl.yahoo.com ([217.146.176.17]:39100 "HELO
	web26306.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263166AbVGIIPP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2005 04:15:15 -0400
Received: (qmail 33506 invoked by uid 60001); 9 Jul 2005 08:15:12 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=c2oec1pSpApwbXmAV89zVVU+oqWc4xLnSrmy/3yXE3dFFqHgqHWUiZLQxD0ToOiKGzr2qv6P1ivlGTFYLKvOowzR2qJhsvzoeHENxIp+DhJMKgOA13X8wXQVyANQDHkyfVypyWXzSX8iFnBdz9Ra4c5Fyaco5kkerSozJ8S/enc=  ;
Received: from [151.42.108.207] by web26306.mail.ukl.yahoo.com via HTTP; Sat, 09 Jul 2005 01:15:12 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here is qgit-0.7, a GUI git viewer.

you can download from:

http://prdownloads.sourceforge.net/qgit/qgit-0.7.tar.gz?download


This time a small changelog, but a lot of work ;-)

- rewrite of graph drawing
- start-up loading: switch to use git-rev-list --topo-order
- final fixes to annotation
- cache of file lists to speed-up loading of file names
- added color background on heads

Graph now uses connected lines and should be better to follow, 
also the switch from home grown to legacy git-rev-list --topo-order helps in
clarify revs history.

Annotation now works for me in all cases with the limitation that does not
follow renames.

When you run qgit for the first time it takes some time to git-rev-list and
git-diff-tree the repo. Following runs are faster because a persistent
cache of file names is used, so the speed is the same of just running git-rev-list.


Note: because of the use of --topo-order option in git-rev-list you need a very
recent copy of git.


For people who missed previous releases, a brief feature list:

- revisions log with diff and file viewer windows

- graph of development lines

- automatic update of all open views when navigating through lists

- filter by a substring (with wildcards support) in SHA, short log, author or paths

- colored file list window: green new file, red removed one

- patch viewer of diffs against parent, head or a mouse selected (CTRL + PRESS) rev

- file viewer with automatic annotation of content and file history

- file viewer with substring find function and jump to diff with double-click in
  annotate line

- command line arguments support using git-rev-parse

- highlight on tags and heads


As usual, to try qgit:

-unpack files
-make
-cd bin
-copy qgit in the path
-run qgit from a git working directory


Please refer to README for more information.


Marco

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

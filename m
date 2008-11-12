From: Jim Jensen <jhjjhjjhj@gmail.com>
Subject: Re: problem with git gui on cygwin.
Date: Wed, 12 Nov 2008 15:37:08 +0000 (UTC)
Message-ID: <loom.20081112T142853-15@post.gmane.org>
References: <loom.20081111T155614-227@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 12 16:39:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Ho3-00061E-UZ
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 16:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbYKLPh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 10:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbYKLPh0
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 10:37:26 -0500
Received: from main.gmane.org ([80.91.229.2]:49468 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752701AbYKLPhY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 10:37:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L0HmP-0002DN-77
	for git@vger.kernel.org; Wed, 12 Nov 2008 15:37:17 +0000
Received: from adsl-149-50-241.mia.bellsouth.net ([70.149.50.241])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Nov 2008 15:37:17 +0000
Received: from jhjjhjjhj by adsl-149-50-241.mia.bellsouth.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Nov 2008 15:37:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 70.149.50.241 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.3) Gecko/2008092417 Firefox/3.0.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100757>

Jim Jensen <jhjjhjjhj <at> gmail.com> writes:



Some further information:

git gui --trace doesn't seem to do anything.

I copied the tree from the directory it was in :
/cygdrive/c/Docume~1/dad/Desktop/cyghome/javt

to: /javt

and gitk started working.  
In this directory git-gui give the following error:

couldn't execute "C:\cygwin\usr\sbin\git-core\git-update-index.exe":
 invalid argument
couldn't execute "C:\cygwin\usr\sbin\git-core\git-update-index.exe":
 invalid
argument
    while executing
"error $err"
    (procedure "_open_stdout_stderr" line 16)
    invoked from within
"_open_stdout_stderr [concat $opt $cmdp $args"
    (procedure "git_read" line 26)
    invoked from within
"git_read update-index  -q  --unmerged  --ignore-missing  --refresh  "
    (procedure "rescan" line 39)
    invoked from within
"rescan ui_ready"
    (procedure "do_rescan" line 2)
    invoked from within
"do_rescan"
    ("after" script)

Any more ideas on things to try?

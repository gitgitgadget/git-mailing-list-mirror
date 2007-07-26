From: David Kastrup <dak@gnu.org>
Subject: git-gui problem with version number.
Date: Thu, 26 Jul 2007 13:20:02 +0200
Message-ID: <86odhzpg2l.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 13:20:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE1OS-00021n-TG
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 13:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756590AbXGZLUR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 07:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757165AbXGZLUQ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 07:20:16 -0400
Received: from main.gmane.org ([80.91.229.2]:37840 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756276AbXGZLUP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 07:20:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IE1O6-0006g5-16
	for git@vger.kernel.org; Thu, 26 Jul 2007 13:20:10 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 13:20:10 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 13:20:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:xbyTSf3+VdSW8uZ8l1k4iZ6vB8Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53818>


Hi, git-gui does not get along with the creativeness in git
versioning:

git-gui
Error in startup script: expected version number but got "1.5.3.rc2.4.g726f9-dirty"
    while executing
"package vcompare $_git_version $vr"
    ("2" arm line 4)
    invoked from within
"switch [llength $args] {
        0 {
                return $_git_version
        }

        2 {
                set op [lindex $args 0]
                set vr [lindex $args 1]
                set cm [package vcompare $_git_ver..."
    (procedure "git-version" line 4)
    invoked from within
"git-version < 1.5"
    (file "/usr/local/bin/git-gui" line 1)


-- 
David Kastrup

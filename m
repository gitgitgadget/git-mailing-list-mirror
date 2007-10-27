From: Sergei Organov <osv@javad.com>
Subject: Minor inconsistency: "git tag" requires space after -m.
Date: Sat, 27 Oct 2007 15:55:01 +0400
Message-ID: <ffv8ul$5a2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 14:16:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ilkan-0004p6-Ny
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 14:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282AbXJ0MPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 08:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbXJ0MPI
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 08:15:08 -0400
Received: from main.gmane.org ([80.91.229.2]:58787 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752220AbXJ0MPG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 08:15:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IlkZC-0002U2-RX
	for git@vger.kernel.org; Sat, 27 Oct 2007 12:15:02 +0000
Received: from 87.236.81.130 ([87.236.81.130])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Oct 2007 12:15:02 +0000
Received: from osv by 87.236.81.130 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Oct 2007 12:15:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87.236.81.130
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62485>

Hello,

It seems options parsing is somewhat broken in git-tag:

$ git tag -a -m"Annotated tag" annotated-tag
usage: git-tag [-n [<num>]] -l [<pattern>] | [-a | -s | -u <key-id>] [-f | -d | -v] [-m <msg> | -F <file>] <tagname> [<head>]
$ git tag -a -m "Annotated tag" annotated-tag
$ git --version
git version 1.5.3.4

This is inconsistent with, say, "git commit", that groks -m"Message"
(without space after -m) just fine.

-- 
Sergei.

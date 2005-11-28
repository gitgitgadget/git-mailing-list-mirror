From: Junio C Hamano <junkio@twinsun.com>
Subject: Re: 'git commit' ignoring args?
Date: Mon, 28 Nov 2005 23:44:34 +0000 (UTC)
Message-ID: <loom.20051129T003332-60@post.gmane.org>
References: <438B2F40.6070801@pobox.com> <438B8C6C.8030407@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Nov 29 00:49:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Egsj7-0000Pe-37
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 00:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVK1XsB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 18:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVK1XsB
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 18:48:01 -0500
Received: from main.gmane.org ([80.91.229.2]:11713 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932282AbVK1XsA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 18:48:00 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EgshB-0007f4-1D
	for git@vger.kernel.org; Tue, 29 Nov 2005 00:46:05 +0100
Received: from ip-66-80-53-59.lax.megapath.net ([66.80.53.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Nov 2005 00:46:05 +0100
Received: from junkio by ip-66-80-53-59.lax.megapath.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Nov 2005 00:46:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.80.53.59 (Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915 Firefox/1.0.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12910>

Andreas Ericsson <ae <at> op5.se> writes:

> The index has been updated to match the file on disk somehow (perhaps 
> you did 'git add book.xml'?).

book.xml is known to the index file at this point.  "git add book.xml" will
*not* run update-index on that path, so that is not it.

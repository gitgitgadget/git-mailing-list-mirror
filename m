From: Arnaud Bailly <arnaud.oqube@gmail.com>
Subject: Git P4 Submit issue
Date: Tue, 10 Nov 2009 08:22:58 +0000 (UTC)
Message-ID: <loom.20091110T091812-760@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 10:35:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7n86-00054U-1W
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 10:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967AbZKJJfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 04:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753441AbZKJJfA
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 04:35:00 -0500
Received: from lo.gmane.org ([80.91.229.12]:53058 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753222AbZKJJe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 04:34:59 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N7n7w-00050u-T8
	for git@vger.kernel.org; Tue, 10 Nov 2009 10:35:04 +0100
Received: from 80.125.173.63 ([80.125.173.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 10:35:04 +0100
Received: from arnaud.oqube by 80.125.173.63 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 10:35:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.125.173.63 (Mozilla/5.0 (X11; U; Linux i686; fr; rv:1.9.0.15) Gecko/2009102815 Ubuntu/9.04 (jaunty) Firefox/3.0.15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132555>

Hello,
I have been using git-p4 happily to draw revisions from P4 to git repository. I
now want to do the converse operation. What I did is the following

p4 client mad-builder 
# edit builder client view to have a local checkout 
export P4CLIENT=mad-builder
# clone bare repository to work on it
git clone mad mad.p4 
cd mad.p4
git p4 submit 
fatal: Not a valid object name HEAD~57
Command failed: git cat-file commit HEAD~57

I do not really understand what's going there excepts that obviously some object
is referenced that does not exist.

Thank you for your help

Arnaud

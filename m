From: Dan Gindikin <dgindikin@gmail.com>
Subject: new tool for git: git-blameall
Date: Mon, 6 Jun 2011 23:33:27 +0000 (UTC)
Message-ID: <loom.20110607T013117-867@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 01:35:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTjKD-0006Rn-Se
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 01:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570Ab1FFXfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 19:35:06 -0400
Received: from lo.gmane.org ([80.91.229.12]:46319 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752352Ab1FFXfF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 19:35:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QTjK3-0006MX-Ev
	for git@vger.kernel.org; Tue, 07 Jun 2011 01:35:03 +0200
Received: from cpe-66-65-140-240.nyc.res.rr.com ([66.65.140.240])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 01:35:03 +0200
Received: from dgindikin by cpe-66-65-140-240.nyc.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 01:35:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.65.140.240 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_2) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.77 Safari/534.30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175179>

I've made a script for git, it is similar to git-blame, 
but it shows every line that was ever in the file, 
along with information about when it was added or 
deleted.

It is inspired by Ned Batchelder's blameall.py for 
svn, which was inspired by a similar feature in 
Perforce.

You can download it here http://1dan.org/git-
blameall, it is a python script.

From: Csaba Henk <csaba@gluster.com>
Subject: kill filter-branch --remap-to-ancestor?
Date: Sat, 21 Aug 2010 20:32:37 +0000 (UTC)
Message-ID: <i4pd55$19q$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 21 22:50:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omv17-0006lr-JH
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 22:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815Ab0HUUuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 16:50:13 -0400
Received: from lo.gmane.org ([80.91.229.12]:46411 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517Ab0HUUuL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 16:50:11 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Omv0u-0006gI-DZ
	for git@vger.kernel.org; Sat, 21 Aug 2010 22:50:04 +0200
Received: from gluelinux.org ([195.56.45.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 22:50:04 +0200
Received: from csaba by gluelinux.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 22:50:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: gluelinux.org
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154161>

I had some headache with the issue to which the cure is the "--remap-to-ancestor" option of git filter-branch -- back when "--remap-to-ancestor" was not yet (cf. http://thread.gmane.org/gmane.comp.version-control.git/112068/focus=112838). 

This time, in a similar situation, I had some headache with finding out that the panacea is already there and it's called "--rema
p-to-ancestor".

Why not cut back on complexity and get rid of "--remap-to-ancestor" while automatically enable the implied behavior for filters including a path? This was already proposed by Junio and the author of the option had no objections against this idea (see
http://thread.gmane.org/gmane.comp.version-control.git/130949/focus=132684).

Csaba

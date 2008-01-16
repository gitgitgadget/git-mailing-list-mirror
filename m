From: Sverre Hvammen Johansen <hvammen@gmail.com>
Subject: Merging using only fast-forward
Date: Wed, 16 Jan 2008 15:54:34 +0000 (UTC)
Message-ID: <loom.20080116T151930-575@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 17:00:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFAgv-0004gC-IP
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 17:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbYAPQAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 11:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbYAPQAJ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 11:00:09 -0500
Received: from main.gmane.org ([80.91.229.2]:50143 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014AbYAPQAH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 11:00:07 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JFAgM-0005zK-Ny
	for git@vger.kernel.org; Wed, 16 Jan 2008 16:00:03 +0000
Received: from c66-235-35-214.sea2.cablespeed.com ([66.235.35.214])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 16:00:02 +0000
Received: from hvammen by c66-235-35-214.sea2.cablespeed.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 16:00:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.235.35.214 (Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70694>

Hi,


I have a work flow where A is only allowed to rebase and B is only allowed to
fast-forward.  They both fetch from each other and rebase/merge using pull.  On
A I can use the configuration branch.<name>.rebase but it does not seem to be an
option to enforce a fast-forward on B.

If there are changes on both A and B that have not yet been integrated (by A
doing a pull (fetch/rebase)) I want a pull (fetch/merge) on B to fail.

It would be useful with a configuration ala branch.<name>.fast-forward or an
option --ff-only to git-merge so I could use the configuration
branch.<name>.mergeoptions.

Is there any other way to achieve this?

Thanks for a great tool.  I am using git with accurev where B is the integrator
between git and accurev (commits flow in both directions).  I imagine this could
be useful in other environments as well.

-- 
Sverre Hvammen Johansen

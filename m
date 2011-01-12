From: Maaartin <grajcar1@seznam.cz>
Subject: Forcing re-reading files with unchanged stats
Date: Wed, 12 Jan 2011 14:07:25 +0000 (UTC)
Message-ID: <loom.20110112T150313-103@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 12 15:07:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pd1MW-0000mA-Qq
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 15:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900Ab1ALOHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 09:07:39 -0500
Received: from lo.gmane.org ([80.91.229.12]:54741 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286Ab1ALOHh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 09:07:37 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Pd1MO-0000iN-0d
	for git@vger.kernel.org; Wed, 12 Jan 2011 15:07:36 +0100
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Jan 2011 15:07:36 +0100
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Jan 2011 15:07:36 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.7.62 Version/11.00)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165015>

There are files in my working tree which changes, but their size and mtime 
remains the same (I know it's strange, but it's useful). Can I make git to re-
read them all, so it recognizes the change? Ideally, using a configuration 
variable. The repo is fairly small, so speed is no issue here.

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/4] gitweb: optimize git_get_last_activity.
Date: Fri, 22 Dec 2006 21:07:50 +0100
Organization: At home
Message-ID: <emhdpg$he9$2@sea.gmane.org>
References: <11668162952375-git-send-email-robfitz@273k.net> <11668162961084-git-send-email-robfitz@273k.net> <11668162963671-git-send-email-robfitz@273k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Dec 22 21:10:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxqik-0000A8-Gs
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 21:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbWLVUKT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 15:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbWLVUKS
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 15:10:18 -0500
Received: from main.gmane.org ([80.91.229.2]:38061 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526AbWLVUKR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 15:10:17 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GxqiQ-0001ek-Pb
	for git@vger.kernel.org; Fri, 22 Dec 2006 21:10:02 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 21:10:02 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 21:10:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35206>

Robert Fitzsimons wrote:

> Only return one line of output and we don't need the refname value.

Refname doesn't hurt and we have it "for free" (meaning: we have to
calculate it anyway to get commiterepoch). Although we do not use it.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

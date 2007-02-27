From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] Make 'cvs ci' lockless in git-cvsserver by using git-update-ref
Date: Tue, 27 Feb 2007 14:55:09 +0100
Organization: At home
Message-ID: <es1d3n$kt6$1@sea.gmane.org>
References: <200702210908.59579.andyparkins@gmail.com> <200702271248.59652.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 14:53:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM2lo-0001Ja-Mk
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 14:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbXB0NxW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 08:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbXB0NxW
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 08:53:22 -0500
Received: from main.gmane.org ([80.91.229.2]:44910 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbXB0NxV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 08:53:21 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HM2lT-00025T-97
	for git@vger.kernel.org; Tue, 27 Feb 2007 14:53:11 +0100
Received: from host-89-229-2-22.torun.mm.pl ([89.229.2.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 14:53:11 +0100
Received: from jnareb by host-89-229-2-22.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 14:53:11 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-2-22.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40733>

Andy Parkins wrote:

> ---
> This patch is actually yours (with one extra removal of lock file reference
> that you'd missed, and a change of shortlog), but I don't know how to send
> an email that comes from me but attributes authorship to you.

You just leave From: header in the body of message...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

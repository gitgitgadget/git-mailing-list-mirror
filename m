From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] Teach rev-list an option to read revs from the standard input.
Date: Wed, 06 Sep 2006 11:12:02 +0200
Organization: At home
Message-ID: <edm3ce$c4e$1@sea.gmane.org>
References: <7v64g1a9f7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 06 11:12:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKtSJ-0003TG-0f
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 11:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWIFJMT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 05:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWIFJMT
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 05:12:19 -0400
Received: from main.gmane.org ([80.91.229.2]:64724 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750722AbWIFJMS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 05:12:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GKtRw-0003NX-9V
	for git@vger.kernel.org; Wed, 06 Sep 2006 11:12:00 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 11:12:00 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 11:12:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26510>

Junio C Hamano wrote:

> Note that you still have to give all the flags from the command
> line; only rev arguments (including A..B, A...B, and A^@ notations)
> can be give from the standard input.

Does this include ^A notation?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 09/13] Replace inefficient new String(String) constructor to silence FindBugs
Date: Wed, 29 Apr 2009 22:10:49 +0200
Message-ID: <200904292210.49627.robin.rosenberg.lists@dewire.com>
References: <1240953146-12878-1-git-send-email-spearce@spearce.org> <1240953146-12878-9-git-send-email-spearce@spearce.org> <1240953146-12878-10-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Yann Simon <yann.simon.fr@gmail.com>,
	Matthias Sohn <matthias.sohn@sap.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 29 22:11:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzG7b-0002dH-La
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 22:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880AbZD2ULB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 16:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753524AbZD2UK7
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 16:10:59 -0400
Received: from mail.dewire.com ([83.140.172.130]:10538 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752347AbZD2UK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 16:10:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 181B11023426;
	Wed, 29 Apr 2009 22:10:55 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KAuVevVmUi2B; Wed, 29 Apr 2009 22:10:53 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 61A001023457;
	Wed, 29 Apr 2009 22:10:53 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1240953146-12878-10-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117937>

tisdag 28 april 2009 23:12:22 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> FindBugs keeps reporting that our usage of new String(String)
> is not the most efficient way to construct a string.
> 

I think we should find better ways of silencing FindBugs,, than addiing obscure
coding patterns that are worse than what FindBugs warns against. 

Options are: 
	Add a comment 
	Customize findbugs rules
	Findbugs specific annotations

-- robin

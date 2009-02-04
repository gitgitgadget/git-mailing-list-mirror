From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH JGIT] Compute the author/commiter name and email from the git configuration
Date: Wed, 4 Feb 2009 01:55:14 +0100
Message-ID: <200902040155.15206.robin.rosenberg.lists@dewire.com>
References: <1233695594.8042.6.camel@localhost> <20090203231357.GZ26880@spearce.org> <alpine.DEB.1.00.0902040019030.9822@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Yann Simon <yann.simon.fr@gmail.com>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 04 01:57:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUW4Z-0007u4-6R
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 01:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbZBDAzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 19:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbZBDAzX
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 19:55:23 -0500
Received: from mail.dewire.com ([83.140.172.130]:13037 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbZBDAzX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 19:55:23 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A33BF147E860;
	Wed,  4 Feb 2009 01:55:16 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YxD8EtE2Rktd; Wed,  4 Feb 2009 01:55:16 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 3237B147E7FF;
	Wed,  4 Feb 2009 01:55:16 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <alpine.DEB.1.00.0902040019030.9822@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108281>

onsdag 04 februari 2009 00:20:03 skrev Johannes Schindelin:
> According to
> 
> http://java.sun.com/j2se/1.4.2/docs/api/java/lang/System.html#getenv(java.lang.String)
> 
> getenv() is deprecated.  However, in later editions (Java5 and later, to 
> be precise), that deprecation seems to be lifted...

It was worse, it wasn't even implemented. You got a runtime exception back then (1.3 or 1.4).
So now it's fine.

-- robin

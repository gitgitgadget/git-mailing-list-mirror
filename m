From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 2/6] Add remote.name.timeout to configure an IO timeout
Date: Sun, 21 Jun 2009 00:28:48 +0200
Message-ID: <200906210028.48954.robin.rosenberg.lists@dewire.com>
References: <1245446875-31102-1-git-send-email-spearce@spearce.org> <1245446875-31102-2-git-send-email-spearce@spearce.org> <1245446875-31102-3-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jun 21 00:29:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MI93d-0000yM-Hs
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 00:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755005AbZFTW27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 18:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754900AbZFTW26
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 18:28:58 -0400
Received: from mail.dewire.com ([83.140.172.130]:26449 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754741AbZFTW25 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 18:28:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 11A50147D72E;
	Sun, 21 Jun 2009 00:28:57 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LOvDBfbIRcnh; Sun, 21 Jun 2009 00:28:51 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 20388147D72B;
	Sun, 21 Jun 2009 00:28:50 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1245446875-31102-3-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121956>

fredag 19 juni 2009 23:27:51 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> An IO timeout can be useful if the remote peer stops responding,
> and the user wants the application to abort rather than block
> indefinitely waiting for more input.
> 
> This is a JGit specific extension to the standard remote format.

Can we we assume C Git won't implement the same thing with a different 
parameter name, or worse, the same name, but a different unit?

-- robin

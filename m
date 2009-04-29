From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 10/13] Replace inefficient new Long(long) constructor to silence FindBugs
Date: Wed, 29 Apr 2009 21:45:34 +0200
Message-ID: <200904292145.34462.robin.rosenberg@dewire.com>
References: <1240953146-12878-1-git-send-email-spearce@spearce.org> <1240953146-12878-10-git-send-email-spearce@spearce.org> <1240953146-12878-11-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Yann Simon <yann.simon.fr@gmail.com>,
	Matthias Sohn <matthias.sohn@sap.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 29 22:11:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzG7c-0002dH-Ce
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 22:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755365AbZD2ULC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 16:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbZD2ULB
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 16:11:01 -0400
Received: from mail.dewire.com ([83.140.172.130]:10537 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668AbZD2UK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 16:10:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 08C8A139A478;
	Wed, 29 Apr 2009 22:10:54 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vw3edvGc72Vr; Wed, 29 Apr 2009 22:10:53 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 3ECC51023426;
	Wed, 29 Apr 2009 22:10:53 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1240953146-12878-11-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117936>

tisdag 28 april 2009 23:12:23 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> We now use a custom Map implementation which supports primitive long
> as the hash key, rather than requiring boxing for java.util.HashMap.
> This removes the issue FindBugs was identifying.

No unit test for LongMap?

-- robin

From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 2/5] Add copy(InputStream) to TemporaryBuffer
Date: Thu, 11 Dec 2008 16:40:34 +0100
Message-ID: <200812111640.34435.robin.rosenberg@dewire.com>
References: <1228971522-28764-1-git-send-email-spearce@spearce.org> <1228971522-28764-2-git-send-email-spearce@spearce.org> <1228971522-28764-3-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 16:46:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAnjP-0008JJ-OT
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 16:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755826AbYLKPoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 10:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755669AbYLKPoW
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 10:44:22 -0500
Received: from mail.dewire.com ([83.140.172.130]:15333 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755569AbYLKPoV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 10:44:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 554CC147E53C;
	Thu, 11 Dec 2008 16:44:15 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GueabWKsLCu8; Thu, 11 Dec 2008 16:44:14 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id C8205147E512;
	Thu, 11 Dec 2008 16:44:14 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <1228971522-28764-3-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102799>

torsdag 11 december 2008 05:58:39 skrev Shawn O. Pearce:
> In some places we may find it ourselves with an InputStream we
> need to copy into a TemporaryBuffer, so we can flatten out the
> entire stream to a single byte[].  Putting the copy loop here
> is more useful then duplicating it in application level code.
> +	public void copy(final InputStream in) throws IOException {
> +		final byte[] b = new byte[2048];
Why not 8192 here too?

-- robin

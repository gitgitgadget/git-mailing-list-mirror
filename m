From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 02/10] Expose the raw path for the current entry of a TreeWalk
Date: Fri, 23 Jan 2009 22:42:14 +0100
Message-ID: <200901232242.15073.robin.rosenberg.lists@dewire.com>
References: <1232666890-23488-1-git-send-email-spearce@spearce.org> <1232666890-23488-2-git-send-email-spearce@spearce.org> <1232666890-23488-3-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 23 22:44:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQToT-0005ts-Qn
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 22:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755759AbZAWVmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 16:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755588AbZAWVmR
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 16:42:17 -0500
Received: from mail.dewire.com ([83.140.172.130]:24595 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755538AbZAWVmR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 16:42:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 09A85147E6F7;
	Fri, 23 Jan 2009 22:42:16 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2HOo6c6f2exb; Fri, 23 Jan 2009 22:42:15 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 8E9048026F3;
	Fri, 23 Jan 2009 22:42:15 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <1232666890-23488-3-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106919>

fredag 23 januari 2009 00:28:02 skrev Shawn O. Pearce:
> Copying the path byte array (keeping it encoded in UTF-8) is quicker
> than converting to String and then back again to UTF-8 when creating
> a DirCacheEntry for the current position in a TreeWalk.
[...]
> +	 * Get the current entry's complete path as a UTF-8 byte array.
/Hopefully/ UTF-8. It is often a legacy encoding, like ISO-8859-X, CP12xx
etc. I'll come up with something less specific that just UTF-8.

-- robin

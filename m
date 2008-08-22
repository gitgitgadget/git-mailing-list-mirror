From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 1/4] Simplify and micro-optimize WorkingTreeIterator.ENTRY_CMP
Date: Fri, 22 Aug 2008 22:45:08 +0200
Message-ID: <200808222245.08814.robin.rosenberg.lists@dewire.com>
References: <1219352258-15431-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 22:48:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWdY3-0006lL-1z
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 22:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbYHVUqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 16:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbYHVUqt
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 16:46:49 -0400
Received: from av9-1-sn2.hy.skanova.net ([81.228.8.179]:53341 "EHLO
	av9-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbYHVUqt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 16:46:49 -0400
Received: by av9-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id C465938165; Fri, 22 Aug 2008 22:46:47 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av9-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id A7C6238073; Fri, 22 Aug 2008 22:46:47 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 25B2937E44;
	Fri, 22 Aug 2008 22:46:47 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1219352258-15431-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93361>

torsdagen den 21 augusti 2008 22.57.35 skrev Shawn O. Pearce:
> We already did this simplification work to AbstractTreeIterator's
> pathCompare method, and this is based upon that same structure.

I noticed we have very bad code coverage in unit tests in this area of the code. 
Maybe we should increase the coverage before optimizing. I'll accept the patches
anyway and pray they are ok.

-- robin

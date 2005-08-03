From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Users of git-check-files?
Date: Wed, 3 Aug 2005 19:46:50 +0200
Message-ID: <200508031946.50172.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0508031849270.24318@wgmdd8.biozentrum.uni-wuerzburg.de> <200508031908.22562.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 03 19:48:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0NKw-0002YA-BA
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 19:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVHCRrR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 13:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVHCRrR
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 13:47:17 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:34781 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S262370AbVHCRrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 13:47:16 -0400
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <200508031908.22562.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wednesday 03 August 2005 19:08, you wrote:
> Yes it is. To reproduce:

You do not need 2 clones.
It is enough to have one clone with a branch, and you make a commit in the 
original repository.
Afterwards, pushing a new commit from the clone gives the error.

After pulling the missing commit from the original rep, the push works.

Josef

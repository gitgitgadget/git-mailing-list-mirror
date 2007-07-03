From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] git-repack: generational repacking (and example hook
 script)
Date: Mon, 02 Jul 2007 23:36:47 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707022331080.26459@xanadu.home>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822346-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823184-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823982-git-send-email-sam.vilain@catalyst.net.nz>
 <1183193782172-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822249-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823756-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822950-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937823588-git-send-email-sam.vilain@catalyst.net.nz>
 <1183193782608-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Jul 03 05:37:04 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5ZCF-0001hK-FI
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 05:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303AbXGCDgt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 23:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753072AbXGCDgt
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 23:36:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:56030 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802AbXGCDgs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 23:36:48 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JKL004E23DBETI0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 02 Jul 2007 23:36:47 -0400 (EDT)
In-reply-to: <1183193782608-git-send-email-sam.vilain@catalyst.net.nz>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51446>

On Sat, 30 Jun 2007, Sam Vilain wrote:

> Add an option to git-repack that makes the repack run suitable for
> running very often.  The idea is that packs get given a "generation",
> and that the number of packs in each generation (except the last one)
> is bounded.

Please explain again why this should be useful and is worth the 
complexity it brings along.  Last time this was discussed I wasn't 
convinced at all, and I'm still not convinced this time either.


Nicolas

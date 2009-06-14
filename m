From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: Re: [JGIT PATCH 2/2] Allow core.packedGitLimit to exceed "2 g"
Date: Sun, 14 Jun 2009 10:49:40 +0200
Message-ID: <4A34B9A4.7020702@pelagic.nl>
References: <1244848986-10526-1-git-send-email-spearce@spearce.org> <1244848986-10526-2-git-send-email-spearce@spearce.org> <4A335B9A.7080808@pelagic.nl> <20090613191943.GS16497@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jun 14 10:49:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFlPV-0004YX-4S
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 10:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbZFNItl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 04:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbZFNItl
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 04:49:41 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:45800 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750947AbZFNItl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jun 2009 04:49:41 -0400
Received: from [192.168.0.51] (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 086C358BDF7;
	Sun, 14 Jun 2009 10:49:41 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090613191943.GS16497@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121547>

> If you looked at that, 2,000,000,000 is within the range of an int.
> We select the smallest value.  The first argument expression is
> computed as a long, so we shouldn't ever overflow and cause the
> first argument to be negative.  If the first argument is larger
> than 2 billion, then it does risk overflow, but the 2nd argument
> is smaller, so it is returned.
> 
> The code is fine as is.
>  

I stand corrected :-)

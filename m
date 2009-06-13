From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: Re: [JGIT PATCH] Fix CanonicalTreeParser.back to parse all trees
 correctly
Date: Sat, 13 Jun 2009 10:06:46 +0200
Message-ID: <4A335E16.1050903@pelagic.nl>
References: <1244412116-13294-1-git-send-email-spearce@spearce.org> <20090612150801.GA17538@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jun 13 10:07:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFOGX-00069j-3J
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 10:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575AbZFMIGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 04:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbZFMIGs
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 04:06:48 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:47958 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750997AbZFMIGq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2009 04:06:46 -0400
Received: from [192.168.0.51] (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 1CFA158BDF7;
	Sat, 13 Jun 2009 10:06:47 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090612150801.GA17538@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121487>

Shawn O. Pearce wrote:
> "Shawn O. Pearce" <spearce@spearce.org> wrote:
>> The back(int delta) method needs to walk backwards delta entries in
>> the tree we are iterating.  Unfortunately, despite my attempts to do
>> so, there is no reliable way to parse a canonical tree in reverse.
> 
> Ping?
> 

looks good to me

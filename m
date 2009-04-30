From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [JGIT RFC PATCH 2/2] Rewrite WindowCache to be easier to	follow
 and maintain
Date: Thu, 30 Apr 2009 09:34:55 +0200
Message-ID: <49F9549F.3000702@pelagic.nl>
References: <1240885572-1755-1-git-send-email-spearce@spearce.org> <1240885572-1755-2-git-send-email-spearce@spearce.org> <200904290120.00039.robin.rosenberg.lists@dewire.com> <20090429171659.GF23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Apr 30 09:35:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzQo2-00008t-Nj
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 09:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756270AbZD3He6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 03:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755776AbZD3He6
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 03:34:58 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:46392 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753074AbZD3He5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2009 03:34:57 -0400
Received: from [192.168.0.51] (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 5C21258BD9F;
	Thu, 30 Apr 2009 09:34:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090429171659.GF23604@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117995>

Shawn O. Pearce wrote:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
>>> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/OffsetCache.java
>>> +	private void gc() {
>>> +		R r;
>>> +		while ((r = (R) queue.poll()) != null) {
>>> +			// Sun's Java 5 and 6 implementation have a bug where a Reference
>>> +			// can be enqueued and dequeued twice on the same reference queue
>>> +			// due to a race condition within ReferenceQueue.enqueue(Reference).
>> Reference to the official Sun bug? Might help if someone wants to
>> implement a flag to avoid this (if necessary...)
> 
> Actually, this is a new bug.  I tried looking through BugParade
> but nobody has mentioned or discovered this before.
> 
> I submitted a bug report yesterday, but they have yet to publish it.
> 

maybe you can also submit it to the OpenJDK folks? I have very bad
experiences with reporting java bugs to sun. I reported a few and
_never_ heard back from them, no publish of the bug, no reject, nothing.


Great work on rewriting this!
PS. still need your input on ignores :-)

From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [JGIT PATCH 8/6] Fix zero context insert and delete hunk headers
 to match CGit
Date: Sun, 03 May 2009 10:31:30 +0200
Message-ID: <49FD5662.9070004@pelagic.nl>
References: <20090503000540.GN23604@spearce.org> <20090503001423.GO23604@spearce.org> <8763gjdn6r.fsf@catnip.gol.com> <200905031025.53084.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Miles Bader <miles@gnu.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun May 03 10:31:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0X6v-0002NB-O3
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 10:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbZECIbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 04:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754853AbZECIbc
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 04:31:32 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:52849 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752565AbZECIbb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 May 2009 04:31:31 -0400
Received: from [192.168.0.50] (Paul.internal.Hupie.com [192.168.0.50])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 3E0C758BD9F;
	Sun,  3 May 2009 10:31:31 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <200905031025.53084.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118169>

> 3) We should have a convention like C Git for marking known breakages.
> One option is FIXME, another it so go JUnit 4 and abuse the expected exception 
> annotation (using it for declaring OK exceptions is pretty bad use anyway I think,
> so we might use it for something better), or perhaps the @Ignore annotation which
> is meant specifically for this and other cases. A FIXME can be implemented right
> away.

standard pratice for junit would be to write a test case on what you would 
expect to be _correct_ behaviour. obviously that test would then fail.
it would be a know failure in the test suite. do not go ignoring it. it's 
better to keep being reminded that stuff doesn't work :-)

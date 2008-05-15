From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] builtin-clone: fix initial checkout
Date: Thu, 15 May 2008 15:53:45 -0400
Message-ID: <B29804AB-7A06-4988-9C5F-27A5499601B5@sb.org>
References: <BB5BF79E-ECAE-4F63-AFF1-8C13F23D3D10@sb.org> <20080515044402.GA3517@sigill.intra.peff.net> <20080515045026.GA26161@sigill.intra.peff.net> <alpine.DEB.1.00.0805151042570.30431@racer>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 15 21:55:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwjY8-0005Kg-SC
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 21:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764294AbYEOTxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 15:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759525AbYEOTxu
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 15:53:50 -0400
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:49002 "EHLO
	randymail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1762513AbYEOTxt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 May 2008 15:53:49 -0400
Received: from [192.168.0.203] (c-24-91-11-245.hsd1.nh.comcast.net [24.91.11.245])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a4.g.dreamhost.com (Postfix) with ESMTP id EC47519597D;
	Thu, 15 May 2008 12:53:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805151042570.30431@racer>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82226>

On May 15, 2008, at 5:48 AM, Johannes Schindelin wrote:

> Somewhere in the process of finishing up builtin-clone, the update of
> the working tree was lost.  This was due to not using the option  
> "merge"
> for unpack_trees().
>
> Breakage noticed by Kevin Ballard.
>
> Test by Jeff King.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

This patch fixes the issue for me. Thanks!

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com

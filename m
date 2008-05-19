From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Two minor tweaks on git-gui where textboxes weren't vertically centered with their labels and buttons
Date: Mon, 19 May 2008 00:07:46 -0400
Message-ID: <20080519040746.GA29038@spearce.org>
References: <412a1d9a0805172218v7c0a920es8a48129014051a35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Twiinz <twiinz@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 06:08:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxwfx-0001Dj-8o
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 06:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbYESEHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 00:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbYESEHu
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 00:07:50 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59443 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbYESEHu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 00:07:50 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jxwet-0003Gs-H6; Mon, 19 May 2008 00:07:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E5C5720FBAE; Mon, 19 May 2008 00:07:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <412a1d9a0805172218v7c0a920es8a48129014051a35@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82409>

Twiinz <twiinz@gmail.com> wrote:
> In git-gui after clicking either on 'Create New Repository' or 'Open
> Existing Repository' the form elements aren't centered like they are
> pretty much everywhere else in the app. At least when ran on a mac,
> haven't checked on other platforms.
> 
> Using grid instead of pack seems to fix this.

Thanks.  This is a reasonable solution.  Signed-off-by tag?  Do you
want the attribution to be just "Twiinz <twiinz@gmail.com>"?

I ask because the patch is a valid patch and it does apply, but it
isn't a standard git patch and wasn't sent inline, so git-am wasn't
able to extract and apply everything for me automagically.

-- 
Shawn.

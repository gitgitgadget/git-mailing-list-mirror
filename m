From: Joe Perches <joe@perches.com>
Subject: Re: [RFC/PATCH] Update coding standard to avoid ungrepable printk
	format strings
Date: Fri, 22 Feb 2008 08:58:30 -0800
Message-ID: <1203699510.19319.56.camel@localhost>
References: <20080222132612.GA11717@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
	git <git@vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Fri Feb 22 17:59:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSbFP-0004Zz-Hd
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 17:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759424AbYBVQ65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 11:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757731AbYBVQ64
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 11:58:56 -0500
Received: from 136-022.dsl.labridge.com ([206.117.136.22]:3529 "EHLO
	mail.perches.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753981AbYBVQ6z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 11:58:55 -0500
Received: from [192.168.1.129] (192-168-1-129.labridge.com [192.168.1.129] (may be forged))
	by mail.perches.com (8.9.3/8.9.3) with ESMTP id IAA26287;
	Fri, 22 Feb 2008 08:54:59 -0800
In-Reply-To: <20080222132612.GA11717@basil.nowhere.org>
X-Mailer: Evolution 2.12.0-2mdv2008.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74734>

On Fri, 2008-02-22 at 14:26 +0100, Andi Kleen wrote:
> RFC: Update coding standard to avoid split up printk format strings

Perhaps it's more useful to have git become more content aware.

If git could track user specified file glob pattern ("*.[ch]$")
changes by statement terminator (";") and git could format
output by a user specified pass (lindent), many of the bike shed
paint discussions and a lot of commits would never occur.

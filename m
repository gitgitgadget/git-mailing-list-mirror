From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] add -p: prompt for single characters
Date: Mon, 2 Feb 2009 08:19:00 -0500
Message-ID: <20090202131900.GC8487@sigio.peff.net>
References: <1233520511-13061-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Suraj N. Kurapati" <sunaku@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 02 14:20:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTyil-0004Zu-OK
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 14:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386AbZBBNSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 08:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753486AbZBBNSt
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 08:18:49 -0500
Received: from peff.net ([208.65.91.99]:48600 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753228AbZBBNSt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 08:18:49 -0500
Received: (qmail 8585 invoked by uid 1000); 2 Feb 2009 13:19:00 -0000
Content-Disposition: inline
In-Reply-To: <1233520511-13061-1-git-send-email-trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108083>

On Sun, Feb 01, 2009 at 09:35:11PM +0100, Thomas Rast wrote:

> I wrote this on the train today, but it turns out a similar idea was
> already around earlier:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/100146
> 
> I can't find the v4 promised there, so I assume Suraj dropped it.

It looks like you addressed the concerns I had with the original. I do
think, as Junio mentioned, that it makes sense for this to be
configurable. Because it's interactive by defintion, I don't know if we
have the same compatibility concerns that we usually do. So I'm not sure
if such a config option should default to off or on.

-Peff

From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: cg-mv
Date: Wed, 12 Oct 2005 15:14:22 +0200
Message-ID: <200510121514.22276.Josef.Weidendorfer@gmx.de>
References: <20051007143333.GA18843@tumblerings.org> <20051012100757.GM30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Oct 12 15:17:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPgRe-0005Ak-5L
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 15:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbVJLNOz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 09:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbVJLNOz
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 09:14:55 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:47834 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751449AbVJLNOy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 09:14:54 -0400
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id D5E952350
	for <git@vger.kernel.org>; Wed, 12 Oct 2005 15:14:50 +0200 (MEST)
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <20051012100757.GM30889@pasky.or.cz>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10022>

On Wednesday 12 October 2005 12:07, Petr Baudis wrote:
> so it should keep the file under the original name as well, but
> untraced? That's weird. What about
>
> 	#!/usr/bin/env bash
>
> 	if [ -e $2 ]; then
> 		! got_parameter -f && die "dest exists"
> 		[ -e $1 ] || die "no source nor destination"
> 	fi
> 	( [ -e $1 ] && mv $1 $2 ) && cg-add $2 && cg-rm $1
>
> plus quoting and stuff?

Wishlist...
Please make it similar to mv:
* Rename directories, too
* If last argument is an existing directory
  move given files/directories into that directory

Josef

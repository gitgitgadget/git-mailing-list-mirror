From: linux@horizon.com
Subject: Re: git-name-rev off-by-one bug
Date: 30 Nov 2005 01:09:06 -0500
Message-ID: <20051130060906.13277.qmail@science.horizon.com>
References: <Pine.LNX.4.64.0511292031280.3099@g5.osdl.org>
Cc: git@vger.kernel.org, linux@horizon.com, pasky@suse.cz
X-From: git-owner@vger.kernel.org Wed Nov 30 07:24:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhL9U-0006SO-EN
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 07:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbVK3GJJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 01:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbVK3GJJ
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 01:09:09 -0500
Received: from science.horizon.com ([192.35.100.1]:28993 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750882AbVK3GJH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 01:09:07 -0500
Received: (qmail 13278 invoked by uid 1000); 30 Nov 2005 01:09:06 -0500
To: junkio@cox.net, torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.64.0511292031280.3099@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12988>

> +-0 -1 -2::
> +	When an unmerged entry is seen, diff against the base version,
> +	the "first branch" or the "second branch" respectively.
> +
> +	The default is to diff against the first branch.
> +

Er... why are these flags zero-based?

git-ls-files -s displays them as "1", "2" and "3".  All the docs talk
about "stage1", "stage2" and "stage3".

Change the nomenclature if you want, but this mixed messages business is
kind of weird...

(Heartened by the response to my previous question of "why do you do
this thing that makes no sense to me", I'm going to be bold and not ask
why this is a good idea.)

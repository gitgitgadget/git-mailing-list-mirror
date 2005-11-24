From: Ryan Anderson <ryan@michonline.com>
Subject: Re: gitweb on kernel.org and UTF-8
Date: Thu, 24 Nov 2005 00:01:04 -0500
Message-ID: <20051124050104.GC16995@mythryan2.michonline.com>
References: <7vzmnw9qo0.fsf@assigned-by-dhcp.cox.net> <4383BEE4.1060800@zytor.com> <20051123033526.GA24098@vrfy.org> <7vfypm20eh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 06:01:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef9EW-0003cj-2b
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 06:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbVKXFBM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 00:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030495AbVKXFBM
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 00:01:12 -0500
Received: from mail.autoweb.net ([198.172.237.26]:32484 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1030459AbVKXFBL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 00:01:11 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1Ef9EG-0005d2-W7; Thu, 24 Nov 2005 00:01:06 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Ef9EG-0000hB-00; Thu, 24 Nov 2005 00:01:04 -0500
Received: from ryan by mythical with local (Exim 4.54)
	id 1Ef9EG-0003cV-A2; Thu, 24 Nov 2005 00:01:04 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfypm20eh.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12675>

On Wed, Nov 23, 2005 at 07:24:38PM -0800, Junio C Hamano wrote:
> 
> How about doing something like this?
> 
> 	[i18n]
>         	commitEncoding = utf8
> 		blobEncoding = utf8
> 
> to mean:
> 
> 	If you _have_ to make an assumption on an encoding
> 	commit and blob objects are in, utf8 is your best bet
> 	(but mistakes can happen, and some blobs can be binary).

The rest of the options help clarify this, but can you make these
options 'assumeCommitEncoding' and 'assumeBlobEncoding' to make it clear
that these are *assumptions* and not actually controlling what gets
written?


-- 

Ryan Anderson
  sometimes Pug Majere

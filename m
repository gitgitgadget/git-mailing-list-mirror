X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Documentation/git-commit: rewrite to make it more end-user
 friendly.
Date: Sat, 09 Dec 2006 17:26:51 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612091718190.2630@xanadu.home>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0612082141260.2630@xanadu.home>
 <7vd56tei20.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0612091517010.2630@xanadu.home>
 <7vpsas91e5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sat, 9 Dec 2006 22:27:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vpsas91e5.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33844>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtAel-0001dz-E2 for gcvg-git@gmane.org; Sat, 09 Dec
 2006 23:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758519AbWLIW0w (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 17:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758846AbWLIW0w
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 17:26:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:13428 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1758519AbWLIW0w (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 17:26:52 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JA100BYS2CRD2C0@VL-MO-MR003.ip.videotron.ca> for git@vger.kernel.org; Sat,
 09 Dec 2006 17:26:51 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sat, 9 Dec 2006, Junio C Hamano wrote:

> Attached is an incremental patch on top of what you commented
> on.
> 
[...]
>  <file>...::
> -	Files to be committed.  The meaning of these is
> -	different between `--include` and `--only`.  Without
> -	either, it defaults `--only` semantics.
> +	When files are given on the command line, the command
> +	commits the contents of the named files, without
> +	recording the changes already staged.  The contents of
> +	these files are also staged for the next commit on top
> +	of what have been staged before.

Might something like "When -i is provided however..." be missing in the 
above?  Otherwise it is rather confusing.

Besides that I'm really happy with the result.



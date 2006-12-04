X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: selective git-update-index per diff(1) chunks
Date: Mon, 04 Dec 2006 18:33:18 +0100
Message-ID: <20061204173318.GG940MdfPADPa@greensroom.kotnet.org>
References: <b6fcc0a0612010323x7554e47m5e6bdafe85fc8224@mail.gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Mon, 4 Dec 2006 17:33:32 +0000 (UTC)
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <b6fcc0a0612010323x7554e47m5e6bdafe85fc8224@mail.gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33206>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrHh0-0004Vo-Aq for gcvg-git@gmane.org; Mon, 04 Dec
 2006 18:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758405AbWLDRdX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 12:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758497AbWLDRdX
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 12:33:23 -0500
Received: from psmtp02.wxs.nl ([195.121.247.11]:49848 "EHLO psmtp02.wxs.nl"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1758398AbWLDRdW
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 12:33:22 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl
 [84.81.90.170]) by psmtp02.wxs.nl (iPlanet Messaging Server 5.2 HotFix 2.07
 (built Jun 24 2005)) with SMTP id <0J9R007S0FFI41@psmtp02.wxs.nl> for
 git@vger.kernel.org; Mon, 04 Dec 2006 18:33:19 +0100 (MET)
Received: (qmail 22677 invoked by uid 500); Mon, 04 Dec 2006 17:33:18 +0000
To: Alexey Dobriyan <adobriyan@gmail.com>
Sender: git-owner@vger.kernel.org

On Fri, Dec 01, 2006 at 02:23:14PM +0300, Alexey Dobriyan wrote:
> Has anyone thought about aggregating this into git-update-index or
> somewhere?
> 
>    git-update-index -C1,3    #chunks 1, 3
>    git commit
>    git-update-index -C1,3    # chunks 2,5 in original numbering
>    git commit
> 
> Relying on diff(1) definition of chunks is sorta hacky, though... I admit 
> it.

Paul Mackerras modified his dirdiff tool to do something like this.
I have a couple of patches on top of his version from way back at
http://www.liacs.nl/~sverdool/gitweb.cgi?p=dirdiff.git;a=summary

I don't know if he has continued working on this.


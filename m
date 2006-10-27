X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: fetching packs and storing them as packs
Date: Fri, 27 Oct 2006 12:05:59 -0400
Message-ID: <20061027160559.GB3670@fieldses.org>
References: <45413209.2000905@tromer.org> <Pine.LNX.4.64.0610262038320.11384@xanadu.home> <20061027014229.GA28407@spearce.org> <45417205.6020805@tromer.org> <20061027030054.GB28407@spearce.org> <Pine.LNX.4.64.0610271022240.11384@xanadu.home> <20061027143854.GC20017@pasky.or.cz> <20061027144839.GB32451@fieldses.org> <20061027150334.GD20017@pasky.or.cz> <20061027160450.GA3670@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 16:31:45 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Shawn Pearce <spearce@spearce.org>,
	Eran Tromer <git2eran@tromer.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061027160450.GA3670@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30334>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdUDl-0008W2-J1 for gcvg-git@gmane.org; Fri, 27 Oct
 2006 18:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751111AbWJ0QGJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 12:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbWJ0QGJ
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 12:06:09 -0400
Received: from mail.fieldses.org ([66.93.2.214]:57809 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S1751111AbWJ0QGI
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 12:06:08 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GdUDX-0001ey-VI; Fri, 27 Oct 2006
 12:05:59 -0400
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

On Fri, Oct 27, 2006 at 12:04:50PM -0400, bfields wrote:
> I think if you expect x commits per hour, and need y hours to prune,
> then you should be able to get a worst-case estimate of hours between
> y-hour gaps from
> 
> 	octave -q --eval "1/poisscdf(0,x/y)"

Uh, sorry, that should be x*y, not x/y....


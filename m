X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 1/2] Allow '-' in config variable names
Date: Mon, 30 Oct 2006 22:05:56 -0500
Message-ID: <20061031030556.GB16445@fieldses.org>
References: <Pine.LNX.4.64.0610300823250.25218@g5.osdl.org> <7vodrtv2wy.fsf@assigned-by-dhcp.cox.net> <7vfyd5rxvg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 03:06:09 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vfyd5rxvg.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30563>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gejwy-0005AW-CX for gcvg-git@gmane.org; Tue, 31 Oct
 2006 04:06:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161413AbWJaDGA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 22:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161433AbWJaDGA
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 22:06:00 -0500
Received: from mail.fieldses.org ([66.93.2.214]:40154 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S1161413AbWJaDF7
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 22:05:59 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1Gejwq-0004ed-6F; Mon, 30 Oct 2006
 22:05:56 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Mon, Oct 30, 2006 at 07:02:27PM -0800, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> > By the way, everybody seems to do "alias.xxx = -p cat-file -p"
> > (I have it as "git less").  Maybe we would want to make a
> > built-in alias for that?
> 
> Seconds?

Yes!

I'd vote for calling it just "git cat".


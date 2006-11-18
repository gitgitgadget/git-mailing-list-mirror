X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Fix git-for-each-refs broken for tags
Date: Sat, 18 Nov 2006 05:54:31 +0100
Message-ID: <20061118045431.GL7201@pasky.or.cz>
References: <20061118025652.2970.10571.stgit@machine.or.cz> <7v4psxfjmw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 04:54:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v4psxfjmw.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31755>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlIDs-0004Dp-EO for gcvg-git@gmane.org; Sat, 18 Nov
 2006 05:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753882AbWKREyd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 23:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753891AbWKREyd
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 23:54:33 -0500
Received: from w241.dkm.cz ([62.24.88.241]:23525 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1753882AbWKREyc (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 23:54:32 -0500
Received: (qmail 12199 invoked by uid 2001); 18 Nov 2006 05:54:31 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sat, Nov 18, 2006 at 05:45:11AM CET, Junio C Hamano wrote:
> Thanks for noticing.
> 
> This is not like rev-list where we walk all over the map of
> ancestry graph, so it might be a simpler and better to keep
> the buffer than to keep duplicate copies of pieces.

I would rather not do that in any new code since it's gonna be a problem
if you use this outside of the standalone command as part of libgit.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."

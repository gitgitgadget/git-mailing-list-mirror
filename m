X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: should git download missing objects?
Date: Tue, 14 Nov 2006 21:08:27 +0100
Message-ID: <20061114200827.GI7201@pasky.or.cz>
References: <ej7fgp$8ca$1@sea.gmane.org> <7vwt60bggs.fsf@assigned-by-dhcp.cox.net> <20061113194532.GA4547@steel.home> <20061113195414.GD17244@spearce.org> <20061113200358.GF7201@pasky.or.cz> <7vac2v6qru.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 14 Nov 2006 20:09:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vac2v6qru.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31368>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk4a8-0002X2-JW for gcvg-git@gmane.org; Tue, 14 Nov
 2006 21:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966298AbWKNUI3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 15:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966303AbWKNUI3
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 15:08:29 -0500
Received: from w241.dkm.cz ([62.24.88.241]:39125 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S966298AbWKNUI3 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 15:08:29 -0500
Received: (qmail 15617 invoked by uid 2001); 14 Nov 2006 21:08:27 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Mon, Nov 13, 2006 at 09:22:13PM CET, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > ... Junio, what's its life
> > expectancy? I guess this usage scenario is something to take into
> > account when thinking about removing it, I know that I wanted to get rid
> > of it in the past but now my opinion is changing.
> 
> It uses the same commit walker semantics and mechanism so I do
> not think it is too much burden to carry it, but I'd rather have
> something that works over git native protocol if we really care
> about this.  People without ssh access needs to be able to
> recover over git:// protocol.

Even though I obviously agree with the above, it would be useful to have
the flag even though git:// (which is apparently harder to get right
than the others) is not supported. After all, most repositories I've
seen that are available over git:// are available over HTTP as well.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1

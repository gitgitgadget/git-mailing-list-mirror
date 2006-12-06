X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: error out when the SVN connection fails during a fetch
Date: Wed, 6 Dec 2006 11:45:30 -0800
Message-ID: <20061206194530.GA24986@localdomain>
References: <20061128220605.GA1253@localdomain> <871wnget3b.fsf@mid.deneb.enyo.de> <20061204085253.GA31047@soma> <87zma4yr71.fsf@mid.deneb.enyo.de> <20061204090549.GB30316@hand.yhbt.net> <87psax3qmb.fsf@mid.deneb.enyo.de> <7v64co4zo0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 19:45:46 +0000 (UTC)
Cc: git@vger.kernel.org, Florian Weimer <fw@deneb.enyo.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v64co4zo0.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33513>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs2i5-0003yj-Qh for gcvg-git@gmane.org; Wed, 06 Dec
 2006 20:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937562AbWLFTpj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 14:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937563AbWLFTpj
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 14:45:39 -0500
Received: from hand.yhbt.net ([66.150.188.102]:44957 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937562AbWLFTpi
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 14:45:38 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 8A6492DC034; Wed,  6 Dec 2006 11:45:36 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 06 Dec 2006
 11:45:30 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Florian Weimer <fw@deneb.enyo.de> writes:
> 
> > * Eric Wong:
> >
> >> Florian Weimer <fw@deneb.enyo.de> wrote:
> >>> * Eric Wong:
> >>> 
> >>> > Does the following patch help?
> >>> 
> >>> Don't think so.  The issue is not timing-related.  I've seen a failure
> >>> every 1000 requests, which suggests to me that it's hitting the
> >>> MaxKeepAliveRequests limit configured on the server.
> >>
> >> Actually, that's exactly what this patch should fix.  git-svn restarts a
> >> child every 1000 revisions to avoid memory usage from going through the
> >> roof.
> >
> > Oh.  My (limited) testing of the patch confirms that.
> 
> Ok, so this means I should apply this one, right?

Yes, please do.  Thanks.

-- 

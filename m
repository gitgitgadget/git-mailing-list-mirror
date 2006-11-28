X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1.2/2 (fixed)] git-svn: fix output reporting from the delta fetcher
Date: Tue, 28 Nov 2006 13:15:07 -0800
Message-ID: <20061128211506.GA4486@hand.yhbt.net>
References: <loom.20061124T143148-286@post.gmane.org> <20061128054448.GA396@soma> <20061128102958.GA5207@soma> <20061128105017.GA20366@soma> <9e7ab7380611280445r4ebe344cw69cbc18a74c6122f@mail.gmail.com> <9e7ab7380611280732k4e940380tbf2a96146807d671@mail.gmail.com> <m2bqmr1rnw.fsf@ziti.fhcrc.org> <20061128201605.GA1369@localdomain> <9e7ab7380611281247h723a16fapc5a9898e8a4c7e1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 21:15:26 +0000 (UTC)
Cc: Seth Falcon <sethfalcon@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <9e7ab7380611281247h723a16fapc5a9898e8a4c7e1f@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32579>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpAIN-000743-Jw for gcvg-git@gmane.org; Tue, 28 Nov
 2006 22:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755773AbWK1VPK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 16:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755823AbWK1VPK
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 16:15:10 -0500
Received: from hand.yhbt.net ([66.150.188.102]:7296 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1755773AbWK1VPJ (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 16:15:09 -0500
Received: by hand.yhbt.net (Postfix, from userid 500) id A5F202DC035; Tue, 28
 Nov 2006 13:15:07 -0800 (PST)
To: Pazu <pazu@pazu.com.br>
Sender: git-owner@vger.kernel.org

Pazu <pazu@pazu.com.br> wrote:
> On 11/28/06, Eric Wong <normalperson@yhbt.net> wrote:
> 
> >Git itself cannot easily track empty directories (at least as far as
> >update-index and checkout) goes.
> >[...]
> >Is that something the git community wants?
> 
> No, I guess not. I detailed the real problem in my previous message,
> and it had nothing to do with empty directories, but with git-svn
> recording broken revisions from svn. Did you get it, or Trogdor ate my
> email?

Oops, I didn't notice the part about git-svn continuing despite a failed
connection.  Thanks for poking me again.
I'll look into how/if abort_edit/close_edit is called and how to deal
with a failed network connection.

-- 

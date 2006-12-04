X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and empty directories in svn
Date: Mon, 4 Dec 2006 13:33:27 -0800
Message-ID: <20061204213327.GA9313@localdomain>
References: <20061128054448.GA396@soma> <20061128102958.GA5207@soma> <20061128105017.GA20366@soma> <9e7ab7380611280445r4ebe344cw69cbc18a74c6122f@mail.gmail.com> <9e7ab7380611280732k4e940380tbf2a96146807d671@mail.gmail.com> <m2bqmr1rnw.fsf@ziti.fhcrc.org> <20061128201605.GA1369@localdomain> <m2slg2rzzj.fsf_-_@ziti.fhcrc.org> <20061203014756.GE1369@localdomain> <45724DB0.4060607@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 21:33:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45724DB0.4060607@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33255>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrLRQ-0001dY-Rf for gcvg-git@gmane.org; Mon, 04 Dec
 2006 22:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758482AbWLDVde (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 16:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759728AbWLDVde
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 16:33:34 -0500
Received: from hand.yhbt.net ([66.150.188.102]:42161 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1759695AbWLDVdd
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 16:33:33 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id C28402DC034; Mon,  4 Dec 2006 13:33:27 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 04 Dec 2006
 13:33:27 -0800
To: Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

Steven Grimm <koreth@midwinter.com> wrote:
> Eric Wong wrote:
> >Since git-svn misses some other stuff (many property settings,
> >externals) I'll be working on an internal logging format that can help
> >track those things.  It'd be nice to have a command like git svn
> >checkout which works like git checkout; but empty directories are
> >created.
> 
> Presumably once the submodule support is worked out, svn externals could 
> be represented as git-svn-managed submodules, yes?

Yes, that is the plan.  Better integration with native git remotes is
very much on the roadmap for git-svn.  I'll have to work on cleaning up
how multi-fetch works internally, however.

-- 

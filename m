X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: git-svnimport breakage as of git-1.4.4
Date: Thu, 14 Dec 2006 23:20:33 +0200
Message-ID: <20061214212033.GG7838@sashak.voltaire.com>
References: <1165505193.26874.13.camel@systems03.lan.brontes3d.com> <20061208203230.GA9193@sashak.voltaire.com> <1165847230.13854.2.camel@systems03.lan.brontes3d.com> <20061211204904.GC1003@sashak.voltaire.com> <1166027289.21948.4.camel@systems03.lan.brontes3d.com> <20061214022142.GA14521@sashak.voltaire.com> <1166130300.21982.0.camel@systems03.lan.brontes3d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 21:14:47 +0000 (UTC)
Cc: git@vger.kernel.org, Dongsheng Song <dongsheng.song@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <1166130300.21982.0.camel@systems03.lan.brontes3d.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 14 Dec 2006 21:14:04.0309 (UTC) FILETIME=[C89C5C50:01C71FC4]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34401>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guxub-0000RC-Qp for gcvg-git@gmane.org; Thu, 14 Dec
 2006 22:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932923AbWLNVOL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 16:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932921AbWLNVOK
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 16:14:10 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:29293 "EHLO
 taurus.voltaire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932918AbWLNVOJ (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 16:14:09 -0500
Received: from sashak ([172.25.5.176]) by taurus.voltaire.com with Microsoft
 SMTPSVC(6.0.3790.1830); Thu, 14 Dec 2006 23:14:04 +0200
Received: by sashak (sSMTP sendmail emulation); Thu, 14 Dec 2006 23:20:33
 +0200
To: Daniel Drake <ddrake@brontes3d.com>
Sender: git-owner@vger.kernel.org

On 16:05 Thu 14 Dec     , Daniel Drake wrote:
> On Thu, 2006-12-14 at 04:21 +0200, Sasha Khapyorsky wrote:
> > Try this please:
> > 
> > 
> > diff --git a/git-svnimport.perl b/git-svnimport.perl
> > index cbaa8ab..071777b 100755
> > --- a/git-svnimport.perl
> > +++ b/git-svnimport.perl
> 
> Thanks, it now works for both forms of command line arguments.

Thanks for reporting. I still run git-svnimport against
http://tortoisesvn.tigris.org/svn/tortoisesvn, works fine up to now.


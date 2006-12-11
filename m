X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: git-svnimport breakage as of git-1.4.4
Date: Tue, 12 Dec 2006 00:03:03 +0200
Message-ID: <20061211220303.GG25052@sashak.voltaire.com>
References: <1165505193.26874.13.camel@systems03.lan.brontes3d.com> <20061208203230.GA9193@sashak.voltaire.com> <1165847230.13854.2.camel@systems03.lan.brontes3d.com> <20061211204904.GC1003@sashak.voltaire.com> <1165870980.31329.3.camel@systems03.lan.brontes3d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 11 Dec 2006 21:55:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <1165870980.31329.3.camel@systems03.lan.brontes3d.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 11 Dec 2006 21:55:06.0576 (UTC) FILETIME=[04FF3D00:01C71D6F]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34040>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtt7F-0005xp-2U for gcvg-git@gmane.org; Mon, 11 Dec
 2006 22:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1763118AbWLKVzM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 16:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763122AbWLKVzM
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 16:55:12 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:10105 "EHLO
 taurus.voltaire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1763121AbWLKVzK (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006
 16:55:10 -0500
Received: from sashak ([172.25.5.176]) by taurus.voltaire.com with Microsoft
 SMTPSVC(6.0.3790.1830); Mon, 11 Dec 2006 23:55:06 +0200
Received: by sashak (sSMTP sendmail emulation); Tue, 12 Dec 2006 00:03:03
 +0200
To: Daniel Drake <ddrake@brontes3d.com>
Sender: git-owner@vger.kernel.org

On 16:03 Mon 11 Dec     , Daniel Drake wrote:
> On Mon, 2006-12-11 at 22:49 +0200, Sasha Khapyorsky wrote:
> > Maybe I'm starting to understand. Your svn url (url which points to svn
> > repository) is https://server/repo and not just https://server, right?
> 
> Yes, and then under that we have https://server/repo/trunk
> 
> > If so, please remove the patch (you don't need it) and rerun:
> > 
> >   git-svnimport -v -i -C repo -r https://server/repo
> 
> Ah, that fixes it. However, in versions before 1.4.4, either invokation
> style works.

Frankly I think that it was bug. And I will see how to restore this. :)


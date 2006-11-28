X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
From: Pazu <pazu@pazu.com.br>
Subject: Re: Show remote branches on gitweb
Date: Tue, 28 Nov 2006 02:59:27 +0000 (UTC)
Message-ID: <loom.20061128T033926-990@post.gmane.org>
References: <loom.20061124T210559-701@post.gmane.org> <ek7jsp$j83$1@sea.gmane.org> <loom.20061127T200958-750@post.gmane.org> <ekfe15$a48$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 02:59:55 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 21
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 200.213.42.52 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1) Gecko/20061010 Firefox/2.0)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32483>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GotCH-00027G-T0 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 03:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934639AbWK1C7p (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 21:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934844AbWK1C7p
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 21:59:45 -0500
Received: from main.gmane.org ([80.91.229.2]:47839 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S934639AbWK1C7p (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 21:59:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GotCA-00025C-Dg for git@vger.kernel.org; Tue, 28 Nov 2006 03:59:43 +0100
Received: from C8D52A34.poa.virtua.com.br ([C8D52A34.poa.virtua.com.br]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 03:59:42 +0100
Received: from pazu by C8D52A34.poa.virtua.com.br with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 28 Nov 2006
 03:59:42 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb <at> gmail.com> writes:

> What about tags (refs/tags/), which shouldn't be here?

Yeah, I just noticed that when I pointed gitweb to git's own repository (my
project's repository currently has no tags). I've added a "next if $name =~
m!^refs/tags/!;" for now.

> Besides, it is quick'n'dirty solution; I'm not against having it as a patch
> in git mailing list archives, but I'd rather not have it there.

Yes, it's quick and dirty. I didn't mean to have it published anywhere (and to
anyone reading this from the archives: please don't use that ugly, quick, and
really dirty patch).

I posted it as a way to say that I'm one more happy git user. While one could
say that hacking gitweb to achieve happiness is cheating, the fact that I
*could* do that easily, even when I barely understand perl, is a really big plus
for me. You guys rock, really.

-- Pazu

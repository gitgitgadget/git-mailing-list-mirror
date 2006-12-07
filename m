X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
From: Pazu <pazu@pazu.com.br>
Subject: Re: Commit f84871 breaks build on OS X
Date: Thu, 7 Dec 2006 15:20:53 +0000 (UTC)
Message-ID: <loom.20061207T161845-377@post.gmane.org>
References: <2D096A57-D7B3-49C7-81E4-EB47A0D933B2@silverinsanity.com> <81b0412b0612070633i7aec43dse7a8beda64437103@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 15:22:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 10
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 201.37.99.93 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1) Gecko/20061010 Firefox/2.0)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33589>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsL52-0006UR-Fk for gcvg-git@gmane.org; Thu, 07 Dec
 2006 16:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937979AbWLGPVu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 10:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937980AbWLGPVu
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 10:21:50 -0500
Received: from main.gmane.org ([80.91.229.2]:33355 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937979AbWLGPVt
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006 10:21:49 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GsL3w-0007GE-Kx for git@vger.kernel.org; Thu, 07 Dec 2006 16:21:29 +0100
Received: from C925635D.poa.virtua.com.br ([C925635D.poa.virtua.com.br]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 07 Dec 2006 16:21:28 +0100
Received: from pazu by C925635D.poa.virtua.com.br with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 07 Dec 2006
 16:21:28 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Alex Riesen <raa.lkml <at> gmail.com> writes:

> Strange. You seem to have the old, generated Makefile you perl/
> directory. Haven't your pull failed? If so, I suspect that

I've found the same problem as the OP. First my pull failed like you said, but
then I completely wiped my working copy and tried checkout again -- this time it
worked fine. However, the build still fails with the error mentioned by the OP.

-- Pazu

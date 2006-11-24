X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
From: Pazu <pazu@pazu.com.br>
Subject: Re: git-svn: why fetching files is so slow
Date: Fri, 24 Nov 2006 19:28:48 +0000 (UTC)
Message-ID: <loom.20061124T202153-512@post.gmane.org>
References: <loom.20061124T143148-286@post.gmane.org> <20061124191609.GA32506@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 24 Nov 2006 19:29:26 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32232>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gngje-0005zg-L5 for gcvg-git@gmane.org; Fri, 24 Nov
 2006 20:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935018AbWKXT3G (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 14:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935024AbWKXT3F
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 14:29:05 -0500
Received: from main.gmane.org ([80.91.229.2]:12460 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S935018AbWKXT3D (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 14:29:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GngjJ-0005uS-Ev for git@vger.kernel.org; Fri, 24 Nov 2006 20:28:58 +0100
Received: from C925635D.poa.virtua.com.br ([C925635D.poa.virtua.com.br]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 24 Nov 2006 20:28:57 +0100
Received: from pazu by C925635D.poa.virtua.com.br with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 24 Nov 2006
 20:28:57 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Eric Wong <normalperson <at> yhbt.net> writes:

> git-svn transfers full files, and not deltas.  I'll hopefully have a
> chance to look into improving the situation for slow links this weekend.

Yes, but why would that make fetching the first revision slower? In this
situation, both svn and git-svn would have to fetch full files. Maybe git-svn
isn't using gzip compression or http pipelining?

-- Pazu

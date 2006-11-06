X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Add a MIME-Version header to e-mails
Date: Mon, 6 Nov 2006 08:56:34 +0100
Message-ID: <20061106075634.GA4532@diana.vm.bytemark.co.uk>
References: <eile19$p7r$1@sea.gmane.org> <20061106074532.10376.60478.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 6 Nov 2006 07:57:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061106074532.10376.60478.stgit@localhost>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgzLi-0004cc-53 for gcvg-git@gmane.org; Mon, 06 Nov
 2006 08:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030383AbWKFH4i convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006 02:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbWKFH4i
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 02:56:38 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:53515 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1030383AbWKFH4h
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 02:56:37 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GgzLO-0001XQ-00; Mon, 06 Nov 2006 07:56:34 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-11-06 08:45:32 +0100, Karl Hasselstr=F6m wrote:

> OK, this is a test to see if adding MIME-Version makes the problem
> go away. I don't have any other way to test this than sending a
> patch to the list. :-)

All right, it seems to have worked! When I send patches to myself,
they arrive still 8bit-encoded, and when I get them through the list,
they have been properly QP-encoded by whatever part of the chain
didn't like 8bit.

Catalin, this should replace the QP-encoding patch. (But not the
RFC2047-encoding patch -- the headers are required to always be ascii,
if I've not misunderstood something.)

Thanks everyone!

--=20
Karl Hasselstr=F6m, kha@treskal.com

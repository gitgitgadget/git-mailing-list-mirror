X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Double From:s in StGIT's patch email template
Date: Sat, 11 Nov 2006 15:40:57 +0100
Message-ID: <20061111144057.GG11224@diana.vm.bytemark.co.uk>
References: <20061111113553.GA11224@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 11 Nov 2006 14:41:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061111113553.GA11224@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31227>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Giu2d-0008R7-S9 for gcvg-git@gmane.org; Sat, 11 Nov
 2006 15:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947255AbWKKOlA convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006 09:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947256AbWKKOlA
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 09:41:00 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:8715 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1947255AbWKKOk7
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 09:40:59 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Giu2T-0003v2-00; Sat, 11 Nov 2006 14:40:57 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-11-11 12:35:53 +0100, Karl Hasselstr=F6m wrote:

> StGIT's default patch email template has both "From: %(maintainer)s"
> in the e-mail header, and "From: %(authname)s <%(authemail)s>" in
> the e-mail body. Why?

Ah, I just figured it out. "maintainer" is the person sending the
mail, and "author" is the person who wrote the patch. In general, they
are not the same.

Hmm. It would be nice to omit the second From: in case they really are
the same.

--=20
Karl Hasselstr=F6m, kha@treskal.com

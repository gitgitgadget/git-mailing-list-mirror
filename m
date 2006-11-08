X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Add a MIME-Version header to e-mails
Date: Wed, 8 Nov 2006 09:40:38 +0100
Message-ID: <20061108084038.GA3164@diana.vm.bytemark.co.uk>
References: <eile19$p7r$1@sea.gmane.org> <20061106074532.10376.60478.stgit@localhost> <b0943d9e0611070153s2a52f65k6ed4643e60a144b3@mail.gmail.com> <b0943d9e0611071109w584f4f7fv3ba1b7dbd9413717@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 8 Nov 2006 08:41:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0611071109w584f4f7fv3ba1b7dbd9413717@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31130>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhizF-0003cP-GD for gcvg-git@gmane.org; Wed, 08 Nov
 2006 09:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754455AbWKHIkm convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006 03:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754457AbWKHIkm
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 03:40:42 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:35076 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1754455AbWKHIkl
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 03:40:41 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Ghiz8-0004Wb-00; Wed, 08 Nov 2006 08:40:38 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-11-07 19:09:06 +0000, Catalin Marinas wrote:

> I re-implemented parts of the mail and import commands (inspiring
> from your patches). They now use the email Python package. The mail
> command encodes the body to 7 or 8bit depending on non-ascii
> characters.

Even though it turned out to be possible to use 8bit always?

> The headers are QP-encoded.

Strictly speaking, it's rfc2047-encoded. I think the options are QP
and base64.

> The import command can decode messages properly and can also handle
> multipart e-mails.

Goodie.

> I still have to write a test script but my simple tests showed that
> it works. Please let me know if there is anything wrong (especially
> with the QP-encoding of the mail headers).

I won't have time to check this out today (in fact, it may have to
wait until the weekend). But when I do check it out, I might have time
to write that test, so please holler if you start working on that.

--=20
Karl Hasselstr=F6m, kha@treskal.com

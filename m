X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/2] New stg command: assimilate
Date: Wed, 25 Oct 2006 18:32:31 +0200
Message-ID: <20061025163231.GA30478@diana.vm.bytemark.co.uk>
References: <20061022130559.17015.51385.stgit@localhost> <20061022130802.17015.50188.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 25 Oct 2006 16:33:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061022130802.17015.50188.stgit@localhost>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30075>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GclgE-0000qS-Kr for gcvg-git@gmane.org; Wed, 25 Oct
 2006 18:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423161AbWJYQcf convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006 12:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423163AbWJYQcf
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 12:32:35 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:43538 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1423161AbWJYQce
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 12:32:34 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gclg7-00081o-00; Wed, 25 Oct 2006 17:32:31 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-10-22 15:08:02 +0200, Karl Hasselstr=F6m wrote:

> +    def name_taken(name):
> +        return patchname in name2patch or crt_series.patch_exists(pa=
tchname)

I just realized, by means of an infinite loop, that "patchname" should
be replaced with just "name" in the body of this function. Would you
like me to resend the patch?

--=20
Karl Hasselstr=F6m, kha@treskal.com

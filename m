Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6C011F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 16:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388010AbfJRQQX (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 12:16:23 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56824 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726520AbfJRQQX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 12:16:23 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9IGFm1F012637
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Oct 2019 12:15:48 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D0DDB420458; Fri, 18 Oct 2019 12:15:47 -0400 (EDT)
Date:   Fri, 18 Oct 2019 12:15:47 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Santiago Torres Arias <santiago@nyu.edu>, Willy Tarreau <w@1wt.eu>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191018161547.GG21137@mit.edu>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
 <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
 <56664222-6c29-09dc-ef78-7b380b113c4a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56664222-6c29-09dc-ef78-7b380b113c4a@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 18, 2019 at 04:27:48PM +0200, Vegard Nossum wrote:
> commit ac30b08065cd55362a7244a3bbc8df3563cefaaa
> tree 8f09d9d6ed78f8617b2fe54fe9712990ba808546
> parent 108b97dc372828f0e72e56bbb40cae8e1e83ece6
> author Vegard Nossum <vegard.nossum@oracle.com> 1570284959 +0200
> committer Vegard Nossum <vegard.nossum@oracle.com> 1571408340 +0200
> gpgsig -----BEGIN PGP SIGNATURE-----
	...

Would it perhaps be possible to put some or all of these headers after
the patch, as a set of "trailers"?  That would make it easier for
human readers of the e-mail to get the bits that they most care
about.... namely, the patch itself.  :-)

If we move the PGP signature to the end, then the fact that it is so
big and bulky becomes much less of an issue.  A mini-sig might still
be a cool thing, from a space savings perspective both in the mail
archives, and in the git repo itself, if we start signing all commits.
But that seems like a separable issue.

Thanks,

					- Ted

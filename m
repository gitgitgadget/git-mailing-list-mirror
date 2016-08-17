Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 206C41F6C1
	for <e@80x24.org>; Wed, 17 Aug 2016 06:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589AbcHQGnk (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 02:43:40 -0400
Received: from mout.web.de ([212.227.17.11]:49723 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763AbcHQGni (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 02:43:38 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0LnS4I-1ay7ZZ2Lp0-00hesX; Wed, 17 Aug 2016 08:42:47
 +0200
Date:	Wed, 17 Aug 2016 06:42:45 +0000
From:	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.10.0-rc0
Message-ID: <20160817064245.GA5775@tb-raspi>
References: <xmqqfuq7j7cw.fsf@gitster.mtv.corp.google.com>
 <bb0e4f6b-a85a-550e-a971-2a9fabb2f87f@web.de>
 <xmqqoa4uhwcn.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqoa4uhwcn.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:VUt7rPXUQlseQ6InsuKnkB74dm5YowLLspwU+dsj+BzDyBDPWAE
 GSEh3OycJ0vngidBBhBlHholPcXsYydomampTO088ZQMK8YsdEeMOSC4Qg+sE/hPHxQppNR
 e79L3dKPgLcrcOqrP3FCQPo9q5UVyA6yA8qIi/BbYR6CQ/EQLhiG1+QJua2OxICO65A82x9
 LPakXhOTNk+g9fLB+SiEQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:1+urZ4oEpOA=:/ALgJflx2OYqbhKB9XlWm9
 QOy2sjB6Ta30ytXpQc7f52y9Yj3XCxs7pDEe8yblRLUhM8oq/nbMZGTJpY+BBdivCuycp6nL0
 Rd1zwXu943Km6T/v9k51fgEr9Hh0hwm+ac0CWpKtp3tH8JIDC8igFkR9CR/5pyquQPP8RprSw
 KnCUjvaZ1cfLkuK8MxlCHR56Q+em04c16Z/QHQCqtZ70MXrH3xufaLSnXWH3KbXZctPcoQhlV
 ubyUSmGHlSwfrLerkyLRfi2G7l5Q9uk0hKmILGprv+hitxk4Eu5rLQgLSeEePiSCXLIvA6YkG
 IeKoznpCo+ym468X5ycHysX2PVnXWkeSSmL0XST8gaTB1JZrXFSzN8++5ye18tB7uziOXZUwe
 jhpXZezES7FF0WGeACyXHz8XwwwST292duqStNmCI0uSW+JiLQyPlnZVnnAU4kgpkQEqzrC0/
 uVTfYRhqxwDRXjzoOadKKhQYIai87qRPn6+Jenkgj3fF5216BFp3AmOGBkcEotuEO0Lb4KzTS
 MgMc3ixiiQ+A18stk57w0Oe2x0hWgcNhTtLOuMLDa8BviUbmMOhvjCKOQKmeaBJR1DpLbHj9N
 zb6+NHd0cg3X8Ti2mkgNBb72fI99zsDKaDS3lJP/jqR/1sAVBCPFCdmSlawe9hq1MTRUned8A
 e+J2fS6sOHwdhnFLT74SA2lZtvgD1qyOVksHE9dfmElwcICHGjbdI0Dc9Tgddjh0WFPU61dhB
 OLNoe1a7CcLK6rhL25GTQQhKQSAvEJ0fBv8e4txOgie94ka1HpOS0hRD3rM=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 08:42:48AM -0700, Junio C Hamano wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
> 
> > On 15.08.16 00:47, Junio C Hamano wrote:
> >> Torsten Bögershausen (1):
> >>       convert: unify the "auto" handling of CRLF
> >
> > Should we mention this change in the release notes?
> >
> > The handling of "*.text = auto" was changed, and now
> >
> >     $ echo "* text=auto eol=crlf" >.gitattributes
> >     has the same effect as
> >     $ git config core.autocrlf true
> 
> Oh, definitely.  Thanks.
Hm, one question remains:
 git show 07c92928f2b782330df6e78
[]
+ * The handling of the "text = auto" attribute has been updated.
+   $ echo "* text=auto eol=crlf" >.gitattributes
+   used to have the same effect as
+   $ echo "* text=auto eol=crlf" >.gitattributes
Is this `text=auto` correct ?
I think it should be

   used to have the same effect as
   $ echo "* text eol=crlf" >.gitattributes

# In other words, the `auto` was ignored, as explained here:
+   $ git config core.eol crlf
+   i.e. declaring all files are text; the combination now is
+   equivalent to doing
+   $ git config core.autocrlf true
+

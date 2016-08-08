Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56EAB1FD99
	for <e@80x24.org>; Mon,  8 Aug 2016 04:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbcHHEmU (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 00:42:20 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:43212 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbcHHEmT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 00:42:19 -0400
Received: from mfilter43-d.gandi.net (mfilter43-d.gandi.net [217.70.178.174])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id CA5FA41C074;
	Mon,  8 Aug 2016 06:42:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter43-d.gandi.net
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
	by mfilter43-d.gandi.net (mfilter43-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id LxG68ellnqKj; Mon,  8 Aug 2016 06:42:16 +0200 (CEST)
X-Originating-IP: 98.150.198.107
Received: from x (cpe-98-150-198-107.hawaii.res.rr.com [98.150.198.107])
	(Authenticated sender: josh@joshtriplett.org)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 87F5241C086;
	Mon,  8 Aug 2016 06:42:12 +0200 (CEST)
Date:	Sun, 7 Aug 2016 18:42:07 -1000
From:	Josh Triplett <josh@joshtriplett.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] format-patch: Add a config option format.from to
 set the default for --from
Message-ID: <20160808044206.ubvaftex3mwbmwdh@x>
References: <cover.4d006cadf197f80d899ad7d7d56d8ba41f574adf.1469905775.git-series.josh@joshtriplett.org>
 <20160730191111.cd6ay3l4hweyjf7f@x>
 <xmqqziowgpc8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqziowgpc8.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.2-neo (2016-07-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 02:18:47PM -0700, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> > +enum from {
> > +	FROM_AUTHOR,
> > +	FROM_USER,
> > +	FROM_VALUE,
> 
> Drop trailing comma after the last enum definition (trailing comma
> after the last element in an array is OK, though).

I realize this code didn't get included in the final version, but for
future reference, what's the rationale for this?  I tend to include a
final comma in cases like these (and likewise for initializers) to avoid
needing to change the last line when introducing a new element, reducing
noise in diffs.  I hadn't seen anything in any of the coding style
documentation talking about trailing commas (either pro or con).

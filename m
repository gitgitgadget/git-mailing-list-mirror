Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB61020189
	for <e@80x24.org>; Wed, 22 Jun 2016 21:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbcFVV0k (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 17:26:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:62751 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462AbcFVV0k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 17:26:40 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MGBdv-1bBlJV3ZeJ-00FFQx; Wed, 22 Jun 2016 23:26:18
 +0200
Date:	Wed, 22 Jun 2016 23:26:18 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: work around t2300's assuming non-Windows
 paths
In-Reply-To: <xmqqvb11kmog.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606222325560.10382@virtualbox>
References: <cover.1466246919.git.johannes.schindelin@gmx.de> <a8bebe126bcd047720a13e90b85b8dccb7231187.1466246919.git.johannes.schindelin@gmx.de> <xmqqmvmfu17f.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1606211356170.22630@virtualbox>
 <xmqqr3bqqxhc.fsf@gitster.mtv.corp.google.com> <xmqqk2hiqwpb.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1606220927350.10382@virtualbox> <xmqqa8idnpj9.fsf@gitster.mtv.corp.google.com> <xmqqvb11kmog.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:blc+Zp5SeY1qFRIU/IAFvK9goB7tsmNSQ9lT9pXq3Ee9BJRVy7u
 tweHDwei6IiZeypzuPJJ+89gEjQWDvRIMYjbHhQuA3bBc2IoL/J3QV9/N5GylqlnsGD4HY7
 vMNwK3C/D+l8mxK/xTNfRWXYbMg/HEF2a6r6KsHasEppBxE8Cv9t9Uwt7RUkKuXW95ESoaz
 GBTZLtqyXje0b8hm8PrJA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:A83xB2cV4NA=:/rseWvCeYGZcCLZP2BKBc7
 8vIWqFdEA/Cw7pLeRDKvh4+EzYC+kuUAhTqkaQoGcjaMZqPpAXxFIvZpJ7SQf/whkDZkdtXkR
 SrX2/Q1ptTquZg3Wk1UWD0nteoHRVSh6v+G2ikR7iw3ANG5KKW7avSiCDi/eQMi0pc7BVsnEO
 Z2N+sdsIiJ8WhzefLoCkYM8DcWzHAl5kR4cpOvSZFvx3SpSFDkUHXuz4jVLvZKEM/+LTi7j1X
 JV/jNOIvRs3NeO+hxdHyC6kmEBW1iyxymtt0MAb/iZRxygFZDTehIBuPHX+LwDEzrESaVv80W
 0S9tU3pj4jgpiIAuL72DoHiqWwunRmYFJDlUhLnbBq6sWW2M9/kIARYsGIlhfogV+Wj8Mdc37
 ZfLh0+s3lWCnbyHi3B5aPCWxl7EW6J/t76/V7mhyhdJ6OPEsdVVlMWF2714BJaR6+q8llRKPl
 jRLFm+46pd4z1jT0CvDEC2/C9y4koqHy9Duj9qPD7tU40aBpZFeu9xZJqtwBoYdsAoZHFAsHY
 iSuGReWLdqBuAlyyERfAp4Rqg86GiUL1QctA1r/WUqBejNS0FYRhZhWNYARXC6cSnvWIsLsQN
 qYfZF7mdTbICHbdGKuRM+D8gMeszEv3R37nssXwNyfgS8Q5jeixip5WXEaMuWOBVOEBi92Zgi
 e5WKYChMzYS9jV/aq4l57bZqWyXaUmpH5tagEk+WCTTL43nvxl2KLfpT/XhbxI7fI4Tle5n8l
 LKfWoI+bycKSaL7nbQ3cVyHSuR4AApJ87eM9wKzi2DocZT4FlA8EQJS5+4Gzk/UbXhGpnFbNb
 uMNikh6
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 22 Jun 2016, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I think I know that well enough; please sanity check.  My
> > understanding is:
> > ...
> > The patch under discussion is the only door left for that test, and
> > a similar trickery is needed for any end-user scripts used for hooks
> > and aliases that use 'git --exec-path', if they ever want to be
> > cross-platform.
> >
> > So let's take that "if Windows do this" change to t2300 as-is.
> 
> Assuming that the sanity check passes, here is a suggested rewrite
> to explain the real problem better.

Yes, the sanity check passes, and your commit message is much better than
mine.

Thanks!
Dscho

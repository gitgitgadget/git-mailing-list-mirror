Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DF37202A0
	for <e@80x24.org>; Fri,  3 Nov 2017 11:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756180AbdKCLzc (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 07:55:32 -0400
Received: from mout.gmx.net ([212.227.17.21]:59849 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754765AbdKCLz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 07:55:26 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHal6-1e7HiO0dpM-003OoC; Fri, 03
 Nov 2017 12:55:12 +0100
Date:   Fri, 3 Nov 2017 12:54:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 4/6] list-objects: filter objects in
 traverse_commit_list
In-Reply-To: <20171102123245.0f768968703ec4e35d3d1f81@google.com>
Message-ID: <alpine.DEB.2.21.1.1711031254280.6482@virtualbox>
References: <20171102175013.3371-1-git@jeffhostetler.com>        <20171102175013.3371-5-git@jeffhostetler.com> <20171102123245.0f768968703ec4e35d3d1f81@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QWQEXIu1bX4GT4dP5OL10BhASOX2rF84+M9qLHNe3/y/FNwJbrL
 TDFXRIkfU3kr+Bsb2svnvSi3Adlbsow79ELdZjnW5bvuzUKV6ExgRqpZO9RR1Ay+x9x95m1
 M4Xo2SYBy9Z3o0eUemmh84XowLTT9Is4ay9iJBBoFcUXtu5LgtqFxnfF1GAjnFwgU6/Kcef
 hrhCMNVAC3jeNmMi0hoXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rs7J356GfNs=:ZNTmUdu8R8WgI3xC3QkKH+
 ebdDyOLcaGKcHED7uAomIhyavJ24prXusp+SdZ8judD6vGtHfFvs+UufnG7aidwhXUyML9qql
 3kA501PdJTIfUUv4f/sLdJVcxiV6ojqWwuLrB4GHiZiR/yGdJTgziQnBSk8oeaCXaHYBRKQKG
 b8zrjIwM172HfLK2KlaQVB7+nbP1K9peEmdXTva3K/PJ5w5OU1aQdrkf316sbRCV6oIhd0A6z
 Tc5jRc/t8+bN2a9sh2EaQThdWQTJBwOSNvbGtTldohPE30Uj5go0QTd18KsBbi1co5uFb8iyU
 GRRiGV85FH8H0LNKga18OvmnX/pqsVSd0b1YY5Uxai7hBGJwVSJTPiOaOSzwGa/WjXKvOB2dO
 /21udnqcKWw+Xuu3HHUVM7q1jdag6hvt122tBbmZtwkyzXcW3OT9kjMapPbk5nxAXaGJ8p6Hj
 Ig4s/YiBKJjrjcJEdY4ASgow4qe7Su4dX1vu6zv2jTM+wJkr+GoMeDOTk6n2rtMjD7VekcVHq
 KrHBP8JNAkR7MfbNjnlAJTNjZ8CHUpb4j7hgskfYceI0iYEf9zOOUIvVKeeFIBuP+DESTof2q
 3292whCxFayeUEbUCbP77ytyUP02oe2TnoWYgMRFGepzf67KyU2e2/5BpY4LtxiQUDDJx+Pi0
 rwzV4NBN8LnkwmYCZaLW6zrDP36NO0j65cRKBjb5pn7PgnkcZHdXHmNV1GksOanrQW0b+EM2i
 U4Le0LZd4qUmg2ojFUJgVUEu1ctIiqNa45yT5J86WHCpku1VxZruy+8xAZVjh0lVRdXdrpQzd
 E1xKqR0JoE1nvE7SRWOVP/8HL3iclKYwXLBNl/LEFQbUhdgUV4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Thu, 2 Nov 2017, Jonathan Tan wrote:

> On Thu,  2 Nov 2017 17:50:11 +0000
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
> > +int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
> > +			      const char *arg)
> 
> Returning void is fine, I think. It seems that all your code paths
> either return 0 or die.

Can we please start to encourage libified code, rather than discourage it?

Thank you,
Dscho

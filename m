Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 923CB207EC
	for <e@80x24.org>; Wed,  5 Oct 2016 11:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753846AbcJELfK (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 07:35:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:64726 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751121AbcJELfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 07:35:09 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LrNoG-1at14d0vXA-0134fU; Wed, 05 Oct 2016 13:35:03
 +0200
Date:   Wed, 5 Oct 2016 13:35:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Pull out require_clean_work_tree() functionality
 from builtin/pull.c
In-Reply-To: <xmqqpongt034.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610051325280.35196@virtualbox>
References: <cover.1473580914.git.johannes.schindelin@gmx.de> <cover.1475586229.git.johannes.schindelin@gmx.de> <xmqqpongt034.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rWGHIjwHNS1CtLZ0iu+LTQ2sXCuBU8tnkHzqQbTtIrSJ0hko9u+
 GxdxvrX1ijcWytfnVDKGYkgHSrOePuvFi3RPZx5R5kEjDWzIpe8fMyiNwujAztR/lSz2724
 5H+zz4nLOfGZAK3D6Jj5+5AIqPH9Q7kw/r8ZlVaDWlAg7uZpLgZrutCR8BUvlUG//asN5ff
 pJ4MGphHUzK+eLYf9EUpw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a9VnE39568E=:By6JKupe+Fef33JWKWuJZF
 o13Ozj6i0Gcp9w9QEVS36Nn1yYnoSiEHrbDrlzHsvvYE7tcVI1KaDagm27NVewY/JrKg+na7G
 8QhRzdB7mSxRC1kG8P5CF+VwdCgDw4fsBMcaUsWjZZmF5cJfOoKrENU38wUDbiOhoLJ4GiDvn
 Ezykdz3Sf1SnI3/A5SQJJsdw7ZACN75jrap191BXPu6PDjutDLLqulUKygSDD/AEmVGCUloNp
 Ku+6rlAJ3793cvbNfy6FKCDeFDLEwaJjGo9ya5vJ1D96+EHczD6cjJD8i1y6FrB7hKwaGN8Ar
 7GVhwI+TMdpPb8gdXmrr9RbVun13aOdwopTdzwfEwrcGA6U8tpXamg/yCenEhMnjnU+WGdJpX
 nV1+8GmyJTNuXkJW6AEY0rZecEnu8H88ca5Y7yn7nRtfsOppjx/lHE2rOLtu+8eB2xDJs64bH
 OuHUBSw9K4kkk+9PbrKXSDz4Q06FiilOkQYHQzO5vzeLSYAizGhVgOEf9YqHmttwR3reOHuR2
 Qdz0WuMGdlpN+k2HuHzV3WH0TzXUafN6WXDhvh3DfeUo66FDqLxKIDY4h4/D5NHxoOiUozd6e
 GTmA3y3/s2XbhIeVUMBkC051VOC7iQwqNAqktbQjLc5wPHmeq4wWgsNQ3a7H/ImlySrcEj1zF
 hrNPp0/vPUHX/5ccbcd6sAnHPhyNCiHsmO/dBB34ZWnJpji1txd/ES5D0DBkj7DEieyKhOCom
 86ii68Ek3gioKWJ/QhUKk6Wyrmaibe43RmlSCDXjcubKwySNG2MrxIduoaHAA0ax4I/CgsO0A
 Ekatfd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 4 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This is the 5th last patch series of my work to accelerate interactive
> > rebases in particular on Windows.
> 
> Offtopic, but I am always confused by what you might mean by this
> "nth last patch series".  Is this series 5th from the last and we
> have four more to go?

Yes, we have four more to go:

- the patch series (called "prepare-sequencer" in my fork) preparing the
  sequencer code for the next patch series, such as revamping the parser
  for the edit script (or "todo script" as I used to say all the time, or
  "insn sheet" as sequencer calls it),

- the patch series ("sequencer-i") teaching the sequencer to parse and
  execute the commands of rebase -i's git-rebase-todo file,

- the patch series ("rebase--helper") introducing the builtin, and using
  it from rebase -i, and finally

- the patch series ("rebase-i-extra") that moves more performance critical
  bits and pieces from git-rebase--interactive.sh into the rebase--helper.

I had originally planned to stop at rebase--helper and invite other
developers to join the fun of making rebase -i a true builtin, but the
performance improvement was surprisingly disappointing before the
rebase--helper learned to skip unnecessary picks, to verify that the
script is valid, to expand/collapse the SHA-1s, and to rearrange
fixup!/squash!  lines.

> In any case, after a quick re-read and comparison with the last
> round, I think this is in a good shape.  I'd say that we would wait
> for a few days for others to comment and then merge it to 'next' if
> we missed nothing glaringly wrong.

Perfect!
Dscho

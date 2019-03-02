Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 674F020248
	for <e@80x24.org>; Sun,  3 Mar 2019 01:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfCCBVp (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 20:21:45 -0500
Received: from ozlabs.org ([203.11.71.1]:34521 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfCCBVp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 20:21:45 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 44Bljz19zGz9s5R; Sun,  3 Mar 2019 12:21:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1551576103; bh=W5Ea82+EgNpCEHLDIiFcodTHeKugMpFrJYmALDda4KU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t4cUqazkvMYEE6Pg9r1Qqj2jPRnp81SOBi9eKonjkMXMMhW0JIu0tNFOwr+GIBva5
         FYLICIodwUWgApMaAD4LfvIRiIXFB1OguS2g/XjzfHhJVHudUYBCpLxp6bshGpKqO8
         odrV9yqB6XhR+FFGl5zSxk3V/QNV0t2yitFDThG9VrXdOoUKqy+VxZP/FGOADSaF3R
         rrz467I4mwRb/fwBa8Hop4iuXtBzjl33xCB5zpilGxV98qJBweQvhxL0tT5EbQgkdP
         lf/JGR9Ar57kqgWzeBbmYp4UuUKfqamq7OOWemzcg7rxPVpzu+B85HMbI9cFGgFLSY
         T1w3uRkWko5nA==
Date:   Sun, 3 Mar 2019 10:02:28 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Andrej Shadura <andrew.shadura@collabora.co.uk>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] gitk: refresh the colour scheme
Message-ID: <20190302230228.GA26937@blackberry>
References: <20190226110535.29172-1-andrew.shadura@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226110535.29172-1-andrew.shadura@collabora.co.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 12:05:34PM +0100, Andrej Shadura wrote:
> The colours gitk is currently using are from the basic 16 colour
> palette, and are a bit too intensive to be comfortable or pleasant
> to work with.
> 
> Adjust the main colours (commit nodes, remotes, tags and one branch
> colour) to be slightly softer.
> 
> Signed-off-by: Andrej Shadura <andrew.shadura@collabora.co.uk>

Thanks for the patch, but I disagree.  I do like the change you made
to the tag colours, but the blue you have for the commit node circles
is pretty blah.  That needs a more definite colour.

Also, the "too intensive to be comfortable or pleasant" in the commit
message reflect a personal preference, and the way it is put seems to
me to be too intensive to be comfortable or pleasant.

Paul.

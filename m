From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/67] fsck: don't fsck alternates for connectivity-only check
Date: Wed, 16 Sep 2015 12:12:45 -0700
Message-ID: <xmqqwpvqp49e.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915152428.GD29753@sigill.intra.peff.net>
	<f536d3d011ff1943c3cfcf90c9dce664@dscho.org>
	<xmqqtwquqlz2.fsf@gitster.mtv.corp.google.com>
	<20150916181237.GB17381@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 21:12:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcI8S-0006jH-DL
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 21:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbbIPTMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 15:12:48 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34176 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746AbbIPTMs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 15:12:48 -0400
Received: by padhy16 with SMTP id hy16so217031937pad.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 12:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tOZs0oRmqVbU5u8qEDQWdOFVvBhtLBMb/sVyldCXmu0=;
        b=JtY2Ub8ueasP06MRHRSA126IIYe5XA4WMEc5Es1D/xYclvCg3JA25PVAEMvPpdMcyp
         5w1LDmlN2vaRLD2a094ctaHywm8HT1QDrc+O4EBVzzoEPcUcjZLYksWwVPqt0G9EU8qW
         nHGbnNWnMAssvBz9jbev4bas3ZvdkODQ14t1Brhs8UMdQoWLcQo3QNYttk0oFOUwZJSr
         ReZGDFgDhKaW6Z7JuUV0uF/ZXZI2mPxocZ3JH2CISd4yRImK8N5gNh9D1DLCf1qxokhg
         gmOgVC5zmW+JsALX74opJPFZAJJ6PH7cJLeqjFkhg4eiQyHejLHxZ3+dXQ6V4XiHbC+O
         gzug==
X-Received: by 10.66.117.200 with SMTP id kg8mr62211894pab.37.1442430767582;
        Wed, 16 Sep 2015 12:12:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id xv12sm29380926pac.38.2015.09.16.12.12.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 12:12:46 -0700 (PDT)
In-Reply-To: <20150916181237.GB17381@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 16 Sep 2015 14:12:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278050>

Jeff King <peff@peff.net> writes:

> Speaking of which, how do you want the next round of patches? I'm
> hesitant to spam the list with 67 patches again, when only a fraction
> have changed (and for all but the _to/_r thing, I've posted my changes
> already).

Cannot tell yet, as I am only halfway thru myself.  If there is a
significant update based on discussions, it may be worth sending
only those so that you can sooner make sure that the resulting
change and those who reviewed the first iteration are all on the
same page, but a full resend, before giving enouth time to those who
are willing to but have not found time to review the whole thing,
would be a wasted mental bandwidth for everybody, I suspect.

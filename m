From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email: ask confirmation if given encoding name is
 very short
Date: Wed, 18 Feb 2015 13:58:12 -0500
Message-ID: <20150218185812.GC7257@peff.net>
References: <cover.1421214154.git.zhugh.fnst@cn.fujitsu.com>
 <20150205114914.GA10126@stefanha-thinkpad.redhat.com>
 <54D38B73.4060803@redhat.com>
 <xmqqiofgkvi4.fsf@gitster.dls.corp.google.com>
 <20150205195758.GC15326@peff.net>
 <xmqq61bgkt9w.fsf@gitster.dls.corp.google.com>
 <CAMuHMdWbHMPEwkYvzKzzc6L0T8ufk62DGS2sZ1w1BthL1kAZWA@mail.gmail.com>
 <xmqqiof14hax.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Blake <eblake@redhat.com>,
	Stefan Hajnoczi <stefanha@gmail.com>,
	Zhu Guihua <zhugh.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org,
	tangchen@cn.fujitsu.com, chen.fan.fnst@cn.fujitsu.com,
	isimatu.yasuaki@jp.fujitsu.com, imammedo@redhat.com,
	guz.fnst@cn.fujitsu.com, anshul.makkar@profitbricks.com,
	afaerber@suse.de, Geert Uytterhoeven <geert@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 19:58:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO9pD-0001Qc-V0
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 19:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbbBRS6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 13:58:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:50610 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752341AbbBRS6P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 13:58:15 -0500
Received: (qmail 3875 invoked by uid 102); 18 Feb 2015 18:58:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Feb 2015 12:58:14 -0600
Received: (qmail 19768 invoked by uid 107); 18 Feb 2015 18:58:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Feb 2015 13:58:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2015 13:58:12 -0500
Content-Disposition: inline
In-Reply-To: <xmqqiof14hax.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264043>

On Mon, Feb 16, 2015 at 02:34:14PM -0800, Junio C Hamano wrote:

> Sometimes people respond "y<ENTER>" (or "yes<ENTER>") when asked
> this question:
> 
>     Which 8bit encoding should I declare [UTF-8]?
> 
> We already have a mechanism to avoid accepting a mistyped e-mail
> address (we ask to confirm when the given address lacks "@" in it);
> reuse it to trigger the same confirmation when given a very short
> answer.  As a typical charset name is probably at least 4 chars or
> longer (e.g. "UTF8" spelled without the dash, or "Big5"), this would
> prevent such a mistake.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * Will mark to be merged to 'next'.

Probably belated review, but this looks good to me.

-Peff

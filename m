From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/6] t5541-http-push.sh: add test for unmatched,
 non-fast-forwarded refs
Date: Wed, 6 Jan 2010 07:05:46 -0500
Message-ID: <20100106120546.GB7221@coredump.intra.peff.net>
References: <20091224154057.33611ae7.rctay89@gmail.com>
 <20091224154005.a642c8ec.rctay89@gmail.com>
 <20091224154158.15ba580f.rctay89@gmail.com>
 <20100105063546.GB19368@coredump.intra.peff.net>
 <20100105180132.e573fff2.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 13:06:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSUeH-0004PL-9A
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 13:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821Ab0AFMFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 07:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755820Ab0AFMFw
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 07:05:52 -0500
Received: from peff.net ([208.65.91.99]:54104 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755808Ab0AFMFv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 07:05:51 -0500
Received: (qmail 16498 invoked by uid 107); 6 Jan 2010 12:10:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 06 Jan 2010 07:10:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jan 2010 07:05:46 -0500
Content-Disposition: inline
In-Reply-To: <20100105180132.e573fff2.rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136263>

On Tue, Jan 05, 2010 at 06:01:32PM +0800, Tay Ray Chuan wrote:

> > I don't understand what you're testing here. If it's not matched, then
> > how is it a non-fast-forward? Isn't it simply unmatched?
> 
> Let me rephrase this as:
> 
>   Some refs can only be matched to a remote ref with an explicit
>   refspec. When such a ref is a non-fast-forward of its remote ref,
>   test that pushing them (with the explicit refspec specified) fails
>   with a non-fast-foward-type error.

Thanks, that makes sense to me now.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] submodule-config: use hashmap_iter_first()
Date: Tue, 15 Mar 2016 17:55:24 -0400
Message-ID: <20160315215524.GB30011@sigill.intra.peff.net>
References: <1458069195-20888-1-git-send-email-kuleshovmail@gmail.com>
 <CAGZ79kZ_wbJ2MGs_E-P_0eLk3JX_0QhT1c_BxqWCS+vrg8+xwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 22:55:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afwwA-00074q-Bm
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 22:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbcCOVz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 17:55:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:60168 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753937AbcCOVz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 17:55:27 -0400
Received: (qmail 13428 invoked by uid 102); 15 Mar 2016 21:55:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Mar 2016 17:55:27 -0400
Received: (qmail 7214 invoked by uid 107); 15 Mar 2016 21:55:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Mar 2016 17:55:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Mar 2016 17:55:24 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ_wbJ2MGs_E-P_0eLk3JX_0QhT1c_BxqWCS+vrg8+xwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288922>

On Tue, Mar 15, 2016 at 12:21:36PM -0700, Stefan Beller wrote:

> On Tue, Mar 15, 2016 at 12:13 PM, Alexander Kuleshov
> <kuleshovmail@gmail.com> wrote:
> > from the <hashmap.h> for simplification.
> 
> I think what Eric wanted to point out, was to not have a continuous sentence
> from commit message header to body.
> 
> Either leave the body blank (as it is obvious) or write a whole sentence there:
> 
>   [PATCH v2] submodule-config: use hashmap_iter_first()
> 
>   The hashmap API offers the `hashmap_iter_first` function as initializing and
>   getting the first entry is a common pattern. Use that instead of
> doing initialization
>   by hand and then get the first entry.

While we are nitpicking...:)

As a reader (either reviewing now, or looking at the change later in
git-log), I think my biggest question is: why?  Do we expect this to
change behavior, or is this just a cleanup? There's nothing wrong with
"just" a cleanup, but knowing that is the intent is helpful.

-Peff

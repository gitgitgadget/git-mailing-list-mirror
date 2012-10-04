From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] optimizing upload-pack ref peeling
Date: Thu, 4 Oct 2012 04:04:38 -0400
Message-ID: <20121004080438.GA31305@sigill.intra.peff.net>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
 <20121003180324.GB27446@sigill.intra.peff.net>
 <CACBZZX4Grya=FbL9XEh_EK6KVsFZYWCuHveV2QevcBwr+iYTMQ@mail.gmail.com>
 <20121003212007.GC4484@sigill.intra.peff.net>
 <CACBZZX6yMfeOx6x4iy8beq5niy9HvPq0c8ND5jZkoiJWAgVjfw@mail.gmail.com>
 <20121003231529.GA11618@sigill.intra.peff.net>
 <CACBZZX5Sm++Wjyoue-qk7TjwxUM3QihXfWGtEHhOq=VtkgvNbQ@mail.gmail.com>
 <20121004075609.GA1355@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:14:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtUk-0001w8-Qu
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571Ab2JDIEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 04:04:42 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40492 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932089Ab2JDIEl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 04:04:41 -0400
Received: (qmail 17844 invoked by uid 107); 4 Oct 2012 08:05:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Oct 2012 04:05:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2012 04:04:38 -0400
Content-Disposition: inline
In-Reply-To: <20121004075609.GA1355@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206983>

On Thu, Oct 04, 2012 at 03:56:09AM -0400, Jeff King wrote:

>   [1/4]: peel_ref: use faster deref_tag_noverify
>   [2/4]: peel_ref: do not return a null sha1
>   [3/4]: peel_ref: check object type before loading
>   [4/4]: upload-pack: use peel_ref for ref advertisements

I included my own timings in the final one, but my "pathological" case
at the end is a somewhat made-up attempt to emulate what you described.
Can you double-check that this series still has a nice impact on your
real-world repository?

-Peff

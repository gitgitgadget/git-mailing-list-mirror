From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch: avoid quadratic loop checking for updated
 submodules
Date: Mon, 12 Sep 2011 19:25:19 -0400
Message-ID: <20110912232519.GA30020@sigill.intra.peff.net>
References: <20110912195652.GA27850@sigill.intra.peff.net>
 <7vr53l5u7h.fsf@alter.siamese.dyndns.org>
 <20110912224934.GA28994@sigill.intra.peff.net>
 <7vboup4azh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 01:25:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3FsV-0003VF-6N
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 01:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755895Ab1ILXZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 19:25:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33387
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755668Ab1ILXZV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 19:25:21 -0400
Received: (qmail 20238 invoked by uid 107); 12 Sep 2011 23:26:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Sep 2011 19:26:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2011 19:25:19 -0400
Content-Disposition: inline
In-Reply-To: <7vboup4azh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181255>

On Mon, Sep 12, 2011 at 04:06:10PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Also also. I was a little turned off by the fact that every fetch is
> > going to do the equivalent of "git log --raw -m $new --not $old",
> > whether you have submodules or not.
> 
> Notice I called your patch solving "the other half"?
> See http://thread.gmane.org/gmane.comp.version-control.git/181101

Oh, heh. I totally missed that thread. I don't usually pay attention to
submodule patches, and came at this completely from the "why is git
fetch so slow" angle. Glad to see Jens and I are meeting in the middle.
:)

-Peff

From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Minor bug, git ls-files -o aborts because of broken submodules
Date: Mon, 25 Jan 2016 14:13:21 +0100
Message-ID: <20160125131321.GB18574@inner.h.apk.li>
References: <CACsJy8BpCc6sNKUs3TsMnA_8dk+uFvZy1T_UmfQMxcm2bpg2uw@mail.gmail.com> <20160122211803.GA17071@sigill.intra.peff.net> <20160122222650.GA14772@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 25 14:19:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNh3P-0002OE-TS
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 14:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbcAYNTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 08:19:21 -0500
Received: from continuum.iocl.org ([217.140.74.2]:52379 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932372AbcAYNTU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 08:19:20 -0500
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jan 2016 08:19:19 EST
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id u0PDDLM22154;
	Mon, 25 Jan 2016 14:13:21 +0100
Content-Disposition: inline
In-Reply-To: <20160122222650.GA14772@sigill.intra.peff.net>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284733>

On Fri, 22 Jan 2016 17:26:50 +0000, Jeff King wrote:
...
> Here it is. I think this is the right fix, based on the previous attempt
> by Andreas and my comments. Sorry for stealing your topic,

This seems to keep happening with things I try to patch. :-)

> but I hope
> the perf numbers in the second patch will brighten your day. :)

The patches are 'quadratically' improving my case as well,
many thanks for completing this. (I was just mustering
the steam for another round of work on this.)

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/12] tests: add initial bash completion tests
Date: Sun, 8 Apr 2012 07:06:42 -0400
Message-ID: <20120408110642.GB21217@sigill.intra.peff.net>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
 <1333854479-23260-2-git-send-email-felipe.contreras@gmail.com>
 <20120408050140.GA5862@sigill.intra.peff.net>
 <20120408103002.GA3177@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 13:06:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGpxI-0000rP-Oi
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 13:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316Ab2DHLGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 07:06:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54439
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892Ab2DHLGo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 07:06:44 -0400
Received: (qmail 2921 invoked by uid 107); 8 Apr 2012 11:06:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Apr 2012 07:06:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Apr 2012 07:06:42 -0400
Content-Disposition: inline
In-Reply-To: <20120408103002.GA3177@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194991>

On Sun, Apr 08, 2012 at 05:30:02AM -0500, Jonathan Nieder wrote:

> > This test fails for me. The problem is that I have other git-f* programs
> > in my PATH
> [...]
> Is there some reason we care about the exact list of completions for
> "git f"?
> [...]
> Maybe it would make sense to check a few representative items.
> 
> 	# builtin
> 	grep "^fetch\$" out &&

I think your approach (to stop worrying about stopping pollution from
the environment, and start being more specific in what the tests care
about) is much saner than the snippet I posted.

-Peff

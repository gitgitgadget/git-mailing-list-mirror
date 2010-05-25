From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6 rebase-version] Make git log --graph looks better
 with -p and other diff options
Date: Tue, 25 May 2010 05:23:36 -0400
Message-ID: <20100525092336.GB30863@coredump.intra.peff.net>
References: <1274778154-29976-1-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 25 11:23:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGqMV-0007jj-5l
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 11:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756459Ab0EYJXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 05:23:42 -0400
Received: from peff.net ([208.65.91.99]:51584 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756228Ab0EYJXl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 05:23:41 -0400
Received: (qmail 18512 invoked by uid 107); 25 May 2010 09:23:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 25 May 2010 05:23:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 May 2010 05:23:36 -0400
Content-Disposition: inline
In-Reply-To: <1274778154-29976-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147697>

On Tue, May 25, 2010 at 05:02:28PM +0800, Bo Yang wrote:

> From: byang <byang@byang-laptop.(none)>
> 
> Rebase for a new master...
> 
> Bo Yang (6):
>   Add a prefix output callback to diff output.
>   Output the graph columns at the end of the commit message.
>   diff.c: Output the text graph padding before each diff line.

These patches look fine to me.

>   Emit a whole line once a time.

I have to admit I don't quite understand from the commit message what
the problem is that this is fixing.

>   Register a callback for graph output.

This one looks fine.

>   Make --color-words work well with --graph.

Your explanation of the rules for when to output sounds sensible to me,
but I'm not familiar enough with the color-words code to evaluate it
(and I lack the time and sleep to look at it more carefully tonight).

-Peff

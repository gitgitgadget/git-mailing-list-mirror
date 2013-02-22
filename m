From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] git-commit: populate the edit buffer with 2 blank
 lines before s-o-b
Date: Fri, 22 Feb 2013 17:35:13 -0500
Message-ID: <20130222223513.GA21579@sigill.intra.peff.net>
References: <CA+sFfMdok7wRDhgq7i=b3cu3LB+poExvxLBxYkg8L3pN92bEYg@mail.gmail.com>
 <1361570727-20255-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org, pclouds@gmail.com,
	jrnieder@gmail.com, john@keeping.me.uk,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 23:35:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U91Dg-0006XO-KX
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 23:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758047Ab3BVWfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 17:35:21 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57562 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757873Ab3BVWfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 17:35:16 -0500
Received: (qmail 9149 invoked by uid 107); 22 Feb 2013 22:36:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Feb 2013 17:36:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2013 17:35:13 -0500
Content-Disposition: inline
In-Reply-To: <1361570727-20255-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216871>

On Fri, Feb 22, 2013 at 02:05:27PM -0800, Brandon Casey wrote:

> From: Brandon Casey <drafnel@gmail.com>
> 
> Before commit 33f2f9ab, 'commit -s' would populate the edit buffer with
> a blank line before the Signed-off-by line.  This provided a nice
> hint to the user that something should be filled in.  Let's restore that
> behavior, but now let's ensure that the Signed-off-by line is preceded
> by two blank lines to hint that something should be filled in, and that
> a blank line should separate it from the Signed-off-by line.
> 
> Plus, add a test for this behavior.
> 
> Reported-by: John Keeping <john@keeping.me.uk>
> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> ---
> 
> How about something like this?

FWIW, as a casual reader of this series, I find this to be way easier
to follow than the previous round.

-Peff

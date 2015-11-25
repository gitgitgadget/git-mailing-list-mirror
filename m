From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] typofix for Documentation/git-cherry-pick.txt
Date: Wed, 25 Nov 2015 07:39:08 -0500
Message-ID: <20151125123908.GB4504@sigill.intra.peff.net>
References: <1448453111-32195-1-git-send-email-bin0515@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org,
	Bin Chen <chenbin0515@thundersoft.com>
To: bin0515@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 25 13:39:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1ZLv-0001OK-RC
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 13:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903AbbKYMjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 07:39:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:33864 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753898AbbKYMjL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 07:39:11 -0500
Received: (qmail 9054 invoked by uid 102); 25 Nov 2015 12:39:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Nov 2015 06:39:10 -0600
Received: (qmail 26334 invoked by uid 107); 25 Nov 2015 12:39:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Nov 2015 07:39:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Nov 2015 07:39:08 -0500
Content-Disposition: inline
In-Reply-To: <1448453111-32195-1-git-send-email-bin0515@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281708>

On Wed, Nov 25, 2015 at 08:05:11PM +0800, bin0515@gmail.com wrote:

>  `git cherry-pick master`::
>  
> -	Apply the change introduced by the commit at the tip of the
> +	Apply the change introduced by the commit at the top of the
>  	master branch and create a new commit with this change.

I don't think this is a typo. We frequently refer to the most recent
commit on a branch as the "tip of the branch". Saying "top" is not
wrong, but we use "tip" pretty consistently (it does not get its own
glossary entry, but see the "branch" entry in "git help glossary").

-Peff

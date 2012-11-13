From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv4] replace: parse revision argument for -d
Date: Tue, 13 Nov 2012 08:37:29 -0500
Message-ID: <20121113133729.GA20361@sigill.intra.peff.net>
References: <50A22026.60506@drmicha.warpmail.net>
 <848bc8f48885acd63b4f6d29eea0543e73d86451.1352802239.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 14:41:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYGkE-0007bu-Ms
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 14:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784Ab2KMNlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 08:41:22 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47303 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754446Ab2KMNhh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 08:37:37 -0500
Received: (qmail 23656 invoked by uid 107); 13 Nov 2012 13:38:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Nov 2012 08:38:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2012 08:37:29 -0500
Content-Disposition: inline
In-Reply-To: <848bc8f48885acd63b4f6d29eea0543e73d86451.1352802239.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209602>

On Tue, Nov 13, 2012 at 11:34:11AM +0100, Michael J Gruber wrote:

> 'git replace' parses the revision arguments when it creates replacements
> (so that a sha1 can be abbreviated, e.g.) but not when deleting
> replacements.
> 
> Make it parse the argument to 'replace -d' in the same way.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> 
> Notes:
>     v4 names the aux variable more concisely and does away with a superfluous
>     assignment.

Thanks. I agree the name "full_hex" is much better. Patch looks good to
me at this point.

-Peff

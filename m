From: Jeff King <peff@peff.net>
Subject: Re: Bug in git-diff output
Date: Tue, 1 Apr 2014 07:46:22 -0400
Message-ID: <20140401114621.GB15549@sigill.intra.peff.net>
References: <CALgQ2n-vPK6_0LnWA_AAD2GLvepjLN4A3UZFCAWzEp9r_=XOVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "rocketscienc01100101 ." <rocketscienc01100101@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 13:46:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUx9F-0002Xe-3W
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 13:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbaDALq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 07:46:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:51673 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751677AbaDALq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 07:46:26 -0400
Received: (qmail 26377 invoked by uid 102); 1 Apr 2014 11:46:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Apr 2014 06:46:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2014 07:46:22 -0400
Content-Disposition: inline
In-Reply-To: <CALgQ2n-vPK6_0LnWA_AAD2GLvepjLN4A3UZFCAWzEp9r_=XOVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245584>

On Tue, Apr 01, 2014 at 12:49:00PM +0200, rocketscienc01100101 . wrote:

> I tried to get a diff between HEAD and the current version of my
> project, so I did "git diff".

That actually diffs between the index and the working tree, but if you
haven't used "git add" to add any changes, the index content is the same
as HEAD.

> It's a web project with a CSS file that contains the following CSS rule:
> 
> a[href^=tel] {
>     color:inherit;
>     text-decoration:none;
> }
> 
> Now, whenever I do "git diff", it will always show the a[href^=tel]
> part and mess up the output, even when I didn't change anything near
> that line. The problem is easily reproducable in a newly created
> repository.

I don't understand what you mean here by "mess up the output". Can you
show us an example (and tell us what you expected to see)?

-Peff

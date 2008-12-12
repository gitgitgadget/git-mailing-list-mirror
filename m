From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Thu, 11 Dec 2008 22:36:59 -0500
Message-ID: <20081212033659.GB29663@coredump.intra.peff.net>
References: <alpine.LNX.1.00.0812061238260.19665@iabervon.org> <fcaeb9bf0812070427s64438216s41bf1294aa6398a3@mail.gmail.com> <alpine.LNX.1.00.0812071455020.19665@iabervon.org> <fcaeb9bf0812080451k6e213d0fo8d1da9bbac872649@mail.gmail.com> <alpine.LNX.1.00.0812081223140.19665@iabervon.org> <fcaeb9bf0812110504u1acfb612he3edae1df3774045@mail.gmail.com> <alpine.LNX.1.00.0812111520490.19665@iabervon.org> <7vy6ym9nm8.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0812112045120.19665@iabervon.org> <7vmyf29jd6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 04:38:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAyrC-0007N7-So
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 04:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756033AbYLLDhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 22:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755628AbYLLDhD
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 22:37:03 -0500
Received: from peff.net ([208.65.91.99]:3500 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755521AbYLLDhB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 22:37:01 -0500
Received: (qmail 32170 invoked by uid 111); 12 Dec 2008 03:37:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 11 Dec 2008 22:37:00 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Dec 2008 22:36:59 -0500
Content-Disposition: inline
In-Reply-To: <7vmyf29jd6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102886>

On Thu, Dec 11, 2008 at 07:12:53PM -0800, Junio C Hamano wrote:

> Sure, but as "sparse" does not (again, "it should not, at least to me")
> change the fact that git is about tracking the history of whole tree, not
> just a single file, nor just a subset of files, none of these operations
> should be affected about what the checkout area is.

I agree with Junio here. If you want "git grep foo HEAD^" to ignore
certain files, then sparse _checkout_ is not the right feature. In that
case you want a sparse _repo_, which is not something I think anybody is
seriously working on.

-Peff

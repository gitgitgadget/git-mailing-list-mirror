From: Jeff King <peff@peff.net>
Subject: Re: git clean performance issues
Date: Sat, 4 Apr 2015 16:48:02 -0400
Message-ID: <20150404204802.GA558@peff.net>
References: <CAMpP7NY++BwV+UygRj1C6Zsf=jE-z1AQuN3On0HeEqQpKGQtqw@mail.gmail.com>
 <20150404195507.GA31763@peff.net>
 <CAMpP7NZ8OD5or8H11OvuH1nq+qe-btKCsQnhas6+7SRYE1M1Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: erik =?utf-8?B?ZWxmc3Ryw7Zt?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 22:48:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeUzE-0004xX-Nk
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 22:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbbDDUsH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Apr 2015 16:48:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:42507 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752656AbbDDUsF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 16:48:05 -0400
Received: (qmail 7593 invoked by uid 102); 4 Apr 2015 20:48:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Apr 2015 15:48:05 -0500
Received: (qmail 504 invoked by uid 107); 4 Apr 2015 20:48:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Apr 2015 16:48:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Apr 2015 16:48:02 -0400
Content-Disposition: inline
In-Reply-To: <CAMpP7NZ8OD5or8H11OvuH1nq+qe-btKCsQnhas6+7SRYE1M1Tw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266787>

On Sat, Apr 04, 2015 at 10:39:47PM +0200, erik elfstr=C3=B6m wrote:

> That looks like the same issue. The "use is_git_directory" approach
> sounds good to me, is that the direction you would prefer? I can try
> to cobble something together although I must warn you I have zero
> previous experience with this code base so a few iterations will
> probably be needed.

Yeah, I think the preferred direction is building a solution in
is_git_directory. Multiple iterations are fine. That's what review is
for. :) See SubmittingPatches for tips, though.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: Promoting Git developers
Date: Thu, 12 Mar 2015 18:31:31 -0400
Message-ID: <20150312223131.GA24492@peff.net>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
 <54FDA6B5.8050505@drmicha.warpmail.net>
 <CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
 <xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
 <CAEjxke-6DuTW0-ZyDtUUdCWhEtuw6x3X6LuM_Fj22QztUvFfjQ@mail.gmail.com>
 <xmqqmw3kuuod.fsf@gitster.dls.corp.google.com>
 <20150311073129.GA5947@peff.net>
 <CAPc5daUVVk+SYgwCj9JftzXgV7=9kPprdBPCWHS5XQOa5uF69Q@mail.gmail.com>
 <20150311075429.GA10300@peff.net>
 <xmqqbnjz5in0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Jason St. John" <jstjohn@purdue.edu>,
	Christian Couder <christian.couder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 23:31:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWBdj-0003AD-4A
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 23:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbbCLWbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 18:31:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:60707 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752087AbbCLWbe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 18:31:34 -0400
Received: (qmail 14119 invoked by uid 102); 12 Mar 2015 22:31:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Mar 2015 17:31:33 -0500
Received: (qmail 6954 invoked by uid 107); 12 Mar 2015 22:31:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Mar 2015 18:31:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Mar 2015 18:31:31 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbnjz5in0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265377>

On Wed, Mar 11, 2015 at 02:28:03PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Or something along those lines. The wording and indentation of the
> > message could probably use tweaking. And there is a bash-ism in the
> > script. :)
> 
> OK, I've updated the Announce script on the 'todo' branch.  The
> announcement for 2.3.2 I sent out earlier as $gmane/264975 would
> have looked like this.

Thanks, I think the organization and wording you chose look nice. One
minor nit, though:

> The latest maintenance release Git v2.3.2 is now available at the
> usual places.  It comprises of 41 non-merge commits since v2.3.1,
> contributed by 19 people, 5 of which are new faces.

It's not generally considered correct to use "of" with the active tense
of "comprise". So either:

  It comprises 41 non-merge commits...

or:

  It is comprised of 41 non-merge commits...

is fine.  The latter is much more common, at least in American English,
though I imagine it gives some prescriptivists headaches.

> New contributors who made this release possible are as follows.
> Welcome to the Git development community!
> 
>   Aleksander Boruch-Gruszecki, Aleksey Vasenev, Patrick Steinhardt,
>   Ryuichi Kokubo, and Tom G. Christensen.

I hadn't thought about it when I originally suggested this, but of
course "new" is not strictly meaningful in a world with branches. If you
contribute a bugfix on top of v2.0.0 that goes to "maint", do you get to
be new in v2.0.1 _and_ in v2.2.0?

I do not think it matters too much either way in practice, but I guess
it would depend on your approach (picking the "old" base manually, or by
using all tags prior to the released version).

-Peff

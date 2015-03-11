From: Jeff King <peff@peff.net>
Subject: Re: Promoting Git developers
Date: Wed, 11 Mar 2015 03:31:29 -0400
Message-ID: <20150311073129.GA5947@peff.net>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
 <54FDA6B5.8050505@drmicha.warpmail.net>
 <CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
 <xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
 <CAEjxke-6DuTW0-ZyDtUUdCWhEtuw6x3X6LuM_Fj22QztUvFfjQ@mail.gmail.com>
 <xmqqmw3kuuod.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Jason St. John" <jstjohn@purdue.edu>,
	Christian Couder <christian.couder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 08:31:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVb7C-00077M-JC
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 08:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbbCKHbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 03:31:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:60077 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751024AbbCKHbd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 03:31:33 -0400
Received: (qmail 2157 invoked by uid 102); 11 Mar 2015 07:31:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Mar 2015 02:31:33 -0500
Received: (qmail 25087 invoked by uid 107); 11 Mar 2015 07:31:41 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Mar 2015 03:31:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Mar 2015 03:31:29 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmw3kuuod.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265310>

On Tue, Mar 10, 2015 at 07:36:34PM -0700, Junio C Hamano wrote:

> > Or if that would make the release notes too cumbersome to review, what
> > about using systemd's method? systemd's release notes include a
> > "contributions from" section at the very end that lists everyone with
> > a patch included in the release.
> 
> I can add "shortlog --no-merges -s -n v2.3.0..v2.4.0" at the end of
> the e-mail when the release notes is sent out. That might be a good
> enough balance between the usefulness of the release notes to its
> customers and giving credits to individuals in a way a bit more
> visible than "if you are interested, run shortlog yourself" [*4*].

I somehow thought you already did this, but it looks like you just do
shortlog (without the "-ns") for the "maint" release announcement. This
does seem like a very simple thing we could to promote visibility of
contributors, and one would that would not require any ongoing effort
once it is initially scripted. It may even be a nice place to
specifically call out contributors who are new in this release.

I spent many years as a "type C" contributor, and I remember how nice it
was to see my name mentioned occasionally as a useful person.

-Peff

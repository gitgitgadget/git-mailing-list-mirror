From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] format-patch: print format-patch usage if there are no
 arguments
Date: Tue, 13 Jan 2015 17:45:31 -0500
Message-ID: <20150113224531.GB3144@peff.net>
References: <1421171662-12164-1-git-send-email-kuleshovmail@gmail.com>
 <xmqq387eed30.fsf@gitster.dls.corp.google.com>
 <CANCZXo7UtCXF_bJe9exT1pUwwsgUuYs5mvHHGtDORoJew_UXnQ@mail.gmail.com>
 <xmqqppaicwww.fsf@gitster.dls.corp.google.com>
 <CAGZ79kYJ+XNktc7_C81xz=BfCP4_hrE=pWW5QGJ1kdXKMf4Jjw@mail.gmail.com>
 <xmqqiogaco3m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Alexander Kuleshov <kuleshovmail@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 23:45:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBADS-0008J9-JA
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 23:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851AbbAMWpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 17:45:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:34115 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752770AbbAMWpe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 17:45:34 -0500
Received: (qmail 20485 invoked by uid 102); 13 Jan 2015 22:45:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jan 2015 16:45:33 -0600
Received: (qmail 31030 invoked by uid 107); 13 Jan 2015 22:45:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jan 2015 17:45:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Jan 2015 17:45:31 -0500
Content-Disposition: inline
In-Reply-To: <xmqqiogaco3m.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262359>

On Tue, Jan 13, 2015 at 02:28:13PM -0800, Junio C Hamano wrote:

> On the other hand, "I am forked from building on this one" done with
> "checkout -t" is an explicit mark the user leaves, so it would serve
> as a better hint to base the default heuristics on, I think.
> 
> But nobody is asking for such a feature ;-)

FWIW, I very rarely run format-patch directly, but have a wrapper script
that dumps the patches into a tempfile and runs mutt. I taught it in
2007 to use the upstream branch as the default[1], and was puzzled
reading the start of this thread, thinking we already did that.

So that is perhaps not asking for the feature (I am already happy with
my homegrown wrapper), but is maybe an endorsement of it. :)

-Peff

[1] You may note in 2007 that we did not even have @{upstream}. I
    implemented it manually using git-config! Then in 2009, I switched
    it to use for-each-ref's "%(upstream)" placeholder. Literally 5 days
    later, Dscho introduced @{upstream}, but I never got around to
    switching. Maybe now it is time. :)

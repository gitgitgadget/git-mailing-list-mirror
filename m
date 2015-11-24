From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] contrib/subtree: unwrap tag refs
Date: Tue, 24 Nov 2015 16:52:58 -0500
Message-ID: <20151124215258.GC29185@sigill.intra.peff.net>
References: <1447435549-34410-1-git-send-email-mayoff@dqd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "David A. Greene" <greened@obbligato.org>, git@vger.kernel.org
To: Rob Mayoff <mayoff@dqd.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 22:53:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1LWZ-0000Wt-8v
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 22:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbbKXVxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 16:53:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:33461 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755360AbbKXVxA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 16:53:00 -0500
Received: (qmail 25046 invoked by uid 102); 24 Nov 2015 21:53:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 15:53:00 -0600
Received: (qmail 18809 invoked by uid 107); 24 Nov 2015 21:52:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 16:52:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 16:52:58 -0500
Content-Disposition: inline
In-Reply-To: <1447435549-34410-1-git-send-email-mayoff@dqd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281635>

On Fri, Nov 13, 2015 at 11:25:49AM -0600, Rob Mayoff wrote:

> If a subtree was added using a tag ref, the tag ref is stored in
> the subtree commit message instead of the underlying commit's ref.
> To split or push subsequent changes to the subtree, the subtree
> command needs to unwrap the tag ref.  This patch makes it do so.
> 
> The problem was described in a message to the mailing list from
> Junio C Hamano dated 29 Apr 2014, with the subject "Re: git subtree
> issue in more recent versions". The archived message can be found
> at <http://comments.gmane.org/gmane.comp.version-control.git/247503>.
> 
> Signed-off-by: Rob Mayoff <mayoff@dqd.com>
> ---
> 
> changes since v1:
> 
> * remove obsolete sub assignments
> * wrap lines

Thanks.  David, can I get an Ack on this?

-Peff

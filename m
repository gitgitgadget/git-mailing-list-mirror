From: Jeff King <peff@peff.net>
Subject: Re: [Bug] branch.*.merge interpreted too strictly by tracking logic
Date: Wed, 5 Feb 2014 16:08:31 -0500
Message-ID: <20140205210831.GB16753@sigill.intra.peff.net>
References: <xmqqa9e67atv.fsf@gitster.dls.corp.google.com>
 <20140205205030.GA16394@sigill.intra.peff.net>
 <xmqqbnyl2run.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 22:08:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB9i3-0002Ls-7C
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 22:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbaBEVIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 16:08:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:45327 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932266AbaBEVId (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 16:08:33 -0500
Received: (qmail 19902 invoked by uid 102); 5 Feb 2014 21:08:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 15:08:33 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 16:08:31 -0500
Content-Disposition: inline
In-Reply-To: <xmqqbnyl2run.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241664>

On Wed, Feb 05, 2014 at 01:05:04PM -0800, Junio C Hamano wrote:

> > I don't recall us ever doing anything after that. I don't have a problem
> > with making it work, of course, but I am not sure if it is really a bug.
> 
> Once people get used to us being extra nice in some places, other
> less nice places start looking more and more like bugs. It is an
> unfortunate fact of life, but fixing them up is a good thing for
> users.  As long as we can make those less nice places nicer
> uniformly without bending backwards or introducing unnecessary
> ambiguities, that is, and I think this one can be done without
> such downsides.

Oh, absolutely, and I do not think we are breaking anything to start
handling it better (my "I don't have a problem..." above). But I guess I
am doubting that people are actually doing this at all now. I'd expect
most people to have the config set automatically by "branch" or
"checkout", or to use "branch --set-upstream-to". Did your report come
out of a real case, or was it just something you noticed?

-Peff

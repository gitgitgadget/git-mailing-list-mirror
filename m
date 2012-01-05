From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Thu, 5 Jan 2012 01:38:41 +0100
Message-ID: <20120105003841.GA25285@ecki.lan>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
 <1325692539-26748-1-git-send-email-drizzd@aon.at>
 <7vy5tnpcuw.fsf@alter.siamese.dyndns.org>
 <20120104204017.GC27567@ecki.lan>
 <7vaa63p11t.fsf@alter.siamese.dyndns.org>
 <20120104222649.GA14727@sigill.intra.peff.net>
 <20120105000713.GA24220@ecki.lan>
 <7vk457ngi0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 05 01:47:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RibTz-0004lZ-Oo
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 01:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757465Ab2AEAq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 19:46:59 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:53531 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757264Ab2AEAq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 19:46:58 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 9B32ACDF84;
	Thu,  5 Jan 2012 01:47:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vk457ngi0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187960>

On Wed, Jan 04, 2012 at 04:24:23PM -0800, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > On Wed, Jan 04, 2012 at 05:26:49PM -0500, Jeff King wrote:
> >> 
> >> Or is the problem the git wrapper itself, which doesn't kill its
> >> subprocess when it dies (which IMHO is a bug which we might want to
> >> fix)? In that case, couldn't we just use --pid-file to save the actual
> >> daemon pid, and then kill using that?
> >
> > Or like this. Doesn't work with multiple children. I have yet to
> > check if we have those anywhere.
> 
> Hmm, don't we have them in the same process group or something, though?
> Can't we kill them as a whole?

I tried that, but it seems that the test script itself is in the
same process group.

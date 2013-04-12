From: Jeff King <peff@peff.net>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Fri, 12 Apr 2013 10:48:55 -0400
Message-ID: <20130412144855.GA17968@sigill.intra.peff.net>
References: <7vwqs8hmh1.fsf@alter.siamese.dyndns.org>
 <20130411200330.GA15667@odin.tremily.us>
 <7vip3shfpd.fsf@alter.siamese.dyndns.org>
 <20130411222301.GA11283@sigill.intra.peff.net>
 <20130412005748.GA17116@odin.tremily.us>
 <7vvc7sfkwn.fsf@alter.siamese.dyndns.org>
 <20130412043501.GA12942@sigill.intra.peff.net>
 <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
 <20130412050550.GA15724@sigill.intra.peff.net>
 <20130412112636.GC20178@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Fri Apr 12 16:49:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQfHo-0004ki-24
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 16:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081Ab3DLOtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 10:49:03 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42816 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752989Ab3DLOtC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 10:49:02 -0400
Received: (qmail 26283 invoked by uid 107); 12 Apr 2013 14:50:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Apr 2013 10:50:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Apr 2013 10:48:55 -0400
Content-Disposition: inline
In-Reply-To: <20130412112636.GC20178@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220983>

On Fri, Apr 12, 2013 at 07:26:36AM -0400, W. Trevor King wrote:

> On Fri, Apr 12, 2013 at 01:05:50AM -0400, Jeff King wrote:
> >   Like many programs that switch user id, the daemon does not reset
> >   environment variables such a `$HOME` when it runs git programs like
> >   `upload-pack` and `receive-pack`. When using this option, you may also
> >   want to set and export `HOME` to point at the home directory of
> >   `<user>` before starting the daemon, and make sure the Git
> >   configuration file in that directory are readable by `<user>`.
> 
> How about "and make sure any Git configuration files", since there
> might not be any Git configuration files.

Yeah, that is better. Thanks.

-Peff

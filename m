From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] config: treat user and xdg config permission
 problems as errors
Date: Sun, 14 Oct 2012 12:43:19 -0400
Message-ID: <20121014164319.GA16225@sigill.intra.peff.net>
References: <20121014000210.GA19094@elie.Belkin>
 <20121014000402.GB11399@elie.Belkin>
 <20121014062218.GB13477@sigill.intra.peff.net>
 <20121014084244.GA7190@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 18:43:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNRHs-0005gC-RA
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 18:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638Ab2JNQn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 12:43:26 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52220 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754607Ab2JNQnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 12:43:25 -0400
Received: (qmail 23071 invoked by uid 107); 14 Oct 2012 16:44:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 14 Oct 2012 12:44:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Oct 2012 12:43:19 -0400
Content-Disposition: inline
In-Reply-To: <20121014084244.GA7190@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207676>

On Sun, Oct 14, 2012 at 01:42:44AM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > For example, servers may depend on /etc/gitconfig to enforce security
> > policy (e.g., setting transfer.fsckObjects or receive.deny*). Perhaps
> > our default should be safe, and people can use GIT_CONFIG_NOSYSTEM to
> > work around a broken machine.
> 
> Very good point.  How about these patches on top?
> 
> Jonathan Nieder (2):
>   config doc: advertise GIT_CONFIG_NOSYSTEM
>   config: exit on error accessing any config file
> 
>  Documentation/git-config.txt | 8 ++++++++
>  config.c                     | 6 +++---
>  2 files changed, 11 insertions(+), 3 deletions(-)

This is my absolute favorite type of reply: the kind that you can apply
with "git am".

The direction and the patches themselves look good to me. I agree with
your reasoning in v2 of 3/2; it makes much more sense than v1.

Thanks.

-Peff

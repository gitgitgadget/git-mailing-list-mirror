From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git push: remove incomplete options list from help text
Date: Mon, 19 Oct 2009 00:10:34 -0400
Message-ID: <20091019041033.GB7170@coredump.intra.peff.net>
References: <7v8wfi1fya.fsf@alter.siamese.dyndns.org>
 <4ADB4AE8.5070007@hartwork.org>
 <20091018235240.GU6115@genesis.frugalware.org>
 <20091019115412.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Sebastian Pipping <webmaster@hartwork.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 06:10:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzja2-0008Dx-GZ
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 06:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbZJSEKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 00:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbZJSEKd
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 00:10:33 -0400
Received: from peff.net ([208.65.91.99]:48193 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbZJSEKd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 00:10:33 -0400
Received: (qmail 14278 invoked by uid 107); 19 Oct 2009 04:14:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 19 Oct 2009 00:14:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Oct 2009 00:10:34 -0400
Content-Disposition: inline
In-Reply-To: <20091019115412.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130646>

On Mon, Oct 19, 2009 at 11:54:12AM +0900, Nanako Shiraishi wrote:

>  static const char * const push_usage[] = {
> -	"git push [--all | --mirror] [-n | --dry-run] [--porcelain] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]",
> +	"git push <options> [<repository> <refspec>...]",

This is a big improvement, IMO. We should probably standardize on when
to show options, and when to simply say <options>, and make sure every
program does the right thing. I am in favor of a short synopsis followed
by a list (as you do here) for both usage and for manpages. However, I
raised the question a few weeks ago and the response was slightly
negative:

  http://thread.gmane.org/gmane.comp.version-control.git/129399/focus=129424

Probably few people read it, as it was buried deep in a thread. But
maybe we should settle on a rule like "short synopsis for usage, long
synopsis for manpage" or whatever people think is best.

Also, minor nit with your patch: should it be "[<options>]"?

-Peff

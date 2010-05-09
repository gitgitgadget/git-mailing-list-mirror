From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] Documentation/notes: simplify treatment of default
 display refs
Date: Sun, 9 May 2010 03:00:22 -0400
Message-ID: <20100509070022.GC23717@sigill.intra.peff.net>
References: <20100509031357.GA7926@progeny.tock>
 <20100509033223.GF7958@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 09:00:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB0VE-0002sE-4W
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 09:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587Ab0EIHA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 03:00:27 -0400
Received: from peff.net ([208.65.91.99]:36978 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557Ab0EIHAY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 03:00:24 -0400
Received: (qmail 17279 invoked by uid 107); 9 May 2010 07:00:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 09 May 2010 03:00:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 May 2010 03:00:22 -0400
Content-Disposition: inline
In-Reply-To: <20100509033223.GF7958@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146705>

On Sat, May 08, 2010 at 10:32:24PM -0500, Jonathan Nieder wrote:

> @@ -196,21 +196,13 @@ core.notesRef::
>  	command line.
>  
>  notes.displayRef::
> -	The (fully qualified) refname from which to show notes when
> -	showing commit messages.  The value of this variable can be set
> -	to a glob, in which case notes from all matching refs will be
> -	shown.  You may also specify this configuration variable
> -	several times.  A warning will be issued for refs that do not
> -	exist, but a glob that does not match any refs is silently
> -	ignored.
> -+
> -This setting can be overridden with the `GIT_NOTES_DISPLAY_REF`
> -environment variable, which must be a colon separated list of refs or
> -globs.
> -+
> -The effective value of "core.notesRef" (possibly overridden by
> -GIT_NOTES_REF) is also implicitly added to the list of refs to be
> -displayed.
> +	Which ref (or refs, if a glob or specified more than once), in
> +	addition to the default set by `core.notesRef` or
> +	'GIT_NOTES_REF', to read notes from when showing commit
> +	messages with the 'git log' family of commands.
> +	This setting can be overridden on the command line or by the
> +	'GIT_NOTES_DISPLAY_REF' environment variable.
> +	See linkgit:git-log[1].

Hmm. Both this and 4/8 rewrite bits of the configuration copied from
config.txt in an earlier patch. Do any changes need to be propagated
back to config.txt (and no, I didn't read and think carefully, so the
answer may be "no, they are now diverging intentionally")?

-Peff

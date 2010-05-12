From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 4/8] Documentation/notes: simplify treatment of default notes ref
Date: Wed, 12 May 2010 09:46:30 +0200
Message-ID: <201005120946.31193.trast@student.ethz.ch>
References: <20100509031357.GA7926@progeny.tock> <20100509032358.GD7958@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 12 09:47:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OC6f3-0002ER-5a
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 09:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072Ab0ELHrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 03:47:15 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:32316 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810Ab0ELHrN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 03:47:13 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 12 May
 2010 09:47:11 +0200
Received: from thomas.localnet (129.132.211.224) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 12 May
 2010 09:46:48 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <20100509032358.GD7958@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146925>

Jonathan Nieder wrote:
> @@ -187,13 +190,10 @@ CONFIGURATION
>  -------------
>  
>  core.notesRef::
> -	When showing commit messages, also show notes which are stored in
> -	the given ref.  The ref must be fully qualified.  If the given
> -	ref does not exist, it is not an error but means that no
> -	notes should be printed.
> -+
> -This setting defaults to "refs/notes/commits", and it can be overridden by
> -the 'GIT_NOTES_REF' environment variable.  See linkgit:git-notes[1].
> +	Notes ref to read and manipulate instead of
> +	`refs/notes/commits`.  Must be an unabbreviated ref name.
> +	This setting can be overridden through the environment and
> +	command line.

In the end result, this makes core.notesRef the only configuration
variable which does not have its environment sibling named explicitly
in the config section.  Would you mind putting GIT_NOTES_REF back in
the sentence for consistency with the other variables?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

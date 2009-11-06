From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] pre-commit.sample: Diff against the empty tree when
	HEAD is invalid
Date: Fri, 6 Nov 2009 18:11:35 +0100
Message-ID: <20091106171126.GA42592@book.hvoigt.net>
References: <20091105105757.GA31787@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 06 18:11:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6SLh-0004wx-Bq
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 18:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759478AbZKFRLd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Nov 2009 12:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759460AbZKFRLd
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 12:11:33 -0500
Received: from darksea.de ([83.133.111.250]:42237 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759344AbZKFRLc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 12:11:32 -0500
Received: (qmail 5242 invoked from network); 6 Nov 2009 18:11:36 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 6 Nov 2009 18:11:36 +0100
Content-Disposition: inline
In-Reply-To: <20091105105757.GA31787@atjola.homenet>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132312>

Hallo,

On Thu, Nov 05, 2009 at 11:57:57AM +0100, Bj=F6rn Steinbrink wrote:
> This was already the case for the old "diff --check" call, but the ne=
w
> one that checks whether there are any non-ascii file names was missin=
g
> it, making that check fail for root commits.
>=20
> Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>

[...]
> -	test "$(git diff --cached --name-only --diff-filter=3DA -z |
> +	test "$(git diff --cached --name-only --diff-filter=3DA -z $against=
 |

Looks sensible to me. Thanks for that fix.

As this went unnoticed for quite some time it seems as either not many
are actually using our example hook or at least not starting new
projects with it. I fit in the latter group I suppose.

cheers Heiko

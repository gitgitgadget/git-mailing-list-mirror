From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [RFC 1/4] Add diff-diff, which compares the diffs of two
	commits
Date: Sat, 15 Dec 2007 18:04:36 +0100
Message-ID: <20071215170436.GA22485@atjola.homenet>
References: <1197737505128-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Dec 15 18:05:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3aRi-0004qq-5w
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 18:05:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756158AbXLOREk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Dec 2007 12:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755947AbXLOREk
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 12:04:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:35007 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755202AbXLOREj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 12:04:39 -0500
Received: (qmail invoked by alias); 15 Dec 2007 17:04:37 -0000
Received: from i577B8893.versanet.de (EHLO localhost) [87.123.136.147]
  by mail.gmx.net (mp044) with SMTP; 15 Dec 2007 18:04:37 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+GOvN/CMuGjq+oe8aenXLmxD8wU2TmZFMpLm1K9j
	2S29ydUW71089c
Content-Disposition: inline
In-Reply-To: <1197737505128-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68399>

On 2007.12.15 17:51:42 +0100, Steffen Prohaska wrote:
> The following patch series adds experimental diff-diff support.
[...]
> At this point, I'm only seeking comments about the general direction.
> The patches should not be applied to git.git.
>=20
>  - Do you think something like this would be helpful?

I think I might use it to e.g. compare stuff when upstream modified the
patch I submitted.

>  - Are similar approaches already available?

interdiff from patchutils. Probably interdiff would also be a better
name than diff-diff, just to be consistent with what is already there.
And using interdiff instead of plain diff in your script might also
yield better results (I didn't use interdiff that often yet).

Bj=F6rn

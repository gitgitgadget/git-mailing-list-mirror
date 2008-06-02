From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-svn pulling down duplicate revisions
Date: Mon, 2 Jun 2008 19:59:53 +0200
Message-ID: <20080602175953.GA31685@atjola.homenet>
References: <1AD7D1A1-EC3B-450D-A648-04ADB8180E46@sb.org> <20080602050050.GC9904@hand.yhbt.net> <5FB2F28F-4C9A-422E-BF7D-B271471154F9@sb.org> <20080602054034.GA8366@untitled> <0E759330-1A0A-489D-ADA3-B71A49951227@sb.org> <20080602104225.GA8401@untitled> <C520B70F-2E61-42E6-AF20-E24E15A33CDD@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jun 02 20:00:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3EKy-0004Sf-La
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 20:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbYFBR76 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2008 13:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbYFBR76
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 13:59:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:42874 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751412AbYFBR75 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 13:59:57 -0400
Received: (qmail invoked by alias); 02 Jun 2008 17:59:55 -0000
Received: from i577BA71F.versanet.de (EHLO atjola.local) [87.123.167.31]
  by mail.gmx.net (mp043) with SMTP; 02 Jun 2008 19:59:55 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19seLMx9odsRJerGpQYIV8l86mIVBpwDYL4CjPfup
	zDW/AioQDsMBQt
Content-Disposition: inline
In-Reply-To: <C520B70F-2E61-42E6-AF20-E24E15A33CDD@sb.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83549>

On 2008.06.02 10:45:04 -0700, Kevin Ballard wrote:
> Incidentally, I just checked and when I start the git-svn clone, it
> starts pulling down revisions for the branch 'css_refactor@1559' (odd
> branch name, but it claimed to find multiple branch points for this
> 'css_refactor' branch). My guess is when it starts working on the nex=
t
> branch, it doesn't view it as related to css_refactor and starts
> pulling down the revisions again even though those revisions actually
> belonged to trunk.

Hm, you could probably test that theory at least for branches that
started from trunk I guess. First, clone trunk only, and then add the
branches/tags config entries and fetch the rest. If it holds, then the
duplication should be gone I guess.

Bj=F6rn

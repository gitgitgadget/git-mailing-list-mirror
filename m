From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: visualizing Git's Git repo
Date: Tue, 27 May 2008 02:41:32 +0200
Message-ID: <20080527004132.GA6400@atjola.homenet>
References: <CA563F5A-5E12-42F7-BDFD-04FE3A882028@reverberate.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Joshua Haberman <joshua@reverberate.org>
X-From: git-owner@vger.kernel.org Tue May 27 02:42:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0nGm-0002xe-DW
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 02:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957AbYE0Alh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 May 2008 20:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbYE0Alh
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 20:41:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:44476 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753894AbYE0Alg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 20:41:36 -0400
Received: (qmail invoked by alias); 27 May 2008 00:41:34 -0000
Received: from i577BA983.versanet.de (EHLO atjola.local) [87.123.169.131]
  by mail.gmx.net (mp029) with SMTP; 27 May 2008 02:41:34 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/rRi90NW7rogffhPJcRSGS2Al/R6cIwmGnK0lnQB
	d+DjKr0g0st0WW
Content-Disposition: inline
In-Reply-To: <CA563F5A-5E12-42F7-BDFD-04FE3A882028@reverberate.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82982>

On 2008.05.26 13:47:33 -0700, Joshua Haberman wrote:
> I'm a casual Git user.  One thing that's been troubling me about Git =
is=20
> that when I look at Git's own Git repository, the revision history is=
 not=20
> at all easy to understand.  I like to view my own Git repositories wi=
th:
>
> $ gitk --all --date-order
>
> When I run this command, what I'm really asking is "give me a visual =
=20
> summary of what's up with my project lately."  But with Git's =20
> repository, there are far too many branches and merges for this view =
to=20
> make any kind of visual sense.
>
> So my questions are:
>
> 1. what do you all do to get a high-level view of what's going on wit=
h =20
> Git development?  do you use gitk?  if so, what options?

Doesn't make much sense with --all, but if you only view one branch, eg=
=2E
origin/master or origin/next, --no-merges might produce an output that'=
s
more suitable for you.

Bj=F6rn

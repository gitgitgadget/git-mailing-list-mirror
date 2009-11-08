From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Strange behavior (possible bug) using bash command subsitution
 with "git branch"
Date: Sun, 8 Nov 2009 23:49:55 +0100
Message-ID: <20091108224955.GA14095@atjola.homenet>
References: <C71C822C.22429%kate@ning.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kate Ebneter <kate@ning.com>
X-From: git-owner@vger.kernel.org Sun Nov 08 23:50:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7GaD-0001ON-Qa
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 23:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755673AbZKHWtz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 17:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755668AbZKHWtz
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 17:49:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:42445 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755614AbZKHWty (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 17:49:54 -0500
Received: (qmail invoked by alias); 08 Nov 2009 22:49:58 -0000
Received: from i59F555E5.versanet.de (EHLO atjola.homenet) [89.245.85.229]
  by mail.gmx.net (mp069) with SMTP; 08 Nov 2009 23:49:58 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1++hPlSbWa+7Hr+8SMaFQE9opOHMiOeY+RM5PNSlf
	kGV3Gx+jNWPHwK
Content-Disposition: inline
In-Reply-To: <C71C822C.22429%kate@ning.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132425>

On 2009.11.08 14:11:56 -0800, Kate Ebneter wrote:
> Hi, folks,
>=20
> I ran into a weird situation while working on a script, which is best
> described with a little snippet from my gitosis-admin repository:
>=20
>     $ git branch
>     * master
     ^^^

>     $ branch=3D$(git branch)
>     $ echo $branch
>     gitosis.conf keydir master

Your shell expands the *, thus echo sees all the things in the current
directory. Use 'echo "$branch"' and you'll see what you expected.

Bj=F6rn

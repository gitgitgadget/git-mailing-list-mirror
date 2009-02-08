From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase: do not fail silently when the HEAD could not be
 detached
Date: Sun, 8 Feb 2009 11:27:45 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902081125400.10279@pacific.mpi-cbg.de>
References: <cover.1234027102u.git.johannes.schindelin@gmx.de> <679be9321b4cf4f694917cb9eebba70376a43a0a.1234027102u.git.johannes.schindelin@gmx.de> <20090207233524.GD11623@atjola.homenet> <7v7i414qb9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1228596350-1234088865=:10279"
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 11:28:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW6tw-0007Aq-1s
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 11:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbZBHK1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 05:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753142AbZBHK1H
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 05:27:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:60039 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753078AbZBHK1G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 05:27:06 -0500
Received: (qmail invoked by alias); 08 Feb 2009 10:27:03 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 08 Feb 2009 11:27:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/PnaoXAm/Pld0V2kLfaylmRT3yOhmqBEhmgVn7U8
	y97Kp7ZlsJN56b
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v7i414qb9.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108947>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1228596350-1234088865=:10279
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 7 Feb 2009, Junio C Hamano wrote:

> Björn Steinbrink <B.Steinbrink@gmx.de> writes:
> 
> > On 2009.02.07 18:20:09 +0100, Johannes Schindelin wrote:
> >> Since 6fd2f5e(rebase: operate on a detached HEAD), rebase operates on a
> >> detached HEAD.  However, it used "checkout -q" to detach the HEAD, which
> >> hid an error message when, say, an untracked file would have to be
> >> overwritten to detach the HEAD.
> >
> > Hm, in 324c2c317 "git-rebase: report checkout failure", that was
> > switched from a stdout/stderr redirect to -q, so that those error
> > messages are shown. And with a quick test, rebase/checkout complains
> > just fine:
> 
> Very interesting.
> 
> Dscho, how did you get the "important part of error information is hidden"
> failure that led to this patch?  Did it come from code inspection and
> speculation alone, or was there an actual failure case?

Hmm, sorry, I thought I got this with "my" Git, but it appears that due to 
some strange reason I do not understand completely, I was not actually 
using the Git binary from $HOME/bin/, but /usr/bin/.

> If I apply the patch t/t3400-rebase.sh from your message alone to
> 'master', it does seem to pass.

Well, please ignore the patch, then.  Or take the test alone.

Ciao,
Dscho

--8323328-1228596350-1234088865=:10279--

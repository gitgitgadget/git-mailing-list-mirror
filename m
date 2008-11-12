From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Bug: UTF-16, UCS-4 and non-existing encodings for git log result
 in incorrect behavior
Date: Wed, 12 Nov 2008 17:15:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811121714280.30769@pacific.mpi-cbg.de>
References: <85647ef50811120532h778769ddx69f0b111dbad359a@mail.gmail.com>  <alpine.DEB.1.00.0811121521390.30769@pacific.mpi-cbg.de> <85647ef50811120727j730cb6e3lf4103c200d042fb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 17:09:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0IGx-0002t4-DT
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 17:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbYKLQHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 11:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbYKLQHe
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 11:07:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:44680 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751086AbYKLQHd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 11:07:33 -0500
Received: (qmail invoked by alias); 12 Nov 2008 16:07:31 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp061) with SMTP; 12 Nov 2008 17:07:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Gjn8xPtZGTl/eXIVxJzLHGG5S8r0jbTqyckthHd
	i05RHOB92iaKLc
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <85647ef50811120727j730cb6e3lf4103c200d042fb9@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100761>

Hi,

[re Cc:ing the list]

On Wed, 12 Nov 2008, Constantine Plotnikov wrote:

> On Wed, Nov 12, 2008 at 5:22 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 12 Nov 2008, Constantine Plotnikov wrote:
> >
> >> If UTF-16[BE|LE] or UCS-4[BE|LE] encodings are used with git log, the
> >> git completes successfully but commit messages and author information
> >> are not shown. I suggest that git should fail with fatal error if such
> >> zero producing encoding is used.
> >>
> >> If the incorrect encoding name is used, the git log does not perform any
> >> re-encoding, but just display commits in their native encoding. I
> >> suggest that git should fail with fatal error in this case as well.
> >
> > Have you set the correct encoding with i18n.commitEncoding?  If not, you
> > should not be surprised: Git's default encoding is UTF-8, and that fact is
> > well documented, AFAICT.
> >
> Commit encoding is set correctly. The problem is that git log and git
> show do not support the *output* encodings UTF-16 and UCS-4 and
> silently fail in that case instead of reporting the error.

That looks more like an iconv bug to me.  I assume you are using Windows?

Ciao,
Dscho

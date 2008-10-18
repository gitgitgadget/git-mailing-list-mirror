From: Johan Herland <johan@herland.net>
Subject: Re: Archiving tags/branches?
Date: Sat, 18 Oct 2008 13:15:49 +0200
Message-ID: <200810181315.49265.johan@herland.net>
References: <48F93F52.4070506@pcharlan.com> <20081018102345.GA3749@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?iso-8859-1?q?G=E1bor?= <szeder@ira.uka.de>,
	Pete Harlan <pgit@pcharlan.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 18 13:17:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr9nu-0003zD-Pm
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 13:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbYJRLPy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Oct 2008 07:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbYJRLPy
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 07:15:54 -0400
Received: from smtp.getmail.no ([84.208.20.33]:41457 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbYJRLPy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Oct 2008 07:15:54 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K8X00J0FLYFQ100@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 18 Oct 2008 13:15:51 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K8X00B2WLYD4V40@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 18 Oct 2008 13:15:49 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K8X0031BLYDLBF0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 18 Oct 2008 13:15:49 +0200 (CEST)
In-reply-to: <20081018102345.GA3749@neumann>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98537>

On Saturday 18 October 2008, SZEDER G=E1bor wrote:
> Hi Pete,
>
> On Fri, Oct 17, 2008 at 06:43:46PM -0700, Pete Harlan wrote:
> >  If I wanted to archive those, it looks like this would work:
> >
> > mkdir .git/refs/archived-tags
> > cp -a .git/refs/tags/* .git/refs/archived-tags
> > git tag -d <tag-to-hide> # repeat as necessary
> >
> > I can then maintain a short list of tags that currently interest me=
,
> > but am guaranteed not to lose old branches (say) referenced by thos=
e
> > tags.
> >
> > Is there a reason this won't work?
>
> Yes:
>
> [...]
>
> So, if you put any tags or branches under refs/whatever-non-standard/=
,
> then it gets deleted when you gc (or when gc is run automatically).
>
> I don't know whether this behaviour is intentional or not, but I have
> experienced this the hard way recently.

Go have a look in .git/packed-refs. Then have a read through=20
git-pack-refs(1).


Have fun! :)

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net

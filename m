From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Trying to use git-filter-branch to compress history by removing large, obsolete binary files
Date: Mon, 8 Oct 2007 12:05:59 +0200
Message-ID: <20071008100559.GA9221@diana.vm.bytemark.co.uk>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com> <20071007213817.GJ31659@planck.djpig.de> <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com> <20071007221920.GF2765@steel.home> <51419b2c0710071524q16e9c593s2722dffc826e560d@mail.gmail.com> <20071007234346.GA29433@potapov> <51419b2c0710071722k576c06d9i2f4dce730eae2059@mail.gmail.com> <20071008010648.GB29433@potapov> <4709F805.8050704@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Oct 08 12:06:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IepVO-0007Q2-Nq
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 12:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbXJHKGV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2007 06:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbXJHKGV
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 06:06:21 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4471 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbXJHKGU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 06:06:20 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IepUt-0002PT-00; Mon, 08 Oct 2007 11:05:59 +0100
Content-Disposition: inline
In-Reply-To: <4709F805.8050704@op5.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60311>

On 2007-10-08 11:27:33 +0200, Andreas Ericsson wrote:

> Dmitry Potapov wrote:
>
> > On Sun, Oct 07, 2007 at 06:22:28PM -0600, Elijah Newren wrote:
> >
> > > What other scenarios could lead to unreachable references?
> >
> > Any re-writing of history leads to that.
>
> git-rebase being the most common culprit, right alongside 'git
> commit --amend'.

StGit (and presumably guilt, and any other similar tool) are just
glorified rebase wrappers, so they'll generate tons of unreachable
objects too.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Tue, 7 Apr 2009 14:45:45 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904071443530.6897@intel-tinevez-2-302>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>  <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com>  <200904060117.24810.markus.heidelberg@web.de>  <fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com> 
 <20090406032457.GA14758@gmail.com>  <7v63hie4yh.fsf@gitster.siamese.dyndns.org>  <871vs5kjfw.fsf@krank.kagedal.org>  <7vy6ud4otd.fsf@gitster.siamese.dyndns.org>  <94a0d4530904061213pabd87aj9db577aaa231945c@mail.gmail.com>  <20090406192514.GI20356@atjola.homenet>
 <94a0d4530904070301k62687e2i772637068494ab74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1436002605-1239108346=:6897"
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?David_K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	markus.heidelberg@web.de
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 14:48:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrAiM-0000fG-H7
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 14:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbZDGMpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 08:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbZDGMps
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 08:45:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:39728 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751528AbZDGMps (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 08:45:48 -0400
Received: (qmail invoked by alias); 07 Apr 2009 12:45:46 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp067) with SMTP; 07 Apr 2009 14:45:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xcjApocIxhl8ScHmZm1w4gCNRqucTivemrwRARs
	57mePdeaKYSm5U
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <94a0d4530904070301k62687e2i772637068494ab74@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115952>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1436002605-1239108346=:6897
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 7 Apr 2009, Felipe Contreras wrote:

> On Mon, Apr 6, 2009 at 10:25 PM, Björn Steinbrink <B.Steinbrink@gmx.de> wrote:
> > On 2009.04.06 22:13:26 +0300, Felipe Contreras wrote:
> >> On Mon, Apr 6, 2009 at 9:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> > David Kågedal <davidk@lysator.liu.se> writes:
> >> >
> >> >> What do you mean? This was a suggestion for how git diff should
> >> >> work. I fail to see how you would need a WORKTREEANDTHEINDEX there.
> >> >
> >> > You are talking only about "git diff".  I am talking about the whole git
> >> > suite, because you have to worry about how such a proposal would affect
> >> > other parts of the UI.
> >>
> >> How do currently do you something like this:
> >> git diff HEAD^..STAGE
> >
> > git diff --cached HEAD^
> >
> > The "hard" (and pretty weird) one would be "git diff STAGE..HEAD^",
> > which is:
> >
> > git diff -R --cached HEAD^
> 
> Sorry, that's what I meant.
> 
> So it's possible, but completely unintuitive, and different from other
> use cases.

At least it is consistent.

You are always able to say "-R" if you want to have the reverse diff, this 
is commonly known from GNU diff and other diff implementations.

Also, "git diff --cached" is _only_ a shortcut for "git diff --cached 
HEAD".  This is yet another proof that you should not teach the shortcuts 
first, it _harms_ understanding.

Ciao,
Dscho

--8323329-1436002605-1239108346=:6897--

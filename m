From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/25] parse-options: make some arguments optional, add
  callbacks.
Date: Wed, 17 Oct 2007 19:00:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710171900060.25221@racer.site>
References: <1192523998-19474-1-git-send-email-madcoder@debian.org>
 <1192523998-19474-2-git-send-email-madcoder@debian.org>
 <1192523998-19474-3-git-send-email-madcoder@debian.org>
 <1192523998-19474-4-git-send-email-madcoder@debian.org>
 <1192523998-19474-5-git-send-email-madcoder@debian.org>
 <1192523998-19474-6-git-send-email-madcoder@debian.org>
 <1192523998-19474-7-git-send-email-madcoder@debian.org> <20071016084510.GI6919@artemis.corp>
 <4714E90C.80305@lsrfire.ath.cx> <20071016165045.GB13946@artemis.corp>
 <20071017044405.GV13801@spearce.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-905746007-1192644035=:25221"
Cc: Pierre Habouzit <madcoder@debian.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 20:02:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiDDT-0002IY-Q1
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 20:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756353AbXJQSAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 14:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756183AbXJQSAw
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 14:00:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:43963 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754437AbXJQSAv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 14:00:51 -0400
Received: (qmail invoked by alias); 17 Oct 2007 18:00:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp058) with SMTP; 17 Oct 2007 20:00:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7TbwNpKj7yeXanNaW2JiJ8TffwPoyIKpIWn61x+
	o6o+S9TSScQgTs
X-X-Sender: gene099@racer.site
In-Reply-To: <20071017044405.GV13801@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61401>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-905746007-1192644035=:25221
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 17 Oct 2007, Shawn O. Pearce wrote:

> Pierre Habouzit <madcoder@debian.org> wrote:
> > On Tue, Oct 16, 2007 at 04:38:36PM +0000, René Scharfe wrote:
> > > Pierre Habouzit schrieb:
> > > > This bit is to allow to aggregate options with arguments together when
> > > > the argument is numeric.
> > > > 
> > > >     +#if 0
> > > >     +		/* can be used to understand -A1B1 like -A1 -B1 */
> > > >     +		if (flag & OPT_SHORT && opt->opt && isdigit(*opt->opt)) {
> > > >     +			*(int *)opt->value = strtol(opt->opt, (char **)&opt->opt, 10);
> > > >     +			return 0;
> > > >     +		}
> > > >     +#endif
> > > 
> > > I don't like it, it complicates number options with unit suffixes (e.g.
> > > --windows-memory of git-pack-objects).
> ...
> >   This is a very strong argument _against_ this chunk IMO.
> 
> Since everyone (including myself)

... except for me ...

> is apparently strongly against this hunk I removed it when I 
> cherry-picked this series from Pierre into my tree.  The series will be 
> in my pu tonight, but minus this hunk.

I can live without this hunk.

Ciao,
Dscho

--8323584-905746007-1192644035=:25221--

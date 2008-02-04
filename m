From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Mon, 4 Feb 2008 14:36:27 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802041436020.7372@racer.site>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com>  <1201975757-13771-1-git-send-email-hjemli@gmail.com>  <alpine.LSU.1.00.0802021815510.7372@racer.site>  <8c5c35580802021047o41a7de9fi84a6b33f0f779e2e@mail.gmail.com> 
 <7vwsplporv.fsf@gitster.siamese.dyndns.org>  <alpine.LSU.1.00.0802040024030.7372@racer.site> <8c5c35580802040359v1a5d8c42xfbc592245a8917c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 15:37:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM2S6-00006c-E4
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 15:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755298AbYBDOhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 09:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754395AbYBDOhI
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 09:37:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:34984 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754645AbYBDOhG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 09:37:06 -0500
Received: (qmail invoked by alias); 04 Feb 2008 14:37:04 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp025) with SMTP; 04 Feb 2008 15:37:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/hIpTL7K/LGwdLiL2K+aw4lm2PIv9aJy2riG+MG
	OIXb7OmkiQCIhe
X-X-Sender: gene099@racer.site
In-Reply-To: <8c5c35580802040359v1a5d8c42xfbc592245a8917c2@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72508>

Hi,

On Mon, 4 Feb 2008, Lars Hjemli wrote:

> On Feb 4, 2008 1:24 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Sun, 3 Feb 2008, Junio C Hamano wrote:
> > > For now I haven't picked up any of the "how about this way" 
> > > revisions.
> >
> > Yeah, I think all my comments have been addressed...  Lars, care to 
> > send a new version?
> 
> Sure, but we should come to a conclusion on "GITDIR" vs. "GIT_DIR" vs. 
> "gitdir" vs. "directory" vs. "ref". The reason I used "GITDIR" was to 
> keep the door open for additional parameters in the "gitfile" (but it 
> should obviously have been "GIT_DIR" for that usage since its value is 
> used to specify $GIT_DIR). If it's more likely that we'll use this as a 
> general substitute for symlinks, I think "ref" is better due to the 
> existing symbolic refs.
> 
> My preference would be "GIT_DIR" (or "git_dir") since we also might want 
> the "WORKDIR_HASH" Shawn mentioned.

FWIW I like "gitdir" or "git-dir" best.

Ciao,
Dscho

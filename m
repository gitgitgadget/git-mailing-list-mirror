From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RESEND] git-submodule: add support for --rebase.
Date: Tue, 21 Apr 2009 10:47:53 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904211047311.10279@pacific.mpi-cbg.de>
References: <20090419233051.GA17946@dingo.bne.redhat.com> <alpine.DEB.1.00.0904201152360.6955@intel-tinevez-2-302> <20090421074540.GA7885@dingo.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
X-From: git-owner@vger.kernel.org Tue Apr 21 10:48:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwBeq-0000YM-Vc
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 10:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbZDUIqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 04:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755976AbZDUIqU
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 04:46:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:50879 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755949AbZDUIqT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 04:46:19 -0400
Received: (qmail invoked by alias); 21 Apr 2009 08:46:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 21 Apr 2009 10:46:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+tTN1FTJCtMB657RIj/rKqx0DlymYwzn2KbGuzYf
	sKMtxnDduayKS+
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090421074540.GA7885@dingo.redhat.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117104>

Hi,

On Tue, 21 Apr 2009, Peter Hutterer wrote:

> On Mon, Apr 20, 2009 at 11:55:54AM +0200, Johannes Schindelin wrote:
> > On Mon, 20 Apr 2009, Peter Hutterer wrote:
> > 
> > > 'git submodule update --rebase' rebases your local branch on top of what would
> > 
> > This line is so long that it got wrapped in my mail program.  But it is 
> > even worse: we would like to show this in an 80-column display with a 
> > 4-space indent, so it would be nice if you could rewrap to 76 columns (I 
> > even use 72 columns, because it looks nicer).
> 
> amended to 72 cols, see below.

Thanks.

> > > I'm still unsure about whether to change the wording (it currently uses 
> > > the same terms as git-rebase and the rest of the git-submodule man 
> > > page). Please let me know what to do to get this patch done.
> > 
> > AFAIR I gave an alternative wording, am I wrong?
> 
> yes, but tbh. I found it a bit confusing. Your suggestion was
> 
>        "Instead of detaching the HEAD to the revision committed in the
>         superproject, rebase the current branch onto that revision."
> 
> How about this one, basically the same but split up in two sentences:
> 
> +--rebase::
> +	This option is only valid for the update command.
> +	Rebase the current branch onto the commit recorded in the
> +	superproject. If this option is given, the submodule's HEAD will not
> +	be detached. If a a merge failure prevents this process, you will have
> +	to resolve these failures with linkgit:git-rebase[1].

Way better!

Thank you,
Dscho

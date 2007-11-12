From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 12 Nov 2007 12:33:19 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711121232370.4362@racer.site>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org>
 <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
 <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0711121203150.4362@racer.site> <20071112122652.GC20482@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 13:33:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrYUC-000604-Kd
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 13:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758260AbXKLMdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 07:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758257AbXKLMdf
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 07:33:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:44841 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758206AbXKLMde (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 07:33:34 -0500
Received: (qmail invoked by alias); 12 Nov 2007 12:33:32 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp019) with SMTP; 12 Nov 2007 13:33:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19vKHwpq7NvjMU7rmL0HLiwK+11u8Qv2/7yA5fml4
	xb3G0G+SUgXKIU
X-X-Sender: gene099@racer.site
In-Reply-To: <20071112122652.GC20482@artemis.corp>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64613>

Hi,

On Mon, 12 Nov 2007, Pierre Habouzit wrote:

> On Mon, Nov 12, 2007 at 12:21:34PM +0000, Johannes Schindelin wrote:
> 
> > On Sun, 11 Nov 2007, Junio C Hamano wrote:
> > 
> > > * js/rebase-detached (Thu Nov 8 18:19:08 2007 +0000) 1 commit
> > >  + rebase: operate on a detached HEAD
> > 
> > Note: this might have a subtle bug when the last patch in the series 
> > failed.  If I was not too tired this morning (which might well have 
> > been the case), rebase could not switch back to the branch correctly 
> > with this.
> 
>   OOOH so this was what happened to me today then. I did a rebase, there 
> was a commit to skip, the last one, and I ended up on a detached head. 
> As I didn't had my coffee yet, I assumed this was my fault and did 
> something stupid. So after all it seems it wasn't the case then :)

Thanks for acknowleding, and sorry for the bug.

Will work on a fix,
Dscho

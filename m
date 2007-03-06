From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Support of "make -s": do not output anything of the build itself
Date: Wed, 7 Mar 2007 00:33:25 +0100
Message-ID: <81b0412b0703061533o532dfeedo1aeb65723717227a@mail.gmail.com>
References: <81b0412b0703061514m2f2b3237yd1192dd651a1109e@mail.gmail.com>
	 <20070306232927.GB25785@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:33:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOj9u-000072-93
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 00:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030713AbXCFXd1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 18:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030714AbXCFXd1
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 18:33:27 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:7350 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030713AbXCFXd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 18:33:26 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2664454nfa
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 15:33:25 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XAQiJ6eyQrAoI/PDLTMFxXCSXHpYuKM0MfWfdFFL22D9DEBqDcfNmt1GfYz1cMCbpqibhmqLS4+dwidOAQYg158358jcago/4Fs/6NAXZcD4cZUOxgy0xMIitb0LW/5NOn2b47hxF/Ha69oy3kJjBVRBvinJl+r+GJl7C+N+kGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d26fcxsWBxA1VmXpfsIk2BU0vRO/eCu6ArgLz915wfCh5eiRQ+RfkkoJZfJLLvv5Rrz5LLgt/8u+5erkn4e7BtGvseO2/APleNjzdor5b+2AiXr2mxW07kshF0zFAp6bmWo6ODAEpTCSh7rOfKiKhdQ5L4mAs6dxxoiQZ60rX7o=
Received: by 10.78.205.7 with SMTP id c7mr877735hug.1173224005297;
        Tue, 06 Mar 2007 15:33:25 -0800 (PST)
Received: by 10.78.138.5 with HTTP; Tue, 6 Mar 2007 15:33:25 -0800 (PST)
In-Reply-To: <20070306232927.GB25785@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41620>

This message will break the thread (which is short yet). Gmail again,
but I really want it to get to the list.

On 3/7/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Alex Riesen <raa.lkml@gmail.com> wrote:
> > Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> > ---
> > Makefile         |   10 +++++++---
> > git-gui/Makefile |    5 -----
> > 2 files changed, 7 insertions(+), 8 deletions(-)
>
> Nack.  You need to split any git-gui changes into their own patch
> so that I can apply them to the git-gui repository directly.

Right. Sorry, I completely forgot about that. Will redo it.

> git-gui can be built on its own, outside of git.git's make system.
> I need the ifneq(...-s...) thing above also here, around the
> existing ifndef.
>
> Want to rework the patch as two?  ;-)

Will do.

P.S. I'm glad that someone can here me from here :)

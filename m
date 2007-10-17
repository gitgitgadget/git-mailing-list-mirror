From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Thu, 18 Oct 2007 01:36:23 +0200
Message-ID: <200710180136.24090.chriscool@tuxfamily.org>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org> <20071017073538.GB13801@spearce.org> <Pine.LNX.4.64.0710171906280.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 18 01:29:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiIKW-0005Wq-V4
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 01:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756966AbXJQX3X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Oct 2007 19:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756920AbXJQX3X
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 19:29:23 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:39840 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755418AbXJQX3V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2007 19:29:21 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 2407F1AB2BE;
	Thu, 18 Oct 2007 01:29:20 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 06B141AB2BB;
	Thu, 18 Oct 2007 01:29:20 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0710171906280.25221@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61439>

Hi,

Le mercredi 17 octobre 2007, Johannes Schindelin a =E9crit :
> Hi,
>
> On Wed, 17 Oct 2007, Shawn O. Pearce wrote:
> > Christian Couder <chriscool@tuxfamily.org> wrote:
> > > Here is my bisect dunno patch series again.
> > > The changes since last time are the following:
> >
> > I now have this series queued in my pu branch.  It passes the tests
> > it comes with, and doesn't appear to break anything, but apparently
> > there is also still some debate about what a dunno should be called
> > ("unknown", "void", "ugly", "dunno", "skip" ...).
>
> AFAICT these are all bikeshed painting arguments, not technical
> arguments. I was initially opposed to having --bisect-all, wanting to
> have
> --bisect-dunno <ref>...
>
> But in the end, the people doing the work decide, and therefore I am =
fine
> with --bisect-all, especially since it seems clean enough for me.
>
> As for all those "dunno is no English"...  I'd first merge the techni=
cal
> part (i.e. what you have now in pu), and then let the discussion abou=
t
> which synonyms to choose continue, until a consensus is formed about
> other names (if there is a consensus at all!).
>
> IMHO there is no reason to hold of the fine work of Christian,

It's also the fine work of Junio as he wrote most of=20
the "rev-list --bisect-all" patch.

> just=20
> because there are non-technical arguments still in the air.
>
> I want bisect dunno.  Even if there is another name later.

Thanks for your kind words,
Christian.

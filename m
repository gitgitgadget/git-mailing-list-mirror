From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/4] fast-import: define a new option command
Date: Thu, 13 Aug 2009 15:17:59 -0700
Message-ID: <fabb9a1e0908131517k334e5215mae565549768a1dde@mail.gmail.com>
References: <fabb9a1e0908130926qdc6cdf1ka7f2442421ce12ce@mail.gmail.com> 
	<fabb9a1e0908131009j51c54cacp3f837f9b8525061@mail.gmail.com> 
	<20090813172508.GO1033@spearce.org> <fabb9a1e0908131028t438509d2m180293ca95daad74@mail.gmail.com> 
	<20090813174119.GP1033@spearce.org> <fabb9a1e0908131044g583f126dm6a3818b4b295eaf5@mail.gmail.com> 
	<20090813175211.GQ1033@spearce.org> <alpine.DEB.1.00.0908132350190.8306@pacific.mpi-cbg.de> 
	<fabb9a1e0908131501o73807f81mb230530c284ad123@mail.gmail.com> 
	<20090813221213.GR1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 14 00:18:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbicu-00050a-Rw
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 00:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903AbZHMWSU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Aug 2009 18:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754626AbZHMWSU
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 18:18:20 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:44502 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754407AbZHMWST convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Aug 2009 18:18:19 -0400
Received: by ey-out-2122.google.com with SMTP id 22so226170eye.37
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 15:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=+1Dk3ugYPYlbi32xNkCtQzcUrPIL+Aax+5MsfE1eZOc=;
        b=HdazPNib3s571pJQYdLCkquTtP/PbUFS86A8Kn2htScvw87PDe3eK5UFUt4vTkfbOq
         8AWl7PZxOt61VPVhnOr+REYeXr01FlEGKLUpIVzlNdScQFwC+KPE1HhkgLNd2ShY1Vuv
         XwXXRKjFaNHxYeVGfXQ0i4osVF0MSU3GVHW0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dxdx/gCbX4wfemPpjRjYCM5WaR479rSMxiFT1sj76ouSlRRbGgPIDgX4jZ0E/gMDNa
         bgVKuCR4v/v2CJLR/V85n5k01zj49umbeKY9cH5cA6EEntzCPGLLXBC5O/bDOyTVmbvT
         XV1EXfGdML6BSiUGVVbJc1Ciu7sTJ0Vp5OSIY=
Received: by 10.216.87.131 with SMTP id y3mr275158wee.9.1250201899115; Thu, 13 
	Aug 2009 15:18:19 -0700 (PDT)
In-Reply-To: <20090813221213.GR1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125887>

Heya,

On Thu, Aug 13, 2009 at 15:12, Shawn O. Pearce<spearce@spearce.org> wro=
te:
> No, I don't have a really good reason for the command line overrides
> the file other than this simple rule:

Nice anecdote :P.

> What is this, gang up on Shawn's words-of-wisdom week? =A0Both this
> thread and my intern this week have been argueing with me about
> what seem to me to be fairly trivial things. =A0Maybe I just need to
> take vacation. =A0Good thing I have one coming in 5 weeks.

Didn't you get the memo, you could be crashing an airplane [0] like tha=
t ;).

> I say use the version where we store the values (e.g. file names)
> during option parsing, and then actually apply those saved values
> just before the first non-option command. =A0Which I think only has
> an impact on the import-marks option, the rest are all just simple
> variable updates whose values aren't read until after the first
> non-option command anyway.

Ok, that's v3, speaking of which, does it look good enough for inclusio=
n?

[0] http://www.thehackerchickblog.com/2009/05/plane-crashes-software-fa=
ilures-and.html

--=20
Cheers,

Sverre Rabbelier

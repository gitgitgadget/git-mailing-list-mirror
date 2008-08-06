From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-svn on MSysGit and why is it (going to be?) unsupported
Date: Wed, 6 Aug 2008 11:23:13 -0400
Message-ID: <32541b130808060823h2bda0ca0qfc21ea3b3403888a@mail.gmail.com>
References: <200807231544.23472.litvinov2004@gmail.com>
	 <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness>
	 <200807231852.10206.litvinov2004@gmail.com>
	 <alpine.DEB.1.00.0807231356540.8986@racer>
	 <20080806111545.GD32184@machine.or.cz>
	 <alpine.DEB.1.00.0808061436310.9611@pacific.mpi-cbg.de.mpi-cbg.de>
	 <20080806135100.GB10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Alexander Litvinov" <litvinov2004@gmail.com>, git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Aug 06 17:24:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQksB-0004ZQ-CA
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 17:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757078AbYHFPXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 11:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756968AbYHFPXR
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 11:23:17 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:43991 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756871AbYHFPXP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 11:23:15 -0400
Received: by yx-out-2324.google.com with SMTP id 8so323253yxm.1
        for <git@vger.kernel.org>; Wed, 06 Aug 2008 08:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kvyFJnHT2hluiIeHU2Cmsy8ZWhVWLodl40VDLLBp29s=;
        b=aynHbZLpt2GGPui95N6b+DQjel/KSI9vln1Ov9RNRjy3Yln0RvO+AhnDlEr4ywFsk5
         VCs3x6Em0+WRRiL2yoxiL8ptE3a6bMzO8DaKg+pjlB3Slfvk3EmZpk6jAGoAdWcM6zz6
         Kbc2y8ls4t5JIurDItv1URQPJ2i6WWN0rSn8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gbB+xpEx05hc28s3R/ePMx9yIBI7UhqGr5KbEyNvmsf1JkoJJtnYsU90wQ23Md4lPg
         PC47UhZdsQyTOWgWs2W6PtWEUaS67cuf2M2+MYjc1i6D6rqDfBe5TusSJaoNLJDyMYlV
         QHH3NE0uHiOpKrhcZ0uHzvn7EY1g1khKoqD2I=
Received: by 10.151.108.21 with SMTP id k21mr3549585ybm.151.1218036193712;
        Wed, 06 Aug 2008 08:23:13 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Wed, 6 Aug 2008 08:23:13 -0700 (PDT)
In-Reply-To: <20080806135100.GB10151@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91518>

On 8/6/08, Petr Baudis <pasky@suse.cz> wrote:
>  On Wed, Aug 06, 2008 at 02:43:51PM +0200, Johannes Schindelin wrote:
>  > And _noone_ of those competent Windows git-svn users seemed fit or willing
>  > to do anything about git-svn, not even the simplest of issues.
>
>  I can of course understand that argument, even though it's a bit sad to
>  see when the issues are apparently either trivial or there is simple
>  workaround available. My trouble was that the _concrete_ reasons for
>  this are buried deep inside long mail threads (or threads on other
>  mailing lists).
>
>  > If you want to do something about it, go ahead.  But I have no inclination
>  > of hearing from any Windows user about git-svn again, ever.
>
>  Not currently, I'm just afraid I *might* have to sometime in the future.
>  ;-)

FWIW (and related to the subject line in this thread), I think there
are a lot of git users on Windows who just use the cygwin one.  That's
what I do, and git-svn works fine (I don't use autocrlf though, which
is probably why it worked).  git's support for both platforms, and the
fact that cygwin was first and works already, probably greatly reduces
the number of developers who want to fix msysgit.

Have fun,

Avery

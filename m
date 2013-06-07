From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sat, 8 Jun 2013 01:11:37 +0530
Message-ID: <CALkWK0ntWzJj1AkDzv9VvS+7e3B17HFkZLQhAu-7pQv6M7=dkw@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org>
 <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
 <CALkWK0n2VsEP31jMB2kZ4x=wa90o8QPkR=ZWETfm=H5RC1kKcg@mail.gmail.com>
 <alpine.DEB.1.00.1306070518510.28957@s15462909.onlinehome-server.info> <CAMP44s3xbvaftqbWA97S=OEFguCbRdA45ryEXECnL7yDf+L0Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1ecKtbiBUaMOhaSBOZ8O3YyBEdXk=?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 21:42:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul2YK-00028T-1F
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 21:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754Ab3FGTmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 15:42:19 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:39428 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920Ab3FGTmT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 15:42:19 -0400
Received: by mail-ie0-f170.google.com with SMTP id e14so11824586iej.1
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 12:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jMJTzrls3aByCFsvnZ45whkm3riO4Br0sMOLPRsfE9o=;
        b=glZr605RSZaRDBkKrUfOcXT0esE+7CRoqn/bcD37/dh/iVj5AGI3kV/1+nDG/FQNb/
         pAwdJCbgCHskbdHYTsmdlalvN1hl8KEiwfkvgqf0uycMpyLKYm4vgYv+wol9FGvLXZx/
         I/ue7CTVi7lVzsb5KW842bFQjc0lA+r3C0E8/jBFpN4PH1TxQIDVCevma8zfi4RnJTE8
         ifzF3T1yq+Ei5u75eW00bize4PMN3aMW1mcEkIiTZUZTEAo6at/dQ8DqHS4eQ8UKM4Tx
         OTYgBgLQiwlr76H3S4xChm99t0ZIBIAzhF3GxKZU0OHKiepxSzI1vxdDtaFYtBznJzSm
         ljpw==
X-Received: by 10.50.107.6 with SMTP id gy6mr94890igb.57.1370634138734; Fri,
 07 Jun 2013 12:42:18 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 12:41:37 -0700 (PDT)
In-Reply-To: <CAMP44s3xbvaftqbWA97S=OEFguCbRdA45ryEXECnL7yDf+L0Uw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226688>

Felipe Contreras wrote:
> While at it, why not re-evaluate the whole msysgit approach? I bet we
> don't need a whole separate project just to create a Windows
> installer. I've written Windows installers before, it's very easy to
> do from Linux.

Yeah, taking the pain out of msysgit packaging would be a great way to
counter this new-dependency-fud.  The main problem, as mm pointed out
is subversion + perlxs [1].  Any idea how to tackle that?

[1]: https://github.com/msysgit/msysgit/wiki/Frequently-Asked-Questions

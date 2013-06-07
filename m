From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 7 Jun 2013 23:44:43 +0530
Message-ID: <CALkWK0=RU1Sv9X6oyYYSSGfhEHYT6nbrr8gACN4XX-+=DTG54Q@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org>
 <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
 <CALkWK0n2VsEP31jMB2kZ4x=wa90o8QPkR=ZWETfm=H5RC1kKcg@mail.gmail.com>
 <alpine.DEB.1.00.1306070518510.28957@s15462909.onlinehome-server.info>
 <CALkWK0nUoF2VX6Ns09vQHYo11520_4r9ikYmkZW108aQm1RpoQ@mail.gmail.com> <vpqhah9248u.fsf@anie.imag.fr>
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
	=?UTF-8?B?Tmd1ecKtbiBUaMOhaSBOZ8O3Yw==?= <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 07 20:15:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul1Ca-0000El-4k
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 20:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756943Ab3FGSP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 14:15:28 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:59808 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756892Ab3FGSPY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 14:15:24 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so11252327iec.19
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 11:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3GTyYHgbpaulPyo2dGJVseUocrCOpVk7Dn23wiQKBaM=;
        b=PtEpyUm5VOLaig/PPc+irQeHAPRZ1UqwRi7v41OSvDJ6JcepqDo23jz4/paUNbDjZ1
         mvLtBeEo29EHyMfpdtZ/R9Nwn0t5zw9j8tqA0PycU7tmusw3807hWFSOh6Acoowc3lmJ
         yXNwU55C2zqAmlVYDQM1mG4NrPrL1qw3BKnMNdIf7MgRsDCvV+MxmH+kRQsuE6gr/+Pd
         JiJHi/8UCTiCgcPK9ZT9UD5htTADjkV9s5Ew8APor4ARALSJqmAtuOxhmVFbEL1TXqIr
         Qs4XmyGXK7Ftbaq3Qzx4O5GBI9828fXA+jwggBBlonu8WmcJ2a+RLYpxdaTeDDRSgkT1
         r2Jg==
X-Received: by 10.50.107.6 with SMTP id gy6mr1978148igb.57.1370628923886; Fri,
 07 Jun 2013 11:15:23 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 11:14:43 -0700 (PDT)
In-Reply-To: <vpqhah9248u.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226658>

Matthieu Moy wrote:
> Reading Git for Windows's FAQ
> ( https://github.com/msysgit/msysgit/wiki/Frequently-Asked-Questions ),
> it seems rather clear that the TODO-list is already long to have a
> correct Perl support (I'm quite admirative of the work done already).
> The POSIX guys shouldn't move faster than the Windows guys can follow.

Ha!  So, it's subversion and perlxs.  I was wondering what was so
non-trivial about shipping a perl interpreter with Windows when dscho
mentioned it.

Hopefully, I've done a little bit to improve the situation by pushing
svnrdump into core (I don't know if it has any users).  On the git
side, git-remote-testsvn is still a toy (which is a product of many
months of work by db + 2x SoCs) compared to git-svn.perl.  Yeah,
supporting subversion is extraordinarily painful.

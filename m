X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Minor documentation problems
Date: Thu, 02 Nov 2006 14:20:44 +0100
Message-ID: <vpq4ptinfwz.fsf@ecrins.imag.fr>
References: <vpqmz7a1694.fsf@ecrins.imag.fr>
	<20061102114149.GL20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 13:22:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Thu, 02 Nov 2006 14:20:47 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30746>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfcWG-0000bu-Bj for gcvg-git@gmane.org; Thu, 02 Nov
 2006 14:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752855AbWKBNVm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 08:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752848AbWKBNVm
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 08:21:42 -0500
Received: from imag.imag.fr ([129.88.30.1]:63716 "EHLO imag.imag.fr") by
 vger.kernel.org with ESMTP id S1752855AbWKBNVl (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 08:21:41 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52]) by
 imag.imag.fr (8.13.6/8.13.6) with ESMTP id kA2DKjdt020392
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO) for
 <git@vger.kernel.org>; Thu, 2 Nov 2006 14:20:47 +0100 (CET)
Received: from ecrins.imag.fr ([129.88.43.124]) by mail-veri.imag.fr with
 esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GfcUv-0001jb-13 for
 git@vger.kernel.org; Thu, 02 Nov 2006 14:20:45 +0100
Received: from moy by ecrins.imag.fr with local (Exim 4.50) id
 1GfcUu-00054O-UV for git@vger.kernel.org; Thu, 02 Nov 2006 14:20:44 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

>   Moreover, I'm more and more thinking about removing the fallback on
> guessing based on /etc/passwd and hostname. _Many_ people were and will
> be burnt by it, and I think it's more sane to require the user to
> confirm once what the valid credentials are (at _that_ point it's ok to
> guess, but the user has to confirm it) than let them unconsciously do
> 200 commits with completely bogus author lines.

IIRC, Darcs will prompt interactively the first time and remember it.
The problem of interactive prompt is that it can break scripts (which
are not always ran from an interactive prompt), so it's probably OK to
do this in cogito, but less so in git.

One nice thing with guess-and-don't-ask is that people who don't care
don't have to bother about this. I mean, some people have been
satisfied with CVS storing the username of the guy doing the access
which is often wrong for years, so ... it's probably OK to use an
incorrect guess for a private project with, say, <5 contributors.

-- 

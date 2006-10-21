From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Sat, 21 Oct 2006 09:56:27 +0200
Message-ID: <vpqk62uhzkk.fsf@ecrins.imag.fr>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610172351.17377.jnareb@gmail.com> <4535590C.4000004@utoronto.ca>
	<200610180057.25411.jnareb@gmail.com>
	<Pine.LNX.4.64.0610171610270.3962@g5.osdl.org>
	<20061018053647.GA3507@coredump.intra.peff.net>
	<Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
	<20061018185225.GU20017@pasky.or.cz> <eh76np$trg$1@sea.gmane.org>
	<BAYC1-PASMTP061F10D0B5AF9F6608134CAE0C0@CEZ.ICE>
	<4538D724.5040508@utoronto.ca> <ehao3e$2qv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 09:57:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbBjc-00076s-Hg
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 09:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992829AbWJUH5V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 03:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992865AbWJUH5V
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 03:57:21 -0400
Received: from imag.imag.fr ([129.88.30.1]:49652 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S2992829AbWJUH5V (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 03:57:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9L7uSEO019000
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 21 Oct 2006 09:56:28 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GbBiW-0005uA-2t; Sat, 21 Oct 2006 09:56:28 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1GbBiV-0005wR-Vw; Sat, 21 Oct 2006 09:56:28 +0200
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ehao3e$2qv$1@sea.gmane.org> (Jakub Narebski's message of "Fri\, 20 Oct 2006 16\:56\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Sat, 21 Oct 2006 09:56:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29589>

Jakub Narebski <jnareb@gmail.com> writes:

>> It's my understanding that most changes discussed on lkml are provided
>> as a series of patches.  Bazaar bundles are intended as a direct
>> replacement for patches in that use case.
>
> As _series_ of patches. You have git-format-patch + git-send-email
> to format and send them, git-am to apply them (as patches, not as branch).
>
> I was under an impression that user sees only mega-patch of all the
> revisions in bundle together, and rest is for machine consumption only.

Nothing prevents you from using series of bundles.

A bundle for a single revision looks like a patch with a few comments
on top and bottom. _If_ you have several revisions in your patch, you
get the diff as human readable, and the intermediate revisions as
MIME-encoded.

For big changes, people do send several bundles.

So, a bundle is a direct replacement for a patch, not for series of
patches.

-- 
Matthieu

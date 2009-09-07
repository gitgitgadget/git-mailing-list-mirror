From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Mon, 07 Sep 2009 08:23:19 +0200
Message-ID: <vpqpra3p92g.fsf@bauges.imag.fr>
References: <20090902080305.GA11549@neumann>
	<20090902081917.GA5447@coredump.intra.peff.net>
	<20090904070216.GA3996@darc.dnsalias.org>
	<20090905061804.GB29863@coredump.intra.peff.net>
	<7v8wgt98ms.fsf@alter.siamese.dyndns.org>
	<20090905084641.GA24865@darc.dnsalias.org>
	<vpqfxb0s177.fsf@bauges.imag.fr> <20090906181621.GA23412@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Sep 07 08:30:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkXk5-00014Q-TJ
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 08:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759009AbZIGGaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 02:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758950AbZIGGaI
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 02:30:08 -0400
Received: from imag.imag.fr ([129.88.30.1]:53116 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753278AbZIGGaH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 02:30:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n876NKt1021813
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 7 Sep 2009 08:23:20 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MkXdI-0004mk-0c; Mon, 07 Sep 2009 08:23:20 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MkXdH-0007MW-VX; Mon, 07 Sep 2009 08:23:19 +0200
In-Reply-To: <20090906181621.GA23412@localhost> (Clemens Buchacher's message of "Sun\, 6 Sep 2009 20\:16\:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 07 Sep 2009 08:23:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127888>

Clemens Buchacher <drizzd@aon.at> writes:

> On Sun, Sep 06, 2009 at 02:32:44PM +0200, Matthieu Moy wrote:
>> I think it has already been proposed to introduce "git add -a" doing
>> what "git add -u" do, but for the full tree.
>
> I like that, actually. AFAICT it's completely analogous to "git commit -a".
> We also need something for "git add -A" though.
>
> Do you feel the same way about changing the behavior of "git grep"? I don't
> really want to change the command's name.

I don't have particular feeling about "git grep", probably because I
don't use it much. One argument in favour of keeping the current
behavior is the consistancy with plain "grep".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git fsck not identifying corrupted packs
Date: Tue, 20 Oct 2009 08:26:25 +0200
Message-ID: <vpqy6n6shri.fsf@bauges.imag.fr>
References: <loom.20091019T094924-194@post.gmane.org>
	<4ADC2D45.3020803@viscovery.net>
	<alpine.DEB.1.00.0910191202020.4985@pacific.mpi-cbg.de>
	<7v7hur1a0h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 08:29:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N08EC-0008Oa-6x
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 08:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbZJTG3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 02:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752345AbZJTG3m
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 02:29:42 -0400
Received: from imag.imag.fr ([129.88.30.1]:63074 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269AbZJTG3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 02:29:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n9K6QQBX029343
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 20 Oct 2009 08:26:26 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1N08As-00023e-0Y; Tue, 20 Oct 2009 08:26:26 +0200
In-Reply-To: <7v7hur1a0h.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 19 Oct 2009 12\:03\:42 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 20 Oct 2009 08:26:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130761>

Junio C Hamano <gitster@pobox.com> writes:

> Linus and other git developers from the early days [...]

Thanks for the historical background.

> It probably makes sense to ship 1.7.0 with a version of "fsck" in which
> "--full" is the default; it would still accept "--full" but it would be a
> no-op.

+1

> It probably is also a good idea to add a "--loose" option that does what
> "fsck" currently does without "--full".  It is a good name

+1 too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

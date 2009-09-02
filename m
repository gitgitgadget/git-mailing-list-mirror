From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: stash --dwim safety
Date: Wed, 02 Sep 2009 08:26:45 +0200
Message-ID: <vpqvdk1vp3u.fsf@bauges.imag.fr>
References: <7viqg48nxi.fsf@alter.siamese.dyndns.org>
	<7v3a77dx5b.fsf@alter.siamese.dyndns.org>
	<vpqocpv2n93.fsf@bauges.imag.fr>
	<20090901065716.GA5575@sigill.intra.peff.net>
	<7vy6oyj892.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 08:35:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MijRR-0001sU-Pj
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 08:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbZIBGfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 02:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755894AbZIBGfW
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 02:35:22 -0400
Received: from imag.imag.fr ([129.88.30.1]:33064 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755893AbZIBGfV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 02:35:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n826Qj96021520
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 2 Sep 2009 08:26:46 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MijIr-0003nh-IN; Wed, 02 Sep 2009 08:26:45 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MijIr-0000bR-FR; Wed, 02 Sep 2009 08:26:45 +0200
In-Reply-To: <7vy6oyj892.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 01 Sep 2009 21\:11\:37 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 02 Sep 2009 08:26:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127586>

Thanks for taking care of this,

Junio C Hamano <gitster@pobox.com> writes:

>  'git stash' [save [--patch] [-k|--[no-]keep-index] [-q|--quiet] [<message>]]

To be precise, you can change this to

>  'git stash' [save [--patch] [-k|--[no-]keep-index] [-q|--quiet] [--] [<message>]]

(added [--])

-- 
Matthieu

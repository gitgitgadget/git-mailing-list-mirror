From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: GIT over ssh with identity file
Date: Wed, 04 Feb 2009 09:50:47 +0100
Message-ID: <vpqhc3aa8m0.fsf@bauges.imag.fr>
References: <21826348.post@talk.nabble.com>
	<7vbpti1tnd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: oliverw <oliver@weichhold.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 09:58:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUdaF-00068r-Td
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 09:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbZBDI4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 03:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbZBDI4p
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 03:56:45 -0500
Received: from imag.imag.fr ([129.88.30.1]:33442 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845AbZBDI4o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 03:56:44 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n148ol4u002197
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Feb 2009 09:50:47 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LUdT5-0004gA-7a; Wed, 04 Feb 2009 09:50:47 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LUdT5-0007B5-5J; Wed, 04 Feb 2009 09:50:47 +0100
In-Reply-To: <7vbpti1tnd.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 04 Feb 2009 00\:41\:10 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 04 Feb 2009 09:50:48 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108317>

Junio C Hamano <gitster@pobox.com> writes:

>     $ cat >>$HOME/.ssh/config <<\EOF
>     Host homer-at-foo
>       Hostname foo.bar.com
>       User homer
>       IdentityFile ~/.ssh/homer-at-foo.pub

(I think you have an extra .pub here, the identity file should be the
private key).

-- 
Matthieu

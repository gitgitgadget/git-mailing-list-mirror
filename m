From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git with custom diff for commits
Date: Wed, 19 Dec 2007 13:13:08 +0100
Message-ID: <vpq1w9iopbf.fsf@bauges.imag.fr>
References: <60687a7d0712171456p14328817y5aa229f0df23c02f@mail.gmail.com>
	<Pine.LNX.4.64.0712172300510.9446@racer.site>
	<vpq1w9kaphg.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0712172310090.9446@racer.site>
	<7vbq8o6gxw.fsf@gitster.siamese.dyndns.org>
	<vpqk5ncz8fn.fsf@bauges.imag.fr>
	<7vodco1him.fsf@gitster.siamese.dyndns.org>
	<000001c841b5$89fcef00$762a14ac@na.acco.com>
	<7vzlw7ybx7.fsf@gitster.siamese.dyndns.org>
	<000101c841b7$5f1d1060$762a14ac@na.acco.com>
	<vpqsl1zfz8r.fsf@bauges.imag.fr>
	<000d01c841c5$386f7350$762a14ac@na.acco.com>
	<Pine.LNX.4.64.0712182246230.23902@racer.site>
	<vpqtzmfvz1d.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0712191209140.23902@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerald Gutierrez <ggmlfs@gmail.com>,
	"'Junio C Hamano'" <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 19 13:20:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4xuB-0007gG-8N
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 13:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbXLSMTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 07:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753025AbXLSMTo
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 07:19:44 -0500
Received: from imag.imag.fr ([129.88.30.1]:55332 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777AbXLSMTn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 07:19:43 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lBJCD91v008427
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 19 Dec 2007 13:13:09 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1J4xnQ-0000wq-7b; Wed, 19 Dec 2007 13:13:08 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1J4xnQ-0000yt-54; Wed, 19 Dec 2007 13:13:08 +0100
In-Reply-To: <Pine.LNX.4.64.0712191209140.23902@racer.site> (Johannes Schindelin's message of "Wed\, 19 Dec 2007 12\:09\:41 +0000 \(GMT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 19 Dec 2007 13:13:12 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68901>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 19 Dec 2007, Matthieu Moy wrote:
>
>> That said, I think the wording of the man page could be better.
>> Perhaps "Record new snapshot to the repository" or "Record current
>> state of the working tree to the repository".
>
> How about "record a new revision"?

Sounds good, yes.

-- 
Matthieu

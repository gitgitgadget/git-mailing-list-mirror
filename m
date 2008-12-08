From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Can Git push only first parent history commits?
Date: Mon, 08 Dec 2008 08:44:02 +0100
Message-ID: <vpqabb7az7h.fsf@bauges.imag.fr>
References: <402F4B33D9C9DE4083DB96B416549FAF9E12@zch01exm23.fsl.freescale.net>
	<7v7i6bbcc6.fsf@gitster.siamese.dyndns.org>
	<402F4B33D9C9DE4083DB96B416549FAF9E2D@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
To: "Li Frank" <Frank.Li@freescale.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 08:56:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9ayl-0002TW-5F
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 08:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbYLHHzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 02:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbYLHHzO
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 02:55:14 -0500
Received: from imag.imag.fr ([129.88.30.1]:47183 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211AbYLHHzM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 02:55:12 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id mB87i2JP014469
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 8 Dec 2008 08:44:03 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1L9amg-00017i-DV; Mon, 08 Dec 2008 08:44:02 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1L9amg-0004m4-AO; Mon, 08 Dec 2008 08:44:02 +0100
In-Reply-To: <402F4B33D9C9DE4083DB96B416549FAF9E2D@zch01exm23.fsl.freescale.net> (Li Frank's message of "Mon\, 8 Dec 2008 11\:11\:30 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 08 Dec 2008 08:44:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102534>

"Li Frank" <Frank.Li@freescale.com> writes:

> I don't know the detail of git internal.  Or my email subject
> description have some problem. 
>  
> I just want to combine some commits to one commit and push combined
> commit to remote.  And at same time, keep commits history at my local
> repository.  Rebase will make original history lost. 

git merge --squash may help.

-- 
Matthieu

From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Document "commit --only".
Date: Mon, 07 May 2007 10:16:09 +0200
Message-ID: <vpq8xc1ujzq.fsf@bauges.imag.fr>
References: <11784859173386-git-send-email-Matthieu.Moy@imag.fr>
	<11784859173725-git-send-email-Matthieu.Moy@imag.fr>
	<11784859182473-git-send-email-Matthieu.Moy@imag.fr>
	<11784859184184-git-send-email-Matthieu.Moy@imag.fr>
	<alpine.LFD.0.99.0705061908430.24220@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 10:16:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkyOT-0001pA-Ke
	for gcvg-git@gmane.org; Mon, 07 May 2007 10:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130AbXEGIQ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 04:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754136AbXEGIQ0
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 04:16:26 -0400
Received: from imag.imag.fr ([129.88.30.1]:57779 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754130AbXEGIQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 04:16:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l478G95I014547
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 7 May 2007 10:16:09 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HkyO9-0005dL-3R; Mon, 07 May 2007 10:16:09 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HkyO9-0003oz-1D; Mon, 07 May 2007 10:16:09 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <alpine.LFD.0.99.0705061908430.24220@xanadu.home> (Nicolas Pitre's message of "Sun\, 06 May 2007 19\:13\:41 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 07 May 2007 10:16:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46430>

Nicolas Pitre <nico@cam.org> writes:

> This looks really confusing.  This is the default _only_ if files are 
> specified on the command line.
>
> IMHO I'd rather remove the option from the synopsis and flag it as 
> scheduled for removal in the source instead.

I'm fine with this proposal. Next email will be a patch to do that
(I'm not sure about the standard way to deprecate things in git, so I
just added a warning when -o is used, feel free to improve it).

-- 
Matthieu

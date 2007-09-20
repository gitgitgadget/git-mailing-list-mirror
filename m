From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 2/2] add support for branch.<name>.integrationonly
Date: Thu, 20 Sep 2007 15:36:12 +0200
Message-ID: <vpq1wctsblf.fsf@bauges.imag.fr>
References: <1190292789-16203-1-git-send-email-hjemli@gmail.com>
	<1190292789-16203-2-git-send-email-hjemli@gmail.com>
	<1190292789-16203-3-git-send-email-hjemli@gmail.com>
	<Pine.LNX.4.64.0709201413440.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 20 15:37:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYMDX-0002W8-1s
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 15:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbXITNhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 09:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752826AbXITNhL
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 09:37:11 -0400
Received: from imag.imag.fr ([129.88.30.1]:58015 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839AbXITNhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 09:37:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l8KDaD0w028297
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 20 Sep 2007 15:36:13 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IYMCS-0002nk-BP; Thu, 20 Sep 2007 15:36:12 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IYMCS-0004zH-93; Thu, 20 Sep 2007 15:36:12 +0200
In-Reply-To: <Pine.LNX.4.64.0709201413440.28395@racer.site> (Johannes Schindelin's message of "Thu\, 20 Sep 2007 14\:14\:18 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 20 Sep 2007 15:36:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58779>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 20 Sep 2007, Lars Hjemli wrote:
>
>> +branch.<name>.integrationonly::
>
> Why not have something like branch.<name>.mergeOptions instead?

Why make it plural? I agree that it's better to have a multiple values
option than having just "true/false", which makes it more extensible,
but I don't understand the kind of things you could put here that
wouldn't be better located in a separate configuration option.

-- 
Matthieu

From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC] Default options
Date: Thu, 10 May 2007 01:14:32 +0200
Message-ID: <vpqvef1si7b.fsf@bauges.imag.fr>
References: <56b7f5510705091515l7c7090b9rd5599e8746642ef9@mail.gmail.com>
	<Pine.LNX.4.64.0705100106250.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 01:14:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlvMq-0002ly-HZ
	for gcvg-git@gmane.org; Thu, 10 May 2007 01:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973AbXEIXOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 19:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754798AbXEIXOi
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 19:14:38 -0400
Received: from imag.imag.fr ([129.88.30.1]:39443 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755300AbXEIXOh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 19:14:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l49NEWE4021804
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 10 May 2007 01:14:32 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HlvMe-0008TC-Cq; Thu, 10 May 2007 01:14:32 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1HlvMe-0003cE-AV; Thu, 10 May 2007 01:14:32 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0705100106250.4167@racer.site> (Johannes Schindelin's message of "Thu\, 10 May 2007 01\:07\:13 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 10 May 2007 01:14:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46810>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 9 May 2007, Dana How wrote:
>
>> I notice git supports "alias.*" config variables.
>> Would it be useful to also support "options.*" variables?
>
> I would not do it, for the same reason we do not allow to override 
> builtins via aliases: it breaks scripts.

In any case, I find it a bit redundant with the alias section.

If I want to be able to quickly type "git-cmd --some --option", I'll
just alias it to something shorter.

-- 
Matthieu

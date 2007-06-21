From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Basename matching during rename/copy detection
Date: Thu, 21 Jun 2007 14:53:32 +0200
Message-ID: <vpqodj9zcxf.fsf@bauges.imag.fr>
References: <20070621030622.GD8477@spearce.org>
	<200706211050.03519.andyparkins@gmail.com>
	<Pine.LNX.4.64.0706211252190.4059@racer.site>
	<200706211344.47560.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 14:55:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1MBm-0005Hd-Rl
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 14:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbXFUMyp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 08:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754805AbXFUMyp
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 08:54:45 -0400
Received: from imag.imag.fr ([129.88.30.1]:57719 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969AbXFUMyo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 08:54:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l5LCrWUZ016497
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 21 Jun 2007 14:53:33 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1I1MAG-0006NK-QQ; Thu, 21 Jun 2007 14:53:32 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1I1MAG-0000KL-Nx; Thu, 21 Jun 2007 14:53:32 +0200
Mail-Followup-To: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>
In-Reply-To: <200706211344.47560.andyparkins@gmail.com> (Andy Parkins's message of "Thu\, 21 Jun 2007 13\:44\:46 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 21 Jun 2007 14:53:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50619>

Andy Parkins <andyparkins@gmail.com> writes:

> On Thursday 2007 June 21, Johannes Schindelin wrote:
>
>> > would let people keep their copies.  What I was objecting to was the
>> > idea that any repository with duplicate files was "stupid".
>>
>> FWIW I find it stupid, too.
>
> Thanks very much.  Okay, as I've been put in the position of defending this, 
> let me give you the use case that has cropped up for me to do this stupid 
> thing.

Well, why look so far to find an example of people having identical
files in their tree?

$ cd git
$ git-ls-files -z | xargs -0 md5sum | cut -f 1 -d ' ' | wc -l              
973
$ git-ls-files -z | xargs -0 md5sum | cut -f 1 -d ' ' | sort | uniq | wc -l
964
$ 

-- 
Matthieu

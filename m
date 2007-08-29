From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Git cheat sheet
Date: Wed, 29 Aug 2007 18:14:55 +0200
Message-ID: <vpq3ay2jp1c.fsf@bauges.imag.fr>
References: <200708290348.02853.zack@kde.org>
	<7vfy22squc.fsf@gitster.siamese.dyndns.org>
	<200708290855.39505.zack@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Zack Rusin <zack@kde.org>
X-From: git-owner@vger.kernel.org Wed Aug 29 18:21:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQQI4-0001xX-8B
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 18:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbXH2QVH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 12:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752685AbXH2QVG
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 12:21:06 -0400
Received: from imag.imag.fr ([129.88.30.1]:53121 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753385AbXH2QVF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 12:21:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7TGEwF4011064
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 29 Aug 2007 18:14:58 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IQQBz-0003C9-Rv; Wed, 29 Aug 2007 18:14:55 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IQQBz-0008BC-PT; Wed, 29 Aug 2007 18:14:55 +0200
In-Reply-To: <200708290855.39505.zack@kde.org> (Zack Rusin's message of "Wed\, 29 Aug 2007 08\:55\:39 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 29 Aug 2007 18:14:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56964>

Zack Rusin <zack@kde.org> writes:

>> + A new section "Making Progress" and include commit, merge and
>>   rebase there, perhaps?
>
> Yeah, lack of rebase in the sheet bothers me a bit, since it's quite 
> important. Maybe I could remove the "useful commands" section and put 
> something in there...

But be carefull with rebase: it's easy to shoot yourself in the foot
with it (try rebasing a branch you've already published, and which
people already branched from if you want to see ;-) ). Putting it on a
"cheat sheet" increase the risk of seeing people using it without
knowing about the risk.

> I'm not sure if I should put the sheet in some more visible place, so for now 
> the updated svg and png's are at:

Just linking to them from the git wiki would be nice already.

-- 
Matthieu

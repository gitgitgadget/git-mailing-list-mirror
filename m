From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: .gitlink for Summer of Code
Date: Tue, 27 Mar 2007 18:59:48 +0200
Message-ID: <vpqzm5ysjuj.fsf@olympe.imag.fr>
References: <1174825838.12540.5.camel@localhost>
	<200703262133.44520.Josef.Weidendorfer@gmx.de>
	<vpqodmfss39.fsf@olympe.imag.fr>
	<200703270114.49365.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 19:00:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWF20-0003v5-3C
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 19:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933166AbXC0RAH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 13:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933306AbXC0RAH
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 13:00:07 -0400
Received: from imag.imag.fr ([129.88.30.1]:46584 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933166AbXC0RAE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 13:00:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l2RGxmfA025598
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 27 Mar 2007 18:59:48 +0200 (CEST)
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HWF1Q-0001jN-NR
	for git@vger.kernel.org; Tue, 27 Mar 2007 18:59:48 +0200
Received: from moy by olympe.imag.fr with local (Exim 4.50)
	id 1HWF1Q-0005P3-L1
	for git@vger.kernel.org; Tue, 27 Mar 2007 18:59:48 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <200703270114.49365.Josef.Weidendorfer@gmx.de> (Josef Weidendorfer's message of "Tue\, 27 Mar 2007 01\:14\:49 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 27 Mar 2007 18:59:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43284>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

>> * You have to manage a name for each lightweight checkout. What would
>>   be such name? User-provided? uuidgen-like?
>
> Such a name is interesting as identifier for submodules.
> It would be the relative path of the submodule from the supermodule base;
> or user supplied.
>
> Lightweight checkouts and submodules have different requirements;
> yet, the lightweight checkouts should be so flexible to be
> able to be used for submodules checkouts.

Sure, but AAUI, submodules would use light checkouts, but light
checkouts are interesting by themselves, so the naming thing should be
in submodules support.

-- 
Matthieu

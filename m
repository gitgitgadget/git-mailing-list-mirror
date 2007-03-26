From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: .gitlink for Summer of Code
Date: Mon, 26 Mar 2007 20:21:18 +0200
Message-ID: <vpq3b3ruaqp.fsf@olympe.imag.fr>
References: <1174825838.12540.5.camel@localhost>
	<vpqvegpe4e1.fsf@olympe.imag.fr> <eu8vrb$r15$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 20:21:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVtow-0004U0-VN
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 20:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662AbXCZSV2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 14:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753664AbXCZSV1
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 14:21:27 -0400
Received: from imag.imag.fr ([129.88.30.1]:60364 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753661AbXCZSV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 14:21:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l2QILIu8016857
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 26 Mar 2007 20:21:19 +0200 (CEST)
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HVtok-0006hv-P3; Mon, 26 Mar 2007 20:21:18 +0200
Received: from moy by olympe.imag.fr with local (Exim 4.50)
	id 1HVtok-00012t-Mi; Mon, 26 Mar 2007 20:21:18 +0200
Mail-Followup-To: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eu8vrb$r15$1@sea.gmane.org> (Jakub Narebski's message of "Mon\, 26 Mar 2007 19\:31\:18 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 26 Mar 2007 20:21:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43171>

Jakub Narebski <jnareb@gmail.com> writes:

> Matthieu Moy wrote:
>
>> Stupid question: why .gitlink, and not .git/link or so? This file is
>> not versionned, I don't think it should be in the working tree.
>
> It would be special-cased, as is .git directory not versioned, the
> same way .gitlink would be not versioned (not like .gitignore).

That's how I understand it, but why 2 special cases (.git and
.gitlink) when you need one?

-- 
Matthieu

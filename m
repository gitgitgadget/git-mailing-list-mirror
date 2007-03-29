From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: basics... when reading docs doesn't help
Date: Fri, 30 Mar 2007 00:27:46 +0200
Message-ID: <vpq648jit25.fsf@olympe.imag.fr>
References: <Pine.LNX.4.60.0703292225100.10351@poirot.grange>
	<20070329211616.GH6143@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 00:27:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX365-0007GZ-U9
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 00:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbXC2W1y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 18:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422662AbXC2W1y
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 18:27:54 -0400
Received: from imag.imag.fr ([129.88.30.1]:43855 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422651AbXC2W1x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 18:27:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l2TMRkZJ008218
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 30 Mar 2007 00:27:46 +0200 (CEST)
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HX35u-0004YL-61; Fri, 30 Mar 2007 00:27:46 +0200
Received: from moy by olympe.imag.fr with local (Exim 4.50)
	id 1HX35u-0005O1-3X; Fri, 30 Mar 2007 00:27:46 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <20070329211616.GH6143@fieldses.org> (J. Bruce Fields's message of "Thu\, 29 Mar 2007 17\:16\:16 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 30 Mar 2007 00:27:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43484>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> If you really need a ton of build trees then you might just want to do
> cp -al or something.

But be careful that this is a potentially dangerous optimization : if
you ever use a command that doesn't break hardlinks (for example
"echo foo >> file"), the modification is applied to both trees.

-- 
Matthieu

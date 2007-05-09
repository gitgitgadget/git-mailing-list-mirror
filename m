From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] git-commit: Reformat log messages provided on commandline
Date: Wed, 09 May 2007 17:32:14 +0200
Message-ID: <vpqfy66gght.fsf@bauges.imag.fr>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0705061851411.4015@racer.site>
	<vpqk5vlamav.fsf@bauges.imag.fr>
	<7vvef5c0fw.fsf@assigned-by-dhcp.cox.net>
	<20070509125225.GP4489@pasky.or.cz>
	<Pine.LNX.4.64.0705091513360.4167@racer.site>
	<20070509142426.GV4489@pasky.or.cz> <vpqps5ajb60.fsf@bauges.imag.fr>
	<20070509151148.GW4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 17:32:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlo9S-0004Ku-2i
	for gcvg-git@gmane.org; Wed, 09 May 2007 17:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614AbXEIPcW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 11:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754876AbXEIPcW
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 11:32:22 -0400
Received: from imag.imag.fr ([129.88.30.1]:59385 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754614AbXEIPcV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 11:32:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l49FWFYN022191
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 9 May 2007 17:32:15 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Hlo9G-0002og-Tp; Wed, 09 May 2007 17:32:14 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Hlo9G-0001xg-RX; Wed, 09 May 2007 17:32:14 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <20070509151148.GW4489@pasky.or.cz> (Petr Baudis's message of "Wed\, 9 May 2007 17\:11\:48 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 09 May 2007 17:32:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46730>

Petr Baudis <pasky@suse.cz> writes:

> Hmm, I don't really know if it's more evil to split an extra-long line
> to two or keep it longer than the maximum sane width.

The evil already happened several times in git's repository ;-).

$ git log --all --pretty=oneline | grep \
 ' ................................................................................' \
 | wc -l
81
$

When I encounter such long line, I often just don't care, since my
terminal or tool (gitk ...) is often more than 80 char. And in the
cases I care, the fix is just to enlarge the window or to scroll (only
people using a text-mode console would _really_ be disturbed).

With the other solution (breaking the line automatically), I have no
easy fix. In gitk, I have the beginning of a sentence in the summary
field, in a mailed patched, I have the sentence split between the
Subject: header and the body.

(but we agree that both cases are evil. Perhaps just "ERROR: you're
doing evil" would be better ...)

-- 
Matthieu

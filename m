From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH v3 1/2] git-am: emit usage when called w/o arguments and w/o patch on stdin
Date: Wed, 28 Jan 2009 16:18:30 +0000
Message-ID: <780A42F8-E27C-404A-945C-38C16378EF57@ai.rug.nl>
References: <1233154990-19745-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, sverre@rabbelier.nl
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 17:20:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSD99-0008Eq-Mc
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 17:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbZA1QSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 11:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbZA1QSr
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 11:18:47 -0500
Received: from frim.nl ([87.230.85.232]:43501 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751637AbZA1QSr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jan 2009 11:18:47 -0500
Received: from cnat218.wlan.net.ed.ac.uk ([129.215.5.218] helo=[172.20.196.1])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1LSD7d-0002br-9V; Wed, 28 Jan 2009 17:18:37 +0100
In-Reply-To: <1233154990-19745-1-git-send-email-jaysoffian@gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107546>


On Jan 28, 2009, at 3:03 PM, Jay Soffian wrote:

> When git am is called w/o arguments, w/o a patch on stdin and the  
> user hits
> ctrl-c, it leaves behind a partially populated $dotest directory.  
> After this
> commit, it emits usage when called w/o arguments and w/o a patch on  
> stdin.

FWIW, I sometimes like to run 'git am', paste in a patch and hit ctrl-d.

I can probably retrain my finger to use 'git am -', but I'm not sure  
if that
works (after this patch)? At least it's not mentioned in the manpage.

- Pieter

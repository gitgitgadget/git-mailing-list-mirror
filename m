From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: git checkout and pwd?
Date: Wed, 8 Apr 2009 20:38:15 +0200
Message-ID: <200904082038.16133.markus.heidelberg@web.de>
References: <450196A1AAAE4B42A00A8B27A59278E70A99A3D6@EXCHANGE.trad.tradestation.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "John Dlugosz" <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 20:39:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrcgR-0001WW-5P
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 20:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757535AbZDHSh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 14:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755940AbZDHSh4
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 14:37:56 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:54890 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755609AbZDHShz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2009 14:37:55 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id CA87EFA27BDF;
	Wed,  8 Apr 2009 20:37:53 +0200 (CEST)
Received: from [89.59.73.185] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lrcen-0004pQ-00; Wed, 08 Apr 2009 20:37:53 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A99A3D6@EXCHANGE.trad.tradestation.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18IePSNJlYpOD6sVVoTNgKxPUIBHkCegkHin8H2
	KgABs5lCcE5MYXCF0wYUrio33B94bV7kXF7Tt5RAr1zq932BJd
	SqD36ZKPea1f+T0dF3eQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116107>

John Dlugosz, 08.04.2009:
> On a Windows system running msysgit, I entered the command:
> 
> 	git checkout -b -l jmd/mt_queue
> 
> and got a reply of: 
> fatal: git checkout: updating paths is incompatible with switching
> branches.
> Did you intend to checkout 'compile.vc8/Win32/release/jmd/mt_queue'
> which can not be resolved as commit?

>From the documentation: [-b <new_branch> [-l]]
The new branch has to follow the -b option immediately.

> Is there something about this form of checkout that requires that it be
> issued while in the "top level" directory of the project (i.e. the one
> containing the .git subdirectory)?

No, that doesn't matter.

Markus

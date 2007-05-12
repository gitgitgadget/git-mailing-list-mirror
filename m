From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: Re: how to set up e-mail notification?
Date: Sat, 12 May 2007 21:11:43 +0100
Message-ID: <20070512201143.GJ3491@cs-wsok.swansea.ac.uk>
References: <20070511195539.GF3491@cs-wsok.swansea.ac.uk> <Pine.LNX.4.64.0705120232320.30969@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat May 12 22:04:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmxoy-0000t1-2x
	for gcvg-git@gmane.org; Sat, 12 May 2007 22:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859AbXELUD7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 16:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756847AbXELUD7
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 16:03:59 -0400
Received: from mhs.swan.ac.uk ([137.44.1.33]:56414 "EHLO mhs.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755859AbXELUD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 16:03:58 -0400
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by mhs.swan.ac.uk with esmtp (Exim 4.66)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1Hmxor-00079b-GW; Sat, 12 May 2007 21:03:57 +0100
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id 278F23F0F7;
	Sat, 12 May 2007 21:03:57 +0100 (BST)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id D380E74191; Sat, 12 May 2007 21:11:43 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705120232320.30969@beast.quantumfyre.co.uk>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47087>

> 
> There's one in the standard git source tree: 
> contrib/hooks/post-receive-email
> 
> never used it myself ...
> 

Thanks! That script looks quite complicated, so as a quick
solution I just added to hooks/post-receive the line

mutt -s "Git push Repository-Name -- $USER" e-mail-addresses

so that at least the users see that something happened, and
I'll investigate contrib/hooks/post-receive-email.

Oliver

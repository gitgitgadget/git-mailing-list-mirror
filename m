From: Marcel Koeppen <git-dev@marzelpan.de>
Subject: Re: [PATCH] Fix sed syntax in t7502-commit for OSX
Date: Thu, 15 May 2008 13:06:07 +0200
Message-ID: <22590A7D-0409-4940-BC2E-776B2189BFEC@marzelpan.de>
References: <1210817948-72280-1-git-send-email-git-dev@marzelpan.de> <7vwslwgdyi.fsf@gitster.siamese.dyndns.org> <200805151058.34774.hs4233@mail.mn-solutions.de>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, sbejar@gmail.com,
	Holger Schurig <hs4233@mail.mn-solutions.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 13:30:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwbfM-0004ur-QR
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 13:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753933AbYEOL3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 07:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754070AbYEOL3m
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 07:29:42 -0400
Received: from smtprelay08.ispgateway.de ([80.67.29.8]:43518 "EHLO
	smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981AbYEOL3m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 07:29:42 -0400
X-Greylist: delayed 1409 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 May 2008 07:29:42 EDT
Received: from [85.22.31.24] (helo=[139.26.58.81])
	by smtprelay08.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <git-dev@marzelpan.de>)
	id 1JwbHm-0001K1-1p; Thu, 15 May 2008 13:06:10 +0200
In-Reply-To: <200805151058.34774.hs4233@mail.mn-solutions.de>
X-Mailer: Apple Mail (2.919.2)
X-Df-Sender: 012269
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82201>


Am 15.05.2008 um 10:58 schrieb Holger Schurig:

>>> -sed -i '$d' expect
>>> +sed -i -e '$d' expect
>
> perl -pi -e 's/foo/bar/' ???

This does not work with '$d', so we could use sed with a temp instead  
of the -i extension. Alternatively we could specify the full test  
fixture instead of editing an old one. This would make the expected  
results more obvious and the tests would work without assumptions  
about running order.

Marcel

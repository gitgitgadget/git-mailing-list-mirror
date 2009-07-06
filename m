From: Marcus Camen <mcamen@mcamen.de>
Subject: Re: What's cooking in git.git (Jul 2009, #01; Mon, 06)
Date: Tue, 7 Jul 2009 00:03:25 +0200
Message-ID: <200907070003.25788.mcamen@mcamen.de>
References: <7vk52l4q7k.fsf@alter.siamese.dyndns.org> <200907062229.11763.mcamen@mcamen.de> <7vk52l1oht.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 00:11:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNwPF-0001lP-UY
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 00:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474AbZGFWLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 18:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753332AbZGFWLK
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 18:11:10 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:46466 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbZGFWLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 18:11:09 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jul 2009 18:11:09 EDT
Received: from [91.46.225.237] (helo=home.localnet)
	by smtprelay01.ispgateway.de with esmtp (Exim 4.68)
	(envelope-from <mcamen@mcamen.de>)
	id 1MNwHW-000679-75; Tue, 07 Jul 2009 00:03:26 +0200
User-Agent: KMail/1.12.90 (Linux/2.6.27.23-0.1-default; KDE/4.3.60; x86_64; svn-991738; 2009-07-05)
In-Reply-To: <7vk52l1oht.fsf@alter.siamese.dyndns.org>
X-Df-Sender: [pbs]924509
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122803>

>  - On a protected key/cert, with configuration, it asks the question
> once.
>  - On an unprotected key/cert, without configuration, it never asks the
>    question.
>  - On an unprotected key/cert, with configuration, it asks an useless
>    question but it does so only once.
>
> You tested all of the above?

Yes, all three tests run exactly as you described.

In addition
   - On a protected key/cert, without configuration
GIT shows the same behaviour as without the patch.

I checked using http.sslCertPasswordProtected and also 
GIT_SSL_CERT_PASSWORD_PROTECTED. curl is 7.19.5


Just let me know if you need more checks.


Marcus

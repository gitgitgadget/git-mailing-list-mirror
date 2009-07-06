From: Marcus Camen <mcamen@mcamen.de>
Subject: Re: What's cooking in git.git (Jul 2009, #01; Mon, 06)
Date: Mon, 6 Jul 2009 22:29:11 +0200
Message-ID: <200907062229.11763.mcamen@mcamen.de>
References: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 22:35:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNuuo-00064Y-1w
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 22:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206AbZGFUfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 16:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbZGFUfj
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 16:35:39 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.26]:43740 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562AbZGFUfi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 16:35:38 -0400
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jul 2009 16:35:38 EDT
Received: from [91.46.225.237] (helo=home.localnet)
	by smtprelay03.ispgateway.de with esmtp (Exim 4.68)
	(envelope-from <mcamen@mcamen.de>)
	id 1MNuoK-0007Ts-KJ; Mon, 06 Jul 2009 22:29:12 +0200
User-Agent: KMail/1.12.90 (Linux/2.6.27.23-0.1-default; KDE/4.3.60; x86_64; svn-991738; 2009-07-05)
In-Reply-To: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
X-Df-Sender: [pbs]924509
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122794>

On Montag 06 Juli 2009, Junio C Hamano wrote:
> * ml/http (Wed May 27 23:16:03 2009 -0400) 2 commits
>  - http.c: add http.sslCertPasswordProtected option
>  - http.c: prompt for SSL client certificate password
>
> I've rewritten these two to (1) move the #ifdef out of the main
> codepath, and (2) use configuration/environment to make the misfeature
> of always asking for a passphrase even a key/cert is unencrypted
> optional.  I tried to be careful but extra sets of eyeballs would be
> nice to check the result.
>
> Nobody seems to be jumping up-and-down asking for this or helping to
> push this forward.  Perhaps it's time to drop it?

/me jumping up-and-down

This fix is crucial for corporate environments where HTTPS is the only way 
to access GIT repositories outside the firewall.

I verified the patch and everything works as expected.


--
Marcus

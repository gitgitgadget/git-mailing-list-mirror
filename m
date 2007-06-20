From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: Suggestions for documentation
Date: Wed, 20 Jun 2007 18:06:15 -0300
Organization: Mandriva
Message-ID: <20070620180615.529dff2a@localhost>
References: <467786B1.5000009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Claudio Scordino <cloud.of.andor@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 23:06:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I17Nj-0006rp-8V
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 23:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbXFTVG0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 17:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbXFTVG0
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 17:06:26 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:33627 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbXFTVGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 17:06:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id C5A2D19C7A;
	Wed, 20 Jun 2007 18:06:23 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 8Bl84+dZ-DA8; Wed, 20 Jun 2007 18:06:17 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 37C8019C7B;
	Wed, 20 Jun 2007 18:06:17 -0300 (BRT)
In-Reply-To: <467786B1.5000009@gmail.com>
X-Mailer: Claws Mail 2.9.2 (GTK+ 2.11.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50573>

Em Tue, 19 Jun 2007 09:33:05 +0200
Claudio Scordino <cloud.of.andor@gmail.com> escreveu:

| Hi,
| 
|     I just want to suggest to put some missing information in the git manpages.
| 
| 1) As my previous question shown, how to clone from a specified port is not 
| currently documented. You should just add a sentence saying that the command is
| 
| git clone git://server:port/path/
| 
| 2) Maybe it is better to highlight that after a push on a remote repository, the 
| user has to do a checkout on that repository (people from the CVS and SVN worlds 
| get easily confused, otherwise).
| 
| Moreover (and I did not fully understood why) if I just use "git checkout" 
| without the -f option, I cannot see the changes that have been pushed from the 
| cloned repository.

 git-rebase documentation needs some change too. We should add some high level
description in one paragraph at the top of the file.

 I answer the very same question ('why should I want to use git-rebase?')
three times per week.

 I'll submit a patch shortly.

-- 
Luiz Fernando N. Capitulino

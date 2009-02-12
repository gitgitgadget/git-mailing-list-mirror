From: Pieter de Bie <pieter@frim.nl>
Subject: Re: Strange branch merging.
Date: Thu, 12 Feb 2009 12:27:58 +0000
Message-ID: <E65A809A-65AD-4755-8AA7-32AA11C9AB5A@frim.nl>
References: <49940D93.6000204@movency.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adam Panayis <adam@movency.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 13:29:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXahF-0004v0-Mv
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 13:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756502AbZBLM2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 07:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756304AbZBLM2J
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 07:28:09 -0500
Received: from frim.nl ([87.230.85.232]:60827 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753608AbZBLM2I (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2009 07:28:08 -0500
Received: from cpat002.wlan.net.ed.ac.uk ([129.215.5.254] helo=[172.20.196.2])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pieter@frim.nl>)
	id 1LXafk-00035z-Ty; Thu, 12 Feb 2009 13:28:04 +0100
In-Reply-To: <49940D93.6000204@movency.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109608>


On Feb 12, 2009, at 11:52 AM, Adam Panayis wrote:

> Once this is done I double check my branches and it shows I still  
> only have the master. Perfect. However, when I check the file I  
> edited on my local machine on the blah branch, the changes are there.
>
> Am I fundamentally misunderstanding the correct usage of git? Is  
> this result expected?

Yes, git pull will never change anything on the remote side. You  
should use 'git push' for that. But, you shouldn't push to repository  
with a working directory unless you know what you're doing -- read http://git.or.cz/gitwiki/GitFaq#non-bare 
  for that.

- Pieter

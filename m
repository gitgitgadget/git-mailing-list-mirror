From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: [RFC/PATCH 1/3] git-find-git: a new helper.
Date: Thu, 24 Nov 2005 06:41:33 +0100
Message-ID: <4385528D.7010203@yahoo.it>
References: <7vmzjuzphl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Martin Atukunda <matlads@dsmagic.com>
X-From: git-owner@vger.kernel.org Thu Nov 24 06:44:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef9ro-0006ea-3d
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 06:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbVKXFlw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 00:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbVKXFlw
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 00:41:52 -0500
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:25511 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1161003AbVKXFlv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 00:41:51 -0500
Received: (qmail 8211 invoked from network); 24 Nov 2005 05:41:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=hUAUD454Mg/3daF525miZ94hAb+ptBADN139TMUnsyxoU0wms1Fg6Xp0XRe6MZuYHiK2iA7M1B3iUyICFzXxhT4lk8kYldLr6fR3Cbj7DxXVraW4rixiFyA2zSID6CagcgFG33AEOm5COYUf86efAxa/0RbjjBekOkPDq8lKAQU=  ;
Received: from unknown (HELO ?10.0.0.13?) (mcostalba@151.44.27.8 with plain)
  by smtp012.mail.yahoo.com with SMTP; 24 Nov 2005 05:41:47 -0000
User-Agent: Mozilla Thunderbird 1.0.6-7.2.20060mdk (X11/20050322)
X-Accept-Language: it, it-it, en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzjuzphl.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12676>

Junio C Hamano wrote:

>  git-find-git uses it to find the
> top-level, and if it was run from a subdirectory, outputs shell
> script fragments that can be evaled to define the two variables:
> 
>     GIT_DIR_PREFIX is a string to be prepended to cwd relative
>     paths to make them repository relative.
> 
>     GIT_DIR_UPLEVEL is a string (e.g. "../") for the command to
>     use to cd to the top-level of repository.
> 
>
Sounds very good.

I did't had the time to test it but I think I can now
easily update qgit to run from a subdirectory with this new helper.

Marco

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it

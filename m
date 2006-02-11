From: Christian Biesinger <cbiesinger@web.de>
Subject: Re: [PATCH] Use a relative path for SVN importing
Date: Sat, 11 Feb 2006 18:04:08 +0100
Message-ID: <43EE1908.1000300@web.de>
References: <1139672651713-git-send-email-cbiesinger@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Feb 11 18:04:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7yAk-0001nP-8l
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 18:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWBKREQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 12:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWBKREQ
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 12:04:16 -0500
Received: from smtp06.web.de ([217.72.192.224]:43177 "EHLO smtp06.web.de")
	by vger.kernel.org with ESMTP id S932299AbWBKREQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 12:04:16 -0500
Received: from [85.124.17.142] (helo=[192.168.1.4])
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.105 #340)
	id 1F7yAR-0003PG-00
	for git@vger.kernel.org; Sat, 11 Feb 2006 18:04:15 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060209 SeaMonkey/1.5a
To: git@vger.kernel.org
In-Reply-To: <1139672651713-git-send-email-cbiesinger@web.de>
X-Sender: cbiesinger@web.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15950>

Christian Biesinger wrote:
> The absolute path (with the leading slash) breaks SVN importing, because it then
> looks for /trunk/... instead of /svn/trunk/... (in my case, the repository URL
> was https://servername/svn/)

I also tested a svn+ssh case and that works too (it also worked before, 
oddly enough).

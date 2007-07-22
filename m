From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [KORG] Encoding problem with the git documentation
Date: Sun, 22 Jul 2007 11:07:38 -0700
Message-ID: <46A39CEA.7020703@zytor.com>
References: <20070722174915.GI26471@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: webmaster@kernel.org, git@vger.kernel.org
To: Alexander Wuerstlein <snalwuer@cip.informatik.uni-erlangen.de>
X-From: git-owner@vger.kernel.org Sun Jul 22 20:14:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICfwi-0004b1-4g
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 20:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758095AbXGVSOS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 14:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762019AbXGVSOL
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 14:14:11 -0400
Received: from terminus.zytor.com ([198.137.202.10]:40884 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760637AbXGVSOD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 14:14:03 -0400
Received: from mail.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.8) with ESMTP id l6MI7eNg023171
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Jul 2007 11:07:40 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.13.8/8.13.8) with ESMTP id l6MI7e6P007394;
	Sun, 22 Jul 2007 11:07:40 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.13.8/8.13.6) with ESMTP id l6MI7c7m020849;
	Sun, 22 Jul 2007 11:07:39 -0700
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
In-Reply-To: <20070722174915.GI26471@cip.informatik.uni-erlangen.de>
X-Enigmail-Version: 0.95.0
X-Virus-Scanned: ClamAV 0.88.7/3728/Sat Jul 21 22:07:30 2007 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53284>

Alexander Wuerstlein wrote:
> 
> There are 2 resolutions for this problem, changing the charset the webserver
> delivers in the response headers or recoding the html to be utf-8. One
> possibility to fix the response headers would be to use the 'AddDefaultCharset'
> directive (http://httpd.apache.org/docs/2.2/de/mod/core.html#adddefaultcharset)
> like 'AddDefaultCharset Off' or 'AddDefaultCharset ISO-8859-1'.
> This could also be set in .htaccess, so the persons responsible for the subtree
> can control the charset by themselves without your interaction. Of course
> the right solution depends on your setup which you know best about :)
> 

We're aware of this problem, and the first answer is the right one --
this is 2007 and UTF-8 is what we should use everywhere.

However, the second option (using .htaccess) is available.

	-hpa

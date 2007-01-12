From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Change to the repository's root directory if needed.
Date: Fri, 12 Jan 2007 14:11:53 -0800
Message-ID: <45A807A9.3090402@midwinter.com>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net>	<200701121501.24642.andyparkins@gmail.com>	<20070112191044.GA5113@midwinter.com> <7vtzywq703.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 23:11:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Ucj-0006WM-Eu
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 23:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161127AbXALWL2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 17:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161136AbXALWL2
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 17:11:28 -0500
Received: from tater.midwinter.com ([216.32.86.90]:47723 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161131AbXALWLY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 17:11:24 -0500
Received: (qmail 19084 invoked from network); 12 Jan 2007 22:11:23 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.130?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 12 Jan 2007 22:11:23 -0000
User-Agent: Mail/News 1.5.0.9 (Macintosh/20070108)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vtzywq703.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36717>

Junio C Hamano wrote:
> Porcelains that define SUBDIRECTORY_OK but do not do cdup are
> very valid, and they should not be cd'ed up automatically.
>   

My patch doesn't do the cd if SUBDIRECTORY_OK is defined, for exactly 
that reason.

-Steve

From: Geert Bosch <bosch@gnat.com>
Subject: Re: [PATCH] rename_ref(): only print a warning when config-file update fails
Date: Fri, 6 Apr 2007 06:35:54 -0400
Message-ID: <2FE08503-8936-4EB9-9DBF-08AFE2923BD9@gnat.com>
References: <11758483861506-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 12:39:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZlnU-0000tq-IU
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 12:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767570AbXDFKf6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 06:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767575AbXDFKf5
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 06:35:57 -0400
Received: from nile.gnat.com ([205.232.38.5]:58601 "EHLO nile.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767574AbXDFKf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 06:35:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 0941748CDEF;
	Fri,  6 Apr 2007 06:35:54 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 03514-01-2; Fri,  6 Apr 2007 06:35:53 -0400 (EDT)
Received: from [172.16.1.99] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	by nile.gnat.com (Postfix) with ESMTP id A133A48CC33;
	Fri,  6 Apr 2007 06:35:53 -0400 (EDT)
In-Reply-To: <11758483861506-git-send-email-hjemli@gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43907>


On Apr 6, 2007, at 04:33, Lars Hjemli wrote:
> If git_config_rename_section() fails, rename_ref() used to return  
> 1, which
> left HEAD pointing to an absent refs/heads file (since the actual  
> renaming
> had already occurred).
>
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>

This makes sense in addition to my patch, if the renaming
fails for any of the other possible reasons.

   -Geert

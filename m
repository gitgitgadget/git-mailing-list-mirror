From: "atani" <atani@atani-software.net>
Subject: Re: [PATCH] update-cache.c ignore directories
Date: Fri, 22 Apr 2005 15:34:17 -0700
Message-ID: <1114209257.22405@tsunami.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Sat Apr 23 00:30:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP6ev-0000qL-4r
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 00:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVDVWe0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 18:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVDVWe0
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 18:34:26 -0400
Received: from atani-software.net ([66.220.5.35]:34450 "HELO
	atani-software.net") by vger.kernel.org with SMTP id S261252AbVDVWeW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 18:34:22 -0400
Received: from tsunami.he.net ([127.0.0.9]) by atani-software.net for <git@vger.kernel.org>; Fri, 22 Apr 2005 15:34:17 -0700
To: GIT Mailing List <git@vger.kernel.org>
X-Mailer: WebMail 1.25
X-IPAddress: 67.113.61.177
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

 
> Am Samstag, 23. April 2005 00:25 schrieb atani: 
>  
> > Now it spits out: 
> > ------------- 
> > 'plx' is a directory, ignoring 
> > ------------- 
>  
> I saw that you spit this out to stdout. Wouldn't it be better to 
spit it out  
> to stderr (even if its just a warning)? 
 
Sure.  I do not know of the current conventions on where the output 
should go, or which methods to use for said output.  Is there a 
standard method for handling "warnings"?  I saw there is the "die" 
method but that is not what should be used here as implies a "fatal" 
error. 
 
Mike 

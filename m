From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: little conundrum
Date: Thu, 3 Nov 2005 22:17:14 +0000
Message-ID: <200511032217.14362.alan@chandlerfamily.org.uk>
References: <200511031741.20496.alan@chandlerfamily.org.uk> <20051103200631.GJ1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 03 23:18:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXnOX-0005PG-NA
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 23:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbVKCWRO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 17:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbVKCWRO
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 17:17:14 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:22731
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1751400AbVKCWRO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 17:17:14 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EXnOT-0006fs-F4
	for git@vger.kernel.org; Thu, 03 Nov 2005 22:17:13 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <20051103200631.GJ1431@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11103>

On Thursday 03 Nov 2005 20:06, Petr Baudis wrote:
...
> But you actually do not want to do a merge, but:
>
> 	$ cd original-version
> 	$ cg-init
> 	$ cd ../modified-version
> 	$ cg-init
> 	$ cg-branch-add orig ../original-version
> 	$ cg-fetch orig
> 	$ echo `cg-object-id` `cg-object-id orig` >.git/info/grafts


very nice

I didn't know about the grafts stuff, but I can see what its doing.
-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.

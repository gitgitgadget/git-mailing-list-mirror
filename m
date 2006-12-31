From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Gitweb - caching
Date: Sun, 31 Dec 2006 15:01:33 -0500
Message-ID: <4598171D.2040002@garzik.org>
References: <45979136.3070901@eaglescrag.net> <20061231174123.GI6558@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 21:01:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H16sI-0002mb-Pw
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 21:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932775AbWLaUBj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 15:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933207AbWLaUBj
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 15:01:39 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:36991 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932775AbWLaUBj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 15:01:39 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1H16sA-0007vM-AW; Sun, 31 Dec 2006 20:01:34 +0000
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
To: Robert Fitzsimons <robfitz@273k.net>
In-Reply-To: <20061231174123.GI6558@localhost>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35708>

Robert Fitzsimons wrote:
>> Thoughts or comments are welcome.
> 
> Interesting work, John.  Some initial comments:
> 
> * It's a very intrusive set of changes.
> * An infinite expiry date isn't valid for all pages.
> * The other HTTP headers can change depending on the page returned.
> * A single cache directory is going to have problems as the number of
>   cached files grows.
> 
> What are the benefits of doing this inside of gitweb instead of using
> something like mod_cache or mod_perl handlers?

Or wrapping the gitweb output inside cgicache:
http://linux.yyz.us/projects.html

	Jeff

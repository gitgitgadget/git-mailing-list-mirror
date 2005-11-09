From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Errors cloning over http -- git-clone and cg-clone fail to fetch a reachable object...
Date: Tue, 8 Nov 2005 17:09:22 -0800
Message-ID: <20051109010922.GC5830@reactrix.com>
References: <46a038f90511061354k5378a92ckc427841f90ec8b4@mail.gmail.com> <1537CD60-21E4-4F5E-820F-216A4E8C06AC@hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 09 02:14:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZeX9-0005HP-Tm
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 02:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbVKIBNt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 20:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbVKIBNt
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 20:13:49 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:57343 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1030313AbVKIBNs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 20:13:48 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA919RtI024755;
	Tue, 8 Nov 2005 17:09:27 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA919M1g024751;
	Tue, 8 Nov 2005 17:09:22 -0800
To: Ben Clifford <benc@hawaga.org.uk>
Content-Disposition: inline
In-Reply-To: <1537CD60-21E4-4F5E-820F-216A4E8C06AC@hawaga.org.uk>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11376>

On Tue, Nov 08, 2005 at 10:19:53PM +1100, Ben Clifford wrote:

> I got similar today; www.hawaga.org.uk is some apache server on  
> linux, and piva.hawaga.org.uk, the client Mac OS X.
> ...
> error:  (curl_result = 3181280, http_code = 200, sha1 =  
> c99aa418704f576aad8249d042cd6afecf38afc4)

Those curl result codes all look wrong, and sounds like a memory issue
that Johannes Schindelin recently fixed in commit
90279074ca5cc336a8bfffd47d19d089b291b432.  Does your git build have that
patch?

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.

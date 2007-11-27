From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: If you would write git from scratch now, what would you
	change?
Date: Tue, 27 Nov 2007 12:33:46 -0500
Message-ID: <20071127123346.o2e0jb9hc4k40w8o@intranet.digizenstudio.com>
References: <200711252248.27904.jnareb@gmail.com>
	<fiet88$68n$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 18:35:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix4Ku-0006VT-0d
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 18:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757104AbXK0Reo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 12:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756565AbXK0Reo
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 12:34:44 -0500
Received: from k2smtpout06-02.prod.mesa1.secureserver.net ([64.202.189.103]:43141
	"HELO k2smtpout06-02.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756091AbXK0Ren (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 12:34:43 -0500
Received: (qmail 14608 invoked from network); 27 Nov 2007 17:33:47 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout06-02.prod.mesa1.secureserver.net (64.202.189.103) with ESMTP; 27 Nov 2007 17:33:47 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 93C9210007A;
	Tue, 27 Nov 2007 17:33:47 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KjyS+vdHfrFr; Tue, 27 Nov 2007 12:33:47 -0500 (EST)
Received: by ip-72-167-33-213.ip.secureserver.net (Postfix, from userid 48)
	id 04184100A5E; Tue, 27 Nov 2007 12:33:46 -0500 (EST)
Received: from mailrelay2.private.geico.com (mailrelay2.private.geico.com
	[205.143.204.198]) by intranet.digizenstudio.com (Horde MIME library) with
	HTTP; Tue, 27 Nov 2007 12:33:46 -0500
In-Reply-To: <fiet88$68n$1@ger.gmane.org>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66247>


Quoting Andy Parkins <andyparkins@gmail.com>:

>  - "index", "cached" and "stage" are a definite source of confusion

Hear, hear.

>  - "git add" and "git rm" would be nicer as "git stage" and "git unstage"
>    (or something similar)

Not sure it would be that easy. (As I have just learned recently) "git  
rm" is the opposite of "git add" _only_ in the case of  
files-not-previously-tracked. And the opposite of "git add <file>" for  
files-already-being-tracked is "git reset HEAD -- <file>", which is  
probably where you were going with "git unstage" 8-) .

>  - libgit would have come first
>  - "git revert" should be called "git invert"
>  - "git revert" would (maybe) be "git reset"
>  - "git clone" wouldn't exist

Why?  AFAIC, git clone works out quite well - both functionality and  
naming wise.

Cheers.
-- 
Jing Xue

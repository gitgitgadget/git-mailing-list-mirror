From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: Howto request: going home in the middle of something?
Date: Tue, 23 Oct 2007 13:56:55 -0400
Message-ID: <20071023135655.x6g6mln1j4880wog@intranet.digizenstudio.com>
References: <200710181144.22655.wielemak@science.uva.nl>
	<20071018112758.GN18279@machine.or.cz>
	<200710221044.24191.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 8BIT
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Jan Wielemaker <wielemak@science.uva.nl>
X-From: git-owner@vger.kernel.org Tue Oct 23 19:57:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkO05-0005pO-ET
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 19:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbXJWR46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 13:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752403AbXJWR46
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 13:56:58 -0400
Received: from k2smtpout03-02.prod.mesa1.secureserver.net ([64.202.189.172]:43945
	"HELO k2smtpout03-02.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751983AbXJWR45 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Oct 2007 13:56:57 -0400
Received: (qmail 27306 invoked from network); 23 Oct 2007 17:56:56 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout03-02.prod.mesa1.secureserver.net (64.202.189.172) with ESMTP; 23 Oct 2007 17:56:56 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 78485100079;
	Tue, 23 Oct 2007 17:56:56 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RWDV-NqVfW+8; Tue, 23 Oct 2007 13:56:55 -0400 (EDT)
Received: by ip-72-167-33-213.ip.secureserver.net (Postfix, from userid 48)
	id 96C2E100099; Tue, 23 Oct 2007 13:56:55 -0400 (EDT)
Received: from mailrelay3.private.geico.com (mailrelay3.private.geico.com
	[205.143.204.110]) by intranet.digizenstudio.com (Horde MIME library) with
	HTTP; Tue, 23 Oct 2007 13:56:55 -0400
In-Reply-To: <200710221044.24191.wielemak@science.uva.nl>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62141>


Quoting Jan Wielemaker <wielemak@science.uva.nl>:

> Thanks for the replies.	 I think I can live with something like this
>
> 	<work, in the middle of something>
> 	$ git checkout -b home
> 	$ git commit
> 	$ git checkout master
> 	<arriving at home>
> 	$ git jan@work:repo fetch home:home	(using ssh)
> 	$ git checkout home
> 	<continue editing>
> 	$ git commit --amend
> 	$ git checkout master
> 	$ git merge home
> 	$ git -d home
> 	$ git commit
> 	$ git push
> 	<arriving at work>
> 	$ git -d home
> 	$ git pull
>
> Its still a bit many commands and you have to be aware what you are
> doing for quite a while, but it does provide one single clean commit
> message, doesn't change the shared repo until all is finished and allows
> to abandon all work without leaving traces.

What does the extra branch gain for us here? That's not a rhetorical  
question, I'm actually curious to learn, because I always just commit,  
switch to another computer, pull, and reset HEAD^.

Thanks.
-- 
Jing Xue

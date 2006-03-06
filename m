From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Looking for SCM that lets me publish part of a repository
Date: Mon, 6 Mar 2006 06:54:12 +0000
Message-ID: <200603060654.12815.alan@chandlerfamily.org.uk>
References: <1141608679.16980.12.camel@mattlaptop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Mar 06 07:53:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG9bO-0003Zu-Kd
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 07:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbWCFGxu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 01:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbWCFGxu
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 01:53:50 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:32695
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1751877AbWCFGxu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 01:53:50 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1FG9bJ-0000SQ-Ev
	for git@vger.kernel.org; Mon, 06 Mar 2006 06:53:49 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <1141608679.16980.12.camel@mattlaptop>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17282>

On Monday 06 March 2006 01:31, Matt McCutchen wrote:
> Dear GIT people,
>
> For the last week or so, I have been looking for a SCM system to hold
> many of my projects, some of which are available to the public and
> others of which are not.  It would be nice if I could use a single large
> private repository on my computer with each project in a separate
> folder. 

Not sure why you would want to do this against having lots of smaller 
repositories - (I have lots of small repositories - its mostly java, and my 
shared library files have their own repository which is automatically 
exported to where my projects can access it when I commit to it via a post 
commit hook - you can see the public version of them on my web site) but ...

Create each project on a separate branch of the common repository and ensure 
only the files you want in each project remains on each branch (and any 
shared files can exist in all branches).

In your "remotes" files you list the branches that you want to push to your 
public repository.
-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.

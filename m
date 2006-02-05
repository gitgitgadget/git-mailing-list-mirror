From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: What is the working directory for post-update hook?
Date: Sun, 5 Feb 2006 09:37:12 +0000
Message-ID: <200602050937.12885.alan@chandlerfamily.org.uk>
References: <200602050906.52016.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Feb 05 10:37:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5gKh-000286-8Y
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 10:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbWBEJhL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 04:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbWBEJhK
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 04:37:10 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:54467
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1751684AbWBEJhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2006 04:37:09 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1F5gKS-000108-Te
	for git@vger.kernel.org; Sun, 05 Feb 2006 09:37:08 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <200602050906.52016.alan@chandlerfamily.org.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15627>

On Sunday 05 February 2006 09:06, Alan Chandler wrote:
> The document root of my website has a git repository under it (in the
> standard .git subdirectory) and want a post update hook to checkout the
> contents (so the web server sees it!)
>
> I will be pushing to it via ssh.
>
> Does this mean that the post-update hook with be run with a working
> directory of the web site's document root? or something relative (such as
> GIT_DIR) so that I don't have to do a specific cd to an absolute path.


I found it out, by getting the post update hook to e-mail me the value:-)

its in the repository (ie document_root/.git)

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.

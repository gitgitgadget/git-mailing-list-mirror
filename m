From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: problem with gitweb I don't understand
Date: Mon, 6 Feb 2006 22:47:49 +0000
Message-ID: <200602062247.49690.alan@chandlerfamily.org.uk>
References: <200602062135.27652.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Feb 06 23:47:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6F93-0005km-Eu
	for gcvg-git@gmane.org; Mon, 06 Feb 2006 23:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWBFWrj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 17:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWBFWri
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 17:47:38 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:15565
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S932159AbWBFWri (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2006 17:47:38 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1F6F8z-0005L0-Fi
	for git@vger.kernel.org; Mon, 06 Feb 2006 22:47:37 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <200602062135.27652.alan@chandlerfamily.org.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15667>

On Monday 06 February 2006 21:35, Alan Chandler wrote:
...>
> But gitweb is not displaying it (see http://www.chandlerfamily.org.uk/git).
>
> However if I do http://www.chandlerfamily.org.uk/git/?p=txpg.git;a=summary
>
> the error message I get is "403 Forbidden - No such project."  whereas if I
> had used any random characters for the project I would have got "403
> Forbidden - No such directory"

Cracked it.  I set repository permissions using the following (from the 
tutorial)

find repo.git -type d -print | xargs chmod ug+rwx,g+s

but directories need o+x as well so that the web server can read the refs


-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.

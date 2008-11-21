From: Andreas Ericsson <ae@op5.se>
Subject: Re: Cannot git pull using http from my git.mycompany.com
Date: Fri, 21 Nov 2008 10:54:02 +0100
Message-ID: <4926853A.6080009@op5.se>
References: <562019.27220.qm@web37908.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: garyyang6@yahoo.com
X-From: git-owner@vger.kernel.org Fri Nov 21 10:55:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3SjS-0005kO-0Z
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 10:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbYKUJyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 04:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbYKUJyF
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 04:54:05 -0500
Received: from mail.op5.se ([193.201.96.20]:43079 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799AbYKUJyD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 04:54:03 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2D7061B80087;
	Fri, 21 Nov 2008 10:49:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nGmtn1nqZvGQ; Fri, 21 Nov 2008 10:49:09 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 67D881B8007E;
	Fri, 21 Nov 2008 10:49:08 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <562019.27220.qm@web37908.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101505>

Gary Yang wrote:
> git pull http://git.mycompany.com/pub/git/u-boot.git HEAD
> fatal: http://git.mycompany.com/pub/git/u-boot.git/info/refs not found: did you run git update-server-info on the server?
> 
> Below are related gitweb configs. What did I do wrong?
> 
> 
> httpd.confg
> 
> <VirtualHost 10.66.4.168>
>     ServerName svdcgit01
>      DocumentRoot /pub/git
>      <Directory /var/www/cgi-bin>
>           Allow from all
>           AllowOverride all
>           Order allow,deny
>           Options ExecCGI
>           <Files gitweb.cgi>
>                SetHandler cgi-script
>           </Files>
>      </Directory>
>      DirectoryIndex /cgi-bin/gitweb.cgi
>      SetEnv  GITWEB_CONFIG  /etc/gitweb.conf
> #       RewriteEngine on
> #       RewriteRule ^/(.*\.git/(?!/?(HEAD|info|objects|refs)).*)?$ /cgi-bin/gitweb.cgi%{REQUEST_URI}  [L,PT]
> 
> 
> cat /etc/gitweb.conf


You seem slightly confused. gitweb is not used for cloning over http.
The following documents would almost certainly be beneficial for you
to read. Please don't ask any questions that are already answered in
those documents. If, by following the steps outlined in those docs,
you still cannot get things to work, please let us know what you fail
to understand so the texts can be amended.

http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#setting-up-a-public-repository
http://dtcsupport.gplhost.com/Git/Public-Repo-Howto

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

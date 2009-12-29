From: Jorge Bastos <mysql.jorge@decimal.pt>
Subject: Help on CGIT
Date: Tue, 29 Dec 2009 12:18:38 +0000
Message-ID: <31576a6d119e2edd66bd8bcc3281e9ad@192.168.1.222>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 29 13:18:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPb1T-00082n-0y
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 13:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbZL2MRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 07:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbZL2MRz
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 07:17:55 -0500
Received: from mailrly07.isp.novis.pt ([195.23.133.217]:34737 "EHLO
	mailrly07.isp.novis.pt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbZL2MRy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 07:17:54 -0500
Received: (qmail 14949 invoked from network); 29 Dec 2009 12:17:52 -0000
Received: from unknown (HELO mailfrt06.isp.novis.pt) ([195.23.133.198])
          (envelope-sender <mysql.jorge@decimal.pt>)
          by mailrly07.isp.novis.pt with compressed SMTP; 29 Dec 2009 12:17:52 -0000
Received: (qmail 25629 invoked from network); 29 Dec 2009 12:17:52 -0000
Received: from unknown (HELO web.decimal.pt) (Sent_by_authenticated_user_nm087018@[195.23.114.74])
          (envelope-sender <mysql.jorge@decimal.pt>)
          by mailfrt06.isp.novis.pt with SMTP; 29 Dec 2009 12:17:52 -0000
Received: from webmail.decimal.pt (localhost [127.0.0.1])
	by web.decimal.pt (Postfix) with ESMTP id 606F41A4291
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 12:18:38 +0000 (WET)
X-Sender: mysql.jorge@decimal.pt
User-Agent: RoundCube Webmail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135793>

Howdy people, 

Since i cannot find any CGIT web interface mailing list on their webpage,
i'm asking here. 

I have CGIT working at 50%. 

The 1st page show's correctly, but when i click the project name, it
becames unconfigured and wierd, and apache complains about this: 

[Tue Dec 29 12:12:25 2009] [error] [client 192.168.1.3] [cgit] Unable to
lock slot /var/cache/cgit/53200000.lock: No such file or directory (2)

My apache configuration for CGIT is: 

 AllowOverride None
 Options ExecCGI
 Order allow,deny
 Allow from all

 DirectoryIndex cgit.cgi

 AddHandler cgi-script cgi pl

Am i missing something else? I've asked google but there's not much info
on
the web about it. 

Thanks,
Jorge,

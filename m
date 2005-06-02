From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: qgit-0.3
Date: Thu, 02 Jun 2005 21:18:06 +0200
Message-ID: <429F5B6E.6070005@gorzow.mm.pl>
References: <20050601111949.90043.qmail@web26303.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, berkus@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 02 21:19:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdvCV-0007u8-MD
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 21:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVFBTUV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 15:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVFBTTv
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 15:19:51 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:22247 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S261253AbVFBTR5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 15:17:57 -0400
Received: (qmail 7788 invoked from network); 2 Jun 2005 19:17:53 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.161.223])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <berkus@gmail.com>; 2 Jun 2005 19:17:53 -0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by zen.uplink (Postfix) with ESMTP id D69A15828F8;
	Thu,  2 Jun 2005 21:18:06 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050425)
X-Accept-Language: en-us, en
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20050601111949.90043.qmail@web26303.mail.ukl.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Marco Costalba wrote:

>New version of qgit, the QT/C++ git viewer.
>
>Download at:
>
>http://prdownloads.sourceforge.net/qgit/qgit-0.3.tar.gz?download
>
>This time we use scons instead of qmake as build system (many thanks to Stanislav Karchebny), I
>hope people have less problems compiling it.
>
>  
>
Actually, your scons build system is botched, it can't find qt module.
Only after I installed a system global scons, that one could build qgit.

>As before just run make and copy the bin in the path.
>
>  
>
So why do you put ${SCONS} install as the install target in the Makefile?

However, the tool's great, really.

Theres only one cosmetic problem: The windows do not support UTF-8 somehow.
My GIT_COMMITTER_NAME contains them and they're displayed as single
bytes they consist of. Remember, default and only git encoding is UTF-8.

AstralStorm

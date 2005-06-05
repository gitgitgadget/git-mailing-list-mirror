From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: cg-init bug
Date: Sun, 05 Jun 2005 18:10:28 +0200
Message-ID: <42A323F4.2010109@gorzow.mm.pl>
References: <20050605153053.GA6890@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 18:07:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dexeh-0001Qq-8g
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 18:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVFEQKp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 12:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVFEQKp
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 12:10:45 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:15236 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S261588AbVFEQKk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 12:10:40 -0400
Received: (qmail 32299 invoked from network); 5 Jun 2005 16:10:37 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.161.223])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <zbrown@tumblerings.org>; 5 Jun 2005 16:10:37 -0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by zen.uplink (Postfix) with ESMTP id 5CE105C0449;
	Sun,  5 Jun 2005 18:10:28 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050425)
X-Accept-Language: en-us, en
To: Zack Brown <zbrown@tumblerings.org>
In-Reply-To: <20050605153053.GA6890@tumblerings.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Zack Brown wrote:

>Hi,
>
>I've been tracking Cogito. This problem occurred with Cogito version
>1e2673d606dd39dc44b4eed2204ba349a448bc4d
>
>I have a directory tree with several layers of subdirectories and about 1700
>files. I tried to convert it to a git repository with 'cg-init'.
>  
>
I think an ls -l of the repo would be useful... if it's not that big.
If it is, you may have hit the limitation of the length of command line.
If it's so, repeat the commands.

However, if I'd want to add everything to the repo, I'd do:
cg-status | sed "s/? //" | xargs cg-add

AstralStorm

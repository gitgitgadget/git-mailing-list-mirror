From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: Re: git-http-fetch Segmentation fault
Date: Tue, 8 May 2007 17:13:10 -0300
Organization: Mandriva
Message-ID: <20070508171310.7e21f5ef@localhost>
References: <20070508162735.6c530a70@localhost>
	<7vfy672iao.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, boiko@mandriva.com.br
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 22:14:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlW4L-0008Pg-JC
	for gcvg-git@gmane.org; Tue, 08 May 2007 22:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032066AbXEHUNc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 16:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032069AbXEHUNc
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 16:13:32 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:37203 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032066AbXEHUNa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 16:13:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id D879517ED3;
	Tue,  8 May 2007 17:13:28 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id oj6Xp435GIt9; Tue,  8 May 2007 17:13:22 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 6C81617EE1;
	Tue,  8 May 2007 17:13:18 -0300 (BRT)
In-Reply-To: <7vfy672iao.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Claws Mail 2.7.2 (GTK+ 2.10.9; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46618>

Em Tue, 08 May 2007 13:04:47 -0700
Junio C Hamano <junkio@cox.net> escreveu:

| "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> escreveu:
| 
| >  A friend of mine reported an easy to reproduce segmentation fault
| > when cloning through http from his repository:
| >
| > """
| > ~/ git clone http://people.mandriva.com/~boiko/mandrivamenu.git
| > got 299cdadd846913a052df361e973a947622f23198
| > walk 299cdadd846913a052df361e973a947622f23198
| > ...
| > got 0ecd10d9d6ab020c2469a961777854afda705776
| > /home/lcapitulino/git//bin/git-clone: line 33: 22353 Segmentation fault      (core dumped) git-http-fetch $v -a -w "$tname" "$sha1" "$1"
| > """
| >
| >  Sometimes it shows up as a corrupted double-linked list, detected by
| > glibc:
| 
| Does not seem to reproduce for me on my x86_64 box nor an i386
| box I happened to have access to.  Both run Debian etch.

 Forgot to say that you have to try a few times to reproduce.

 Boiko, can you try it on another distro? NSL maybe? I only run
Mandriva on my machines.

-- 
Luiz Fernando N. Capitulino

From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [RFD] gitweb configuration
Date: Sun, 18 Jun 2006 11:30:52 +0300
Message-ID: <20060618113052.660e1017.tihirvon@gmail.com>
References: <e720r0$qdv$1@sea.gmane.org>
	<20060617232358.GK2609@pasky.or.cz>
	<e72j53$1m1$1@sea.gmane.org>
	<46a038f90606180042w7b4d11dbvbea28b750ddbc6e2@mail.gmail.com>
	<e731ai$su1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 10:31:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrsgN-0007jo-LI
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 10:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWFRIa4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 04:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWFRIa4
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 04:30:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:61604 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751126AbWFRIaz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 04:30:55 -0400
Received: by nf-out-0910.google.com with SMTP id y25so1135589nfb
        for <git@vger.kernel.org>; Sun, 18 Jun 2006 01:30:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=s8XD2NyZ7vSDIvTcvBm4/kPXE644Hie9ZQv4hQDzM+2ier0Q3ljH+/A0SQeqeZO9YAWm7Rn/hdNiFq7o+T6Ocp+wxNtkbbCguaQW3+psYpJSG/kxTymoRayy5jyOMfAsjAVog8x5csAedfjjLyBReWDNm5+QlL5xy8wxT7lEjp4=
Received: by 10.48.43.7 with SMTP id q7mr3491822nfq;
        Sun, 18 Jun 2006 01:30:54 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id p43sm2585059nfa.2006.06.18.01.30.53;
        Sun, 18 Jun 2006 01:30:54 -0700 (PDT)
To: jnareb@gmail.com
In-Reply-To: <e731ai$su1$1@sea.gmane.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22060>

Jakub Narebski <jnareb@gmail.com> wrote:

> - use ~/.gitconfig, /etc/gitconfig or some other global git configuration 
>   file, reading values using '$gitexecdir/git-repo-config'.
>   Problem: bootstraping, namely value of $gitexecdir ($gitbin now)
>   needs to be set in gitweb.cgi, perhaps during the build process.

Just use "git command" and you don't have to know $gitexecdir.

-- 
http://onion.dynserv.net/~timo/

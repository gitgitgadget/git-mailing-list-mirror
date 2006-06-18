From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH 1/7] Remove ranges from switch statements.
Date: Mon, 19 Jun 2006 00:24:45 +0300
Message-ID: <20060619002445.3af68c2b.tihirvon@gmail.com>
References: <11506438892865-git-send-email-octo@verplant.org>
	<1150643889264-git-send-email-octo@verplant.org>
	<7vveqyyxyj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 23:24:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fs4lL-0007HE-Fm
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 23:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWFRVYw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 17:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWFRVYw
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 17:24:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:791 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932088AbWFRVYw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jun 2006 17:24:52 -0400
Received: by nf-out-0910.google.com with SMTP id y25so1185155nfb
        for <git@vger.kernel.org>; Sun, 18 Jun 2006 14:24:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=r1pSwVa8cpgHO3fTckZ5ANGoty3XOFxG5qKBJU0MMeLlGy3JbYKjYCX8KN0sNqpgbxnPpN8IiJutD08K1u0V7lcViJjqtfkuOIPDoRene+FsMlPNGm9otOZ6N4tx7XY0qbcjp6JTgs596oWu83YXIdUttrqFea85kKK2LSugY2o=
Received: by 10.49.60.12 with SMTP id n12mr3939082nfk;
        Sun, 18 Jun 2006 14:24:50 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id l22sm4878320nfc.2006.06.18.14.24.48;
        Sun, 18 Jun 2006 14:24:49 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vveqyyxyj.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22103>

Junio C Hamano <junkio@cox.net> wrote:

> Sorry for bringing up an old topic again, but wouldn't people
> agree that this is easier to read if it were written this way ;-)?
>  
> 	if (	   (('A' <= ch) && (ch <= 'Z'))
>         	|| (('a' <= ch) && (ch <= 'z'))
> 		|| (('0' <= ch) && (ch <= '9'))
> 	...

Yes, but isalnum(ch) even better ;)

-- 
http://onion.dynserv.net/~timo/

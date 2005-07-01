From: Jon Seymour <jon.seymour@gmail.com>
Subject: OOPS: unnumbered patch series
Date: Fri, 1 Jul 2005 16:34:22 +1000
Message-ID: <2cfc40320506302334357a9f29@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jul 01 08:27:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoEzR-0002eN-IS
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 08:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263239AbVGAGec (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 02:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263240AbVGAGec
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 02:34:32 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:24499 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263239AbVGAGeX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Jul 2005 02:34:23 -0400
Received: by rproxy.gmail.com with SMTP id i8so216686rne
        for <git@vger.kernel.org>; Thu, 30 Jun 2005 23:34:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jU1x6cQfo+Z5UGqVw4iLc3dP8p2cir15hxqqJaY7SxhgKI/uaakm9ezJhG5MPrZbWVfplZ8yCG7NI4lK7piuofNhWZj/tWMnqjMbyevOxEMnxWEg4MVRPERoGpS3rj1NVp1GfXmrb0AnWF+JQQk0WQEwCWRbmEkYODV6ysvV8MA=
Received: by 10.38.65.7 with SMTP id n7mr958736rna;
        Thu, 30 Jun 2005 23:34:22 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Thu, 30 Jun 2005 23:34:22 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sorry about that. I'll resend with each patch numbered in sequence.

I forgot that git-format-patch-script no longer numbers things by default.

Junio: this is an example where the special case would be good. As it
stands, I now have to add a special case to my wrapper around your
scripts to use the -n switch if and only if I have more than 1 patch
to send.

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/

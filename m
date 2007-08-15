From: Perrin Meyer <perrinmeyer@yahoo.com>
Subject: Re: 1.5.3-rc5 regression on OS X?
Date: Wed, 15 Aug 2007 16:35:18 -0700 (PDT)
Message-ID: <186438.43606.qm@web52812.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 01:42:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILSVo-0005Sb-8A
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 01:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184AbXHOXmE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 19:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbXHOXmD
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 19:42:03 -0400
Received: from web52812.mail.re2.yahoo.com ([206.190.49.1]:30756 "HELO
	web52812.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965174AbXHOXmA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 19:42:00 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Aug 2007 19:42:00 EDT
Received: (qmail 46040 invoked by uid 60001); 15 Aug 2007 23:35:18 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=q0DkvpMt6iu9WQ8ezkpsy82X71Ji07OSJVbOGhXwiPN9m/89kQ775YuMIHtsdov5ZxWHSG+KK+JmpAsPenWLATKat+qtp2bf+1YelDeEnJn2BsvljMth56of006GmC+y+ZX0im2ggQetk7VRbZAxPCGVvpC8WMrfMSIGeT5g8lQ=;
X-YMail-OSG: RxnaJeYVM1k8sh8ZEeZLhT7uY20EIPL4QY4VCadOXaHhl53vZ_FeUsutn_TXlU72E4j9OD9npw--
Received: from [216.52.12.233] by web52812.mail.re2.yahoo.com via HTTP; Wed, 15 Aug 2007 16:35:18 PDT
X-Mailer: YahooMailRC/651.48 YahooMailWebService/0.7.119
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55969>


Yes, this patch fixes the error I was seeing in t1000-read-tree-m-3way.sh

Thanks,

Perrin


----- Original Message ----
From: Junio C Hamano <gitster@pobox.com>
To: Perrin Meyer <perrinmeyer@yahoo.com>
Cc: git@vger.kernel.org
Sent: Wednesday, August 15, 2007 3:59:17 PM
Subject: Re: 1.5.3-rc5 regression on OS X?

Perrin Meyer <perrinmeyer@yahoo.com> writes:

> Well, this is my first time using git-bisect (which seems like a VERY cool tool), but iterating through, using 
> $ make clean ; make -j 4 ; cd t ; sh t1000-read-tree-m-3way.sh ; cd ..
>
> The first bad commit is:
>
> 933bf40a5c6328b6c022b636f45a6f2c48c3838e is first bad commit
> ...
> I'll install the newest Xcode and see if that fixes things. 

Thanks, but before doing so could you try the patch I just sent
out?

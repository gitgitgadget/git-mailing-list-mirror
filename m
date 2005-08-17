From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: [PATCH] git-format-patch fix
Date: Wed, 17 Aug 2005 01:31:38 -0700 (PDT)
Message-ID: <20050817083138.9967.qmail@web26303.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 10:31:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5JKq-0008GO-1r
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 10:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbVHQIbl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 04:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbVHQIbl
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 04:31:41 -0400
Received: from web26303.mail.ukl.yahoo.com ([217.146.176.14]:12967 "HELO
	web26303.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750998AbVHQIbk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 04:31:40 -0400
Received: (qmail 9969 invoked by uid 60001); 17 Aug 2005 08:31:38 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Yrq7M3/af0AslFSsZrwJALa4cPQIGdY2iqSqILketSZ8Tz5skU/8fMOshK0p02BEze8bxLQm1s88XuyQWjriX6vts2LmJJ7109fIyl4M5GIzecQlPhigQQAXIgJxd7ZR+Ac+QV1wPQ3j5oL06RiEDefLCS1gtZAsxjwqP0m9BOo=  ;
Received: from [151.42.53.158] by web26303.mail.ukl.yahoo.com via HTTP; Wed, 17 Aug 2005 01:31:38 PDT
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

>Introduces --keep-subjects flag to tell it not to munge the
>first line of the commit message.  Running "git applymbox" on
>the output from "git format-patch -m -k" would preserve the
>original commit information better this way.
>


>Opinions?  Objections?
>

This is exaclty what I was looking for. This indirectly answer also to my 
concerns about the method.

Thanks
Marco


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

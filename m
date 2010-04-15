From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] format-patch: use current date in mbox 'From COMMIT
 DATE' header line
Date: Thu, 15 Apr 2010 18:19:46 -0500
Message-ID: <20100415231945.GA20584@progeny.tock>
References: <9946ffbdf26e7b08b9b00b87d4b575fea774be4c.1271342450.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 01:19:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2YLW-0001oT-JI
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 01:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445Ab0DOXTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 19:19:37 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62283 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab0DOXTg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 19:19:36 -0400
Received: by pva18 with SMTP id 18so1323158pva.19
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 16:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qI78r54/9dVocanSba/RF759ywg6xm8NNbgn+FztukE=;
        b=OZhQcmcT3LZpPDAsPPGWimzcTIknvyYBqHOOybpIA7RdNws1gpX3Hncm7cJaKoy+oW
         AiDVvJBGqRjOAN9L28qR9mxN7ZntVPLjv9ttqq3j+ILUNgzg/xI5iXTBTdLNi5svQXTg
         HyHvQHMDTzrQpZxyJgnFwEMrpxF/Od8MxliNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ev4+x42Ub2r4s5vf/qrFVM8NzsXuMd0i/VUoUSZux+iUjluwerhYTw9ckCWs0I5HZ5
         fB8UfmwDX0JoOPQjyvDOV2sg9WiLMARF0KWZKi7ET0yiawqTE4Gy+okc/TAWDDkBvI98
         ucyKQIY6YPEsW5Cbhl9jG5csAQypBRomblLZg=
Received: by 10.142.250.21 with SMTP id x21mr587461wfh.263.1271373575591;
        Thu, 15 Apr 2010 16:19:35 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm1356591iwn.1.2010.04.15.16.19.34
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 16:19:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9946ffbdf26e7b08b9b00b87d4b575fea774be4c.1271342450.git.chris@arachsys.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145034>

Hi,

Chris Webb wrote:

> Put the current date in the 'From COMMIT DATE' header line instead of using
> the fixed date 'Mon Sep 17 00:00:00 2001'.

Please no.  It is useful that format-patch generates the same output
when run a few times in a row.

If it is important to have a realistic date, would the commit date or
similar work?

Jonathan

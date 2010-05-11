From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 GSoC] gitweb: Move static files into seperate subdirectory
Date: Wed, 12 May 2010 01:27:54 +0200
Message-ID: <201005120127.55971.jnareb@gmail.com>
References: <p2ze72faaa81005090656j593c3464v9ee1bb6432461efc@mail.gmail.com> <201005101455.50633.jnareb@gmail.com> <4BE803B8.4090607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 12 01:28:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBys1-0005RB-If
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 01:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105Ab0EKX2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 19:28:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:33102 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839Ab0EKX2E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 19:28:04 -0400
Received: by fg-out-1718.google.com with SMTP id d23so232072fga.1
        for <git@vger.kernel.org>; Tue, 11 May 2010 16:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=0off1ttMcKX6T72Ilau44HJSxk1cUin2sPSOL+NknwY=;
        b=jvyAHNyici+0+b9+Ks4SfBWdP0/0UBf6sOjFOOhcSUqt6Dnv6i3iQbSkaEBK47J4hg
         c7Yb7jEq/vbjywALPryZ7w5x3SH/KhGF5qnAhf5u6VYS/wGGBrojSVrXQnVP/ld7gIAL
         P9xz9aNO6uLsxjbZmUxlmpidvevGECmlgJSE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qCoZmLEZ4H00U+QIRnOJw4Zh+m4bF4Tqhc/VWzm6h+dHSt2KrKAG9Lytms7f5yMq+F
         v/Z2fqSShawNmELIR5Wcdb7HmxkJQAdmyFpxIEY1eYhYJBaBpIuUUtJJ7PVKfWQSmJJj
         W9EjSlfse5ki+9SL4h7DdhfU6SIlXU1u2txsM=
Received: by 10.87.15.40 with SMTP id s40mr13204208fgi.44.1273620482682;
        Tue, 11 May 2010 16:28:02 -0700 (PDT)
Received: from [192.168.1.13] (abwc23.neoplus.adsl.tpnet.pl [83.8.226.23])
        by mx.google.com with ESMTPS id e11sm7442649fga.3.2010.05.11.16.28.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 May 2010 16:28:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4BE803B8.4090607@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146912>

On Mon, 10 May 2010, Pavan Kumar Sunkara wrote:
> On Monday 10 May 2010 06:25 PM, Jakub Narebski wrote:
>> On Mon, 10 May 2010, Pavan Kumar Sunkara wrote:
>>    
>>> Gitweb: Move static files into seperate subdirectory
>>>      
>>> Create a new subdirectory called 'static' in gitweb/, and move
>>> all static files required by gitweb.cgi when running, which means
>>> styles, images and Javascript code. This should make gitweb more
>>> readable and easier to maintain.
>>>
>>> Update t/gitweb-lib.sh to reflect this change.  The default is
>>> now to install static files also in 'static' subdirectory in target
>>> directory: update Makefile, gitweb's INSTALL, README and Makefile
>>>
>>> Signed-off-by: Pavan Kumar Sunkara<pavan.sss1991@gmail.com>
 
> I would like to know when this patch will be merged.

Note please that this patch conflict on semantic level with the
patch adding support for 'install' target in gitweb/Makefile (and 
install-gitweb to the main Makefile), which means that either this
one or the 'jn/gitweb-install' would have to be changed.

-- 
Jakub Narebski
Poland

From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCHv3 GSoC] gitweb: Move static files into seperate subdirectory
Date: Thu, 13 May 2010 14:31:53 +0530
Message-ID: <4BEBC001.10803@gmail.com>
References: <p2ze72faaa81005090656j593c3464v9ee1bb6432461efc@mail.gmail.com> <201005120127.55971.jnareb@gmail.com> <4BEA5E2F.9070608@gmail.com> <201005131054.01262.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu May 13 11:02:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCUJ4-0001gW-5w
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 11:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757214Ab0EMJCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 05:02:03 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44400 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757002Ab0EMJB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 05:01:59 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so570995pwi.19
        for <git@vger.kernel.org>; Thu, 13 May 2010 02:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=k+P11CSscVzKXJO8obLn2nS/mf9wb9sjv2o4nVV6U2M=;
        b=vpQe/QP7bDDka9Gjuv+aJP+ifbmQ+oR6xmZ2SUOU6KjsVfA82E+X7BclCobHW9f/nH
         lIa4/jRRrqVlkWm32OY+iAXL5ozDXD82RQ/BAqz6H2xq67/zuVN3bk6qWWGWBmvV991y
         UXCJ1H8RNCEIyBGrQEBKBVbpH6QndAfUg/shE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=vdrOQS6M6FJV+7QI0nHaeAYCLcKSFEaMZlkrDjAVFLf0u+CMKmlmckNovE/2njU4/Z
         ZCfoPHSSjhw9gZe1RORLFoYXIb8bWeF/9C5jvUZgM/SF9uj7kSVE4ONpxU0iGd2utEAO
         uvjy5U3rec9D6hThkiIlj5pTHcIUe13s+DPMA=
Received: by 10.115.134.10 with SMTP id l10mr5462289wan.138.1273741318654;
        Thu, 13 May 2010 02:01:58 -0700 (PDT)
Received: from [172.16.19.166] ([202.63.112.23])
        by mx.google.com with ESMTPS id c22sm8928131wam.18.2010.05.13.02.01.55
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 13 May 2010 02:01:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <201005131054.01262.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146981>


>>    First you have to generate gitweb.cgi from gitweb.perl using
>> -"make gitweb", then copy appropriate files (gitweb.cgi, gitweb.js,
>> -gitweb.css, git-logo.png and git-favicon.png) to their destination.
>> -For example if git was (or is) installed with /usr prefix, you can do
>> +"make gitweb", then "make install-gitweb" appropriate files
>>      

Sorry about that.

- Pavan

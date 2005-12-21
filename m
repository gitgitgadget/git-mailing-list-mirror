From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: [PATCH] gqit: enable compiler warnings
Date: Wed, 21 Dec 2005 08:11:54 +0100
Message-ID: <43A9003A.8010408@yahoo.it>
References: <1135131068.1183.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 21 08:13:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eoy8x-00024z-TQ
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 08:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVLUHMI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 02:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbVLUHMI
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 02:12:08 -0500
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:38260 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932299AbVLUHMH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 02:12:07 -0500
Received: (qmail 85006 invoked from network); 21 Dec 2005 07:12:04 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=XtawNiEy5/yV0GmWxYnvNq5gbTDAHkInx5GJvE26DpDdeeAx1mdRvW9vs0HYbfPrvssAZ1pM20N53qBVnHEm05YaTf5bYIk/UwieFYmVFg9ADalyPs6VQ0SdBKJJwqZfXGEzwgIDIDVfYJHd6gjiarFvfVlpM0jDR5hMGBmJViM=  ;
Received: from unknown (HELO ?10.0.0.13?) (mcostalba@151.44.24.188 with plain)
  by smtp100.mail.sc5.yahoo.com with SMTP; 21 Dec 2005 07:12:03 -0000
User-Agent: Mozilla Thunderbird 1.0.6-7.2.20060mdk (X11/20050322)
X-Accept-Language: it, it-it, en-us, en
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1135131068.1183.6.camel@dv>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13870>

Pavel Roskin wrote:
> The "-O2" flag should be separated from the threading support.  Besides,
> it belongs to CCFLAGS (compile flags common to C and C++), not to
> CPPFLAGS (preprocessor flags).  While at that, enable all warnings by
> -Wall, except those about non-virtual destructors, which are "inherited"
> from Qt.  Portability is not affected since -O2 was already
> gcc-specific.
> 
> Signed-off-by: Pavel Roskin <proski@gnu.org>
> 
Thanks applied.

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com

From: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: Strange dependency problem installing GIT 0.99.7
Date: Mon, 19 Sep 2005 15:11:24 +1000
Message-ID: <432E487C.7090309@bigpond.net.au>
References: <432E1F28.9060909@bigpond.net.au> <7v8xxtzmtl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 07:13:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHDwa-0003EX-QT
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 07:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVISFLd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 01:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVISFLd
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 01:11:33 -0400
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:24493 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932306AbVISFL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 01:11:26 -0400
Received: from [192.168.0.4] (really [147.10.133.38])
          by omta02sl.mx.bigpond.com with ESMTP
          id <20050919051125.ESNB21196.omta02sl.mx.bigpond.com@[192.168.0.4]>;
          Mon, 19 Sep 2005 05:11:25 +0000
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xxtzmtl.fsf@assigned-by-dhcp.cox.net>
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 19 Sep 2005 05:11:24 +0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8835>

Junio C Hamano wrote:
> Peter Williams <pwil3058@bigpond.net.au> writes:
> 
> 
>>So I installed String::ShellQuote from CPAN and tried again with the 
>>same result.  So I then rebuilt the rpm on my system and still got the 
>>same error message.  So I've installed the rpm using the --nodeps option 
>>but would like to test whether it is successfully finding 
>>String::ShellQuote.  Which command(s) would exercise this perl package?
> 
> 
> $ git grep ShellQuote
> git-archimport.perl:42:use String::ShellQuote;

That command finds ShellQuote OK which more or less confirms that it's 
just an rpm problem.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

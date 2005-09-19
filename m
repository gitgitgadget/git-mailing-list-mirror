From: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: Strange dependency problem installing GIT 0.99.7
Date: Mon, 19 Sep 2005 16:24:10 +1000
Message-ID: <432E598A.7020306@bigpond.net.au>
References: <432E1F28.9060909@bigpond.net.au>    <7v8xxtzmtl.fsf@assigned-by-dhcp.cox.net> <53717.10.10.10.28.1127107066.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 08:24:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHF4a-0006Tf-Rg
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 08:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVISGYN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 02:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbVISGYN
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 02:24:13 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:6382 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932332AbVISGYM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 02:24:12 -0400
Received: from [192.168.0.4] (really [147.10.133.38])
          by omta03ps.mx.bigpond.com with ESMTP
          id <20050919062410.QGFN10252.omta03ps.mx.bigpond.com@[192.168.0.4]>;
          Mon, 19 Sep 2005 06:24:10 +0000
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <53717.10.10.10.28.1127107066.squirrel@linux1>
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 19 Sep 2005 06:24:10 +0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8841>

Sean wrote:
> On Mon, September 19, 2005 12:46 am, Junio C Hamano said:
> 
>>Peter Williams <pwil3058@bigpond.net.au> writes:
>>
>>
>>>So I installed String::ShellQuote from CPAN and tried again with the
>>>same result.  So I then rebuilt the rpm on my system and still got the
>>>same error message.  So I've installed the rpm using the --nodeps option
>>>but would like to test whether it is successfully finding
>>>String::ShellQuote.  Which command(s) would exercise this perl package?
>>
>>$ git grep ShellQuote
>>git-archimport.perl:42:use String::ShellQuote;
> 
> 
> 
> Peter,
> 
> You need to install ShellQuote with rpm rather than installing it directly
> from CPAN.  You can pick up a rpm version of ShellQuote from several
> places, here's one:  http://tinyurl.com/7p7ey

IMHO rpm shouldn't care how ShellQuote got there unless it (how it got 
there) is stated as an explicit dependency in the spec file (which it 
isn't).  So I still think this is a bug in rpm's (automatic) dependency 
mechanism that needs fixing.

Peter
PS I notice that perl isn't included in the explicit list of 
dependencies in the spec file even though other equally ubiquitous 
packages are.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

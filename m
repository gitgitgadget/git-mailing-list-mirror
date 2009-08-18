From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-instaweb: fix mod_perl detection for apache2
Date: Tue, 18 Aug 2009 09:45:37 +0200
Message-ID: <200908180945.40412.jnareb@gmail.com>
References: <4C22ECF8-8FBE-4E45-A7CF-EA1203B49AA7@mailservices.uwaterloo.ca> <m3iqgwoxq7.fsf@localhost.localdomain> <3300D840-9BAB-4233-B949-6A5B300CD9A8@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark A Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Tue Aug 18 09:38:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdJHN-0003JX-UZ
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 09:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbZHRHil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 03:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbZHRHil
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 03:38:41 -0400
Received: from mail-fx0-f215.google.com ([209.85.220.215]:52255 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbZHRHik (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 03:38:40 -0400
Received: by fxm11 with SMTP id 11so191544fxm.39
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 00:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+nX/mjfBL/5+/Lw59QP9Ji+d5MubcMHQI7UNAEzmV5o=;
        b=jxNCYf1Ezng0LBmVskEm+ramrxC/Z7X27HOyEpJ/QOYKnVzRcsuBYka8Wmp4z9GZ60
         4gpFrIISVsi6k3/D2RIOP0EgNmFFQWSg3e+UPbh3UHUjS2JIXrrHA4pM4ecxu349i7r0
         JRLzHqnPThdHn7Ayk4kn1KB4yutAEx4+zfJFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=e2h1x51Ka4Y3JPgXLsSFIBD81RaTBPWdxvrwec5RZh9nZXkC0r0bZPfuT2IMPRYsK8
         B6eePKAM3Knv4cEccVhKxjHc7f80YUtw/W/Jx+mMz0/uYjApebhy068iH+7UdFxIgchF
         EkvFMgMQRoCpq9+MuOyK7XchONRk4mazIqD1g=
Received: by 10.86.20.8 with SMTP id 8mr3029976fgt.44.1250581120680;
        Tue, 18 Aug 2009 00:38:40 -0700 (PDT)
Received: from ?192.168.1.13? (abvz12.neoplus.adsl.tpnet.pl [83.8.223.12])
        by mx.google.com with ESMTPS id e20sm5563540fga.7.2009.08.18.00.38.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Aug 2009 00:38:39 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <3300D840-9BAB-4233-B949-6A5B300CD9A8@mailservices.uwaterloo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126356>

On Wed, 15 Aug 2009, Mark A Rada wrote:
> On 10-Aug-09, at 4:55 AM, Jakub Narebski wrote: 
>> Junio C Hamano <gitster@pobox.com> writes:

>>> Thanks.  That sounds like an ancient bug that in turn perhaps  
>>> suggests nobody uses instaweb.  Will apply to 'maint'..
>>
>> Hmmm... taking a peek at current "Git User's Survey 2009" results
>> http://www.survs.com/shareResults?survey=2PIMZGU0&rndm=678J66QRA2
>>
>> 11. What Git interfaces, implementations, frontends and tools do you
>>    use?
>>
>>    git-instaweb  	3%  	77 / 2712
>>
>> 16. How often do you use the following forms of git commands or extra
>>    git tools?
>>
>>    git instaweb
>>      never:     1983 - 79%
>>      rarely:     208 -  8%
>>      sometimes:   50 -  2% 	
>>      often:        9 -  0% 	
>>
>>    Total respondents  	 2506
>>
>
> Does this means it may be taken off the menu in the not too distant  
> future or deprecated?

I don't think so.  We keep git-relink, which almost nobody uses, and
few know what it does.

I guess that git-instaweb is not advertised enough, but that might 
change, as Scott Chacon in "Pro Git" mentions / covers git-instaweb.


P.S. I'd like to create GIT::Web, which would use (contrary to gitweb)
many CPAN modules (and PAR to help installing it with dependencies),
which would use HTTP::Engine (and therefore run as CGI, FastCGI, 
mod_perl and standalone HTTP::Server::Simple), and be similar in 
structure to SVN::Web.  With it using HTTP::Server::Simple git-instaweb 
would be needed less...  But it is in "Duke Nuke Forever" (or 
packv4 ;-) future...

-- 
Jakub Narebski
Poland

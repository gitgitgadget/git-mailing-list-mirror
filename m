From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #01; Tue, 9)
Date: Fri, 12 Nov 2010 00:53:27 +0100
Message-ID: <201011120053.29279.jnareb@gmail.com>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org> <m3iq06fa9i.fsf@localhost.localdomain> <7vsjz7hj3s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 12 00:53:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGgxb-0003y3-Im
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 00:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175Ab0KKXxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 18:53:39 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33043 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab0KKXxh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 18:53:37 -0500
Received: by fxm16 with SMTP id 16so1866280fxm.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 15:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ThIMllAxzbl5TKXHkWYSwj+Jm7IENxcTWv+TygoYQqk=;
        b=MB/KJ2yQ8UHpI0J6NS+Cwy4NW5FnFceOeIMIVqfR7XBWvyy7KdjIhL1U8W+adYHJwj
         Sl/B4a/IJY8R+i8v7SywqcQhhGzlqvZCQmaobCTUaFqQ+ONJTJmfDYZLx7rREItVtu8p
         0k4iQjNlkwL2ywOl7eZ5MbMpHUhabNCN7dwYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ClGCcvZBpHUUsFG/Q4jpT5yoYjDNoe4/G0YUf91So0asq0gsUQDX7d4FgW9ppKIQe6
         wjOrK5tyzxyro6LlI0kI7xCMI+NMEKumYITYmkKUVxMHtEXXopM9yVlzFk5dshiP1DSi
         QXbvK3FdCGOAIeoFH0OzXVmdx1LGy6cA4w6Ts=
Received: by 10.223.122.201 with SMTP id m9mr774609far.79.1289519616626;
        Thu, 11 Nov 2010 15:53:36 -0800 (PST)
Received: from [192.168.1.13] (abvw231.neoplus.adsl.tpnet.pl [83.8.220.231])
        by mx.google.com with ESMTPS id 15sm1170054fal.22.2010.11.11.15.53.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 15:53:35 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vsjz7hj3s.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161309>

On Thu, 11 Nov 2010, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Junio C Hamano <gitster@pobox.com> writes:
>> ...
>>> * jh/gitweb-caching (2010-11-01) 4 commits
>>>  - gitweb: Minimal testing of gitweb caching
>>>  - gitweb: File based caching layer (from git.kernel.org)
>>>  - gitweb: add output buffering and associated functions
>>>  - gitweb: Prepare for splitting gitweb
>>>  (this branch uses jn/gitweb-test.)
>>
>>> * jn/gitweb-test (2010-09-26) 4 commits
>>>   (merged to 'next' on 2010-11-05 at 90b3adf)
>>>  + gitweb/Makefile: Include gitweb/config.mak
>>>  + gitweb/Makefile: Add 'test' and 'test-installed' targets
>>>  + t/gitweb-lib.sh: Add support for GITWEB_TEST_INSTALLED
>>>  + gitweb: Move call to evaluate_git_version after evaluate_gitweb_config
>>>  (this branch is used by jh/gitweb-caching.)
>>
>> These two branches have simple to resolve but non-trivial conflict.
>> Should I rebase 'jh/gitweb-caching' on top of 'jn/gitweb-test' then,
>> resolving this conflict?
> 
> In general, when a conflict between topic A and B is simple to resolve
> (and I have the correct resolution already in 'pu'), I'd rather prefer to
> keep topic A independent of topic B than rebasing topic A on top of topic
> B, unless topic A is far from ready and topic B is truly ready and about
> to graduate, so that we can leave a door open for A to graduate before B
> does (or vice versa).
> 
> In this case, I think it is overdue (iow, sorry I've been slow) for the
> gitweb-test topic to graduate, so the separation does not really matter.

I have send version of 'gitweb: Prepare for splitting gitweb' that applies
cleanly on top of "gitweb/Makefile: Add 'test' and 'test-installed' targets"
as 
  "[PATCHv7.1b 1/4] gitweb: Prepare for splitting gitweb"
  http://article.gmane.org/gmane.comp.version-control.git/160492

But you probably don't have this in 'pu'.

Resolving of conflict is straighforward, but non-trivial, and consist
of two parts:
 * textual conflict caused by adding extra stuff in place where
   context is - simple to resolve
 * adding support for testing installed version of modules, in the
   future if/when we add tests of individual modules (I use this in
   my rewrite of gitweb caching) - non-trivial

>> BTW. this would allow me to improve 'gitweb: Minimal testing of gitweb
>> caching'.
> 
> Then I probably should leave gitweb-caching out of 'next' when gitweb-test
> graduates to master so that you can refresh the caching series.  Thanks
> for a heads-up.

In short: code responsible for turning caching on was duplicated in t9500
and t9502 (will be moved to t/gitweb-lib.sh), and code path with die_error
(e.g. 404 not found case) was not tested. 

I'll try to send re-roll (rebased and improved) tomorrow (on Friday).
-- 
Jakub Narebski
Poland

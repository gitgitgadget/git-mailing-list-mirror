From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD PATCH] revlist/rev-parse: Introduce --heads and --locals revision specifiers
Date: Sat, 1 May 2010 21:51:05 +0200
Message-ID: <201005012151.06609.jnareb@gmail.com>
References: <83fc6259c434cc63f8e64ddf9ac8f90bae0ab2eb.1272557175.git.git@drmicha.warpmail.net> <m3bpczcsup.fsf@localhost.localdomain> <4BDC8565.6050308@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat May 01 21:51:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Iib-0002Rr-2q
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 21:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757488Ab0EATvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 15:51:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:64664 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077Ab0EATvL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 15:51:11 -0400
Received: by fg-out-1718.google.com with SMTP id 19so353584fgg.1
        for <git@vger.kernel.org>; Sat, 01 May 2010 12:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ObOUETaPn07PQaBPq9K1Aq62UXdR6JkTkF23JRROFLs=;
        b=vz0N4+Njl9kKdusyzLdwrnrQ5PJxZ2C4ME0a4aFSsKWi6DB2AojrD6kN2MBO3vdtDR
         yXcF6UJmO2fiLwUs7NRhcvoS+Kjtpm7PXHscsOPVQaP33DHVbhivzkIEPRkVN7/RfPSN
         DKnnkdiVcu1+4O3Y8l2RmPh7rZHgwiLK7UhY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AQYf8Fs21FGTT8JCvGuWNPl2N+u90K6Wd7nsMNDoP1hNGBAyC21VA49E07Ri7RUjvQ
         9aMfYZ1nvIAYLbB03E3J+l66AENmWSDEnjO8sZq0e86O3P8zqVwT4pT/mFWjt19BYLL9
         ZV6UTI6MYjU7io3Fi0S6VWrVP8QLQHSpKNWBE=
Received: by 10.102.15.22 with SMTP id 22mr7413999muo.7.1272743469386;
        Sat, 01 May 2010 12:51:09 -0700 (PDT)
Received: from [192.168.1.13] (abvy46.neoplus.adsl.tpnet.pl [83.8.222.46])
        by mx.google.com with ESMTPS id e10sm14061220muf.38.2010.05.01.12.51.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 May 2010 12:51:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4BDC8565.6050308@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146115>

Michael J Gruber wrote:
> Jakub Narebski venit, vidit, dixit 01.05.2010 21:42:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> 
>>> Due to the increasing usage of the ref namespace (e.g. notes, replace)
>>> the revision specifier "--all" becomes decreasingly useful. But
>>> "something like --all" is ineeded for getting a quick overview of
>>> the development state of a repository.
>>>
>>> Introduce --heads and --locals specifiers in order to help with that:
>>>
>>> --heads == HEAD --branches --remotes
>>> --locals = HEAD --branches --tags
>> 
>> Wouldn't new feature (introduced in 1.7.0) of --glob=<glob-pattern>
>> be enough?
>> 
> 
> You can already use the exact expressions which I wrote above
> ("--branches --tags" etc.). The point is to have short ones for the most
> useful cases.  And "--all" used to be useful.
> 
> It's just that we don't have aliases for rev notation ;)

Ah, sorry, I have misunderstood the goal of your change.

Seems like a good idea.

-- 
Jakub Narebski
Poland

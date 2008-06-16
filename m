From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/WIP/PATCH v2] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Mon, 16 Jun 2008 22:15:05 +0200
Message-ID: <200806162215.05283.jnareb@gmail.com>
References: <200806141447.28052.jnareb@gmail.com> <200806160240.18539.jnareb@gmail.com> <48562DFD.4090108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 22:16:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8L7W-0005UT-S7
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 22:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbYFPUPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 16:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbYFPUPL
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 16:15:11 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:57873 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbYFPUPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 16:15:09 -0400
Received: by py-out-1112.google.com with SMTP id p76so2139983pyb.10
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 13:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=XJBA/JqxVgTA6PWWfmMFrLrgvMcmfucSVoj1cUHllEE=;
        b=o3ZZYaI3XE/2fZi8fOGiGpfv4u5oDVQeumkkooELQAKvMl2yQFKOrrbvxJvWhMn2NT
         xVUDShKrDDUui2SJZrsSNMv5kcaXTqa/aEpVD3bPZDhK/VK18iCbhhv3G9Wtytd47sSX
         kfrRqkFug0uwPUYzxa7j6R8JsVg2krW5sZJW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=h8b64ZflPbAtLjAdc5L842JG+0yJ1eSuIDhz+GGg/XW4ShAY1CbH/cki0yEGejqdto
         Nb7ug1a8eEFU3FvmnzWmblVgTy9rQDnBwwGo6NqJKUhsEPdylSBJvvbbxVphY5UtKQcR
         A8rY7fagQybDCLFt6jA/msBwaiFMgEwCmQrOE=
Received: by 10.115.73.20 with SMTP id a20mr6895202wal.32.1213647308211;
        Mon, 16 Jun 2008 13:15:08 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.236.117])
        by mx.google.com with ESMTPS id m27sm9951422wag.55.2008.06.16.13.15.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 13:15:07 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48562DFD.4090108@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85225>

Lea Wiemann wrote:
> Jakub Narebski wrote:
>> Lea Wiemann wrote:
>>
>> How would you ensure cold cache?
> 
> Use a unique key prefix, like "gw:test-$PID:<key>"

I was thinking rather about dropping cache somewhat.
 
>>> 3. Get all those URL's again *with* caching (from a warm cache), and 
>>> assert that the output is identical.
>> 
>> it might have "cached output" somewhere in the output.
> 
> We can make that deactivatable so that the output is actually identical.

Good idea.  Or we can just do diff and check the difference.

BTW. another thing worth considering: generating "Generating page..."
or something like that like kernel.org's gitweb does when it has to
regenerate cache.  Nice feature, that is.

-- 
Jakub Narebski
Poland

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Potential bug in gitweb 1.7.2
Date: Mon, 26 Jul 2010 15:36:10 +0200
Message-ID: <201007261536.11688.jnareb@gmail.com>
References: <4C4D152A.7050505@gmail.com> <alpine.DEB.2.00.1007260508290.14251@dr-wily.mit.edu> <4C4D8940.80802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Anders Kaseorg <andersk@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: julio.lajara@alum.rpi.edu
X-From: git-owner@vger.kernel.org Mon Jul 26 15:36:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdNr7-0008CK-0a
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 15:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614Ab0GZNgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 09:36:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37715 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab0GZNgV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 09:36:21 -0400
Received: by fxm14 with SMTP id 14so96026fxm.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 06:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=AXEZk5J5txBVO66uLeMTnwZvLWlCdjntuwYmOI+TWcs=;
        b=o/JZM9mGg370WYiADb4bCWqf5swKtqAwAIDk/YzVa0uPGFay2vsDjeI042RBWumTbV
         8PWST1bYU5sQGKNO85nyUzosEfmhl8Q9U0Fwnx94Ko35M/NO3IjPVw4WVgOBq6imJ2eP
         +jJSStZnRxJL/tTSPMkBcQFqGxZihK/3fkehI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=shc0JhHpq3CawCxrHRULKdwMb+zsDV6qlS1KzKf/uUR1cs+cX8Jlwg13aiNIZst2j5
         2X4RcYpHp0EkDYarAxGHfui3dH99pNNs8mpBaN0SwT/EoL+Du6q9eHRtYg9KGsZQKGhx
         fpxRXWilg5gJpVh50MFG5YKX0jyyzlIMZ1Kh8=
Received: by 10.223.111.206 with SMTP id t14mr6439059fap.32.1280151379883;
        Mon, 26 Jul 2010 06:36:19 -0700 (PDT)
Received: from [192.168.1.13] (abvc184.neoplus.adsl.tpnet.pl [83.8.200.184])
        by mx.google.com with ESMTPS id l19sm1385761fap.9.2010.07.26.06.36.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 06:36:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4C4D8940.80802@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151836>

On Mon, 26 Jul 2010, Julio Lajara wrote:

> Hi Anders, thanks for the input. I will begin chasing down the issue in 
> my config then, but its strange that it would stop working as the exact 
> same configuration works without issue in 1.7.0.4 . Ill follow up with 
> what I find.
> 
> On 07/26/2010 05:27 AM, Anders Kaseorg wrote:

>> The error that Julio originally posted:
>>
>>    
>>>> [Sat Jul 24 23:11:41 2010] [error] [client 192.168.1.100] Can't call
>>>> method "http" on an undefined value at /usr/share/gitweb/index.cgi
>>>> line 3401., referer: http://192.168.1.142/gitweb/
>>        
>> looks very strange, and does not seem like it would result from just a
>> packaging problem.

Julio, could you show us the neigbourhood of line 3401 in your index.cgi
file?  What is this index.cgi file - git doesn't have it?

-- 
Jakub Narebski
Poland

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: (Re: gitweb not friendly to firefox?) and unusable in the lynx
Date: Sat, 3 Mar 2007 04:58:58 +0100
Message-ID: <200703030458.58616.jnareb@gmail.com>
References: <989B956029373F45A0B8AF02970818902DA81B@zch01exm26.fsl.freescale.net> <200703030441.36627.jnareb@gmail.com> <alpine.LRH.0.82.0703022242570.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Mar 03 04:57:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNLMg-00079E-NP
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 04:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992939AbXCCD4j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 22:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992940AbXCCD4j
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 22:56:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:32798 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992939AbXCCD4i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 22:56:38 -0500
Received: by ug-out-1314.google.com with SMTP id 44so873769uga
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 19:56:37 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=c2XBgGULWuR2SUXb6QByBAxxR1d4SOCgxjVBtbTnV2GQQ5SA40m7hYEbOwy1nALJ7V9ebn7RmqVQg6yE4IxayLPFnEG9Me/U3wD88YBrG6f7t2+p+/cspPX/jBKxtpBs/ZGSQOGM5L3Ebt8YjzbEiG9p+SbengSd6Tn250vKeOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=a8+49gvnv/WuiItem6rYbpjeyPACNT3HsmDkd+nWtLKrBsZo0M2AGdzCDrbRPq3Tim+aDMi0wrmAfbCUNN6NCap1Ak6zgTIaBVD5HevzLe3zcoDWLRszBicKUckmwjyBO2c6EqdNYsYZGoF2wVQFkUhc0VHcPWio/0H1ltGvoSw=
Received: by 10.67.93.6 with SMTP id v6mr4462156ugl.1172894197329;
        Fri, 02 Mar 2007 19:56:37 -0800 (PST)
Received: from host-81-190-30-210.torun.mm.pl ( [81.190.30.210])
        by mx.google.com with ESMTP id j2sm15090840mue.2007.03.02.19.56.35;
        Fri, 02 Mar 2007 19:56:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LRH.0.82.0703022242570.29426@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41271>

[some Cc dropped]

Nicolas Pitre wrote:
> On Sat, 3 Mar 2007, Jakub Narebski wrote:
>> Nicolas Pitre wrote:
>>> On Sat, 3 Mar 2007, Jakub Narebski wrote:
>>> 
>>>> By "conservatively" it means that it uses 'application/xhtml+xml' only when
>>>> client explicitly claims that it accepts its, and it is not due to for
>>>> example */* accept globbing.
>>>> 
>>>> So if lynx isn't working, it is its damn fault...
>>> 
>>> I absolutely don't care.
>>> 
>>> I use lynx, and lynx worked perfectly fine before.  So it is not lynx 
>>> that broke it.  Please fix gitweb.
>> 
>> WORKSFORME.
>> 
>> Lynx Version 2.8.5rel.1 (04 Feb 2004)
>> libwww-FM 2.14, SSL-MM 1.4.1, OpenSSL 0.9.7f
>> 
>> git web interface version 1.5.0.rc3.gc0bbd
>> 
>> (and application/xhtml+xml is _not_ among Accept's).
> 
> This is Lynx 2.8.5rel.1 (04 Feb 2004) on Fedora Core 6:
> 
> $ lynx http://www.kernel.org/git
> [...]
> application/xhtml+xml  D)ownload, or C)ancel

$ lynx http://www.kernel.org/git
[...]
#                                                          Kernel.org - Git Repo (p1 of 26)

   #Kernel.org - Git Repo projects list Kernel.org - Git Repo projects feeds
[...]

Could you check if "application/xhtml+xml" is in "Accept:"
HTTP Request Header sent by _your_ lynx, e.g. as seen via
  http://web-sniffer.net/?url=http://www.kernel.org/git

-- 
Jakub Narebski
Poland

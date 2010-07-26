From: Julio Lajara <ju2wheels@gmail.com>
Subject: Re: Potential bug in gitweb 1.7.2
Date: Mon, 26 Jul 2010 09:10:24 -0400
Message-ID: <4C4D8940.80802@gmail.com>
References: <4C4D152A.7050505@gmail.com> <20100726050849.GA16858@burratino> <alpine.DEB.2.00.1007260508290.14251@dr-wily.mit.edu>
Reply-To: julio.lajara@alum.rpi.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Jul 26 15:10:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdNRw-0003rv-7M
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 15:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144Ab0GZNK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 09:10:27 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:48013 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789Ab0GZNK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 09:10:26 -0400
Received: by qyk8 with SMTP id 8so1898394qyk.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=4UUqIQRbejVlMl277qvDnIwMM+DOyEpN4wlVFnLOBVA=;
        b=HsDIzlKAQ18/jHditNpLlbdyYJXtH5PynBLzxTLLae6i1YaspHp8jAj5u6sI6ILiT/
         htZNlDV/z7G2NenU8L9umvuM3/IyHeTYUVYc3BD82r8nQw+AoxoWmf99qX6A6wXuThR9
         PlxplhZwkF73q14CmxglySeKuTHf7k5CX2KIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=gDI+m538+91tidXhWHDLY+h+cASHVnx6C/8uch3l5CLkTAjVh1S2sA5gdQy5KBLfck
         N8TXvdKiktmQ1Oq5z/uh0yFrp/fNH5xDvY36WBF34kPCIcPdU3aO2WyT4uv/+YBo3vzk
         GyL3Z+KRyh5bwXm7/+NH8KFlNQcIsuJdG2dFk=
Received: by 10.224.96.155 with SMTP id h27mr6290115qan.280.1280149825914;
        Mon, 26 Jul 2010 06:10:25 -0700 (PDT)
Received: from [192.168.1.142] (c-76-28-16-43.hsd1.ct.comcast.net [76.28.16.43])
        by mx.google.com with ESMTPS id e32sm4082889qcg.34.2010.07.26.06.10.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 06:10:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100528 Thunderbird/3.0.5
In-Reply-To: <alpine.DEB.2.00.1007260508290.14251@dr-wily.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151833>

Hi Anders, thanks for the input. I will begin chasing down the issue in 
my config then, but its strange that it would stop working as the exact 
same configuration works without issue in 1.7.0.4 . Ill follow up with 
what I find.

Thanks,

On 07/26/2010 05:27 AM, Anders Kaseorg wrote:
> On Mon, 26 Jul 2010, Jonathan Nieder wrote:
>    
>> Indeed, the rules for installation have changed with v1.7.2, so the
>> packaging may need to be adjusted[1] to match (see gitweb/INSTALL).
>> Please report this to the Ubuntu git team.
>>
>> [1] e.g. http://repo.or.cz/w/debian-git/jrn.git/commit/ff41c31c5
>>      
> Thanks for the report.  But, the 1.7.2-0ppa1 package in the git-core PPA
> was constructed by merging your jrn/for-gerrit branch (1.7.2~rc3-0.1,
> commit f84e1eb) with upstream v1.7.2, and updating
> debian/versions.upstream and debian/changelog.upstream.  It already
> includes that commit.
>
> Indeed, when I install the gitweb 1.7.2-0ppa1 package, put some
> repositories into /var/cache/git, and go to http://localhost/gitweb/ , it
> works correctly for me.
>
> The error that Julio originally posted:
>
>    
>>> [Sat Jul 24 23:11:41 2010] [error] [client 192.168.1.100] Can't call
>>> method "http" on an undefined value at /usr/share/gitweb/index.cgi
>>> line 3401., referer: http://192.168.1.142/gitweb/
>>>        
> looks very strange, and does not seem like it would result from just a
> packaging problem.
>
> Anders
>
>    

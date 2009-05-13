From: Ittay Dror <ittay.dror@gmail.com>
Subject: Re: switching upstream tips
Date: Wed, 13 May 2009 11:07:22 +0300
Message-ID: <4A0A7FBA.1010606@gmail.com>
References: <4A0A6BD1.7050907@gmail.com>	 <81b0412b0905130019x114d53d1v86833217bff613bc@mail.gmail.com>	 <4A0A777E.7080506@gmail.com> <81b0412b0905130041t327ef5f2m3b6d1dfac51fc1b1@mail.gmail.com> <4A0A7BA1.4030500@gmail.com> <4A0A7D5E.1010909@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 13 10:07:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M49VB-0007X5-E4
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 10:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932AbZEMIHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 04:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbZEMIHg
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 04:07:36 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:36637 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbZEMIHd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 04:07:33 -0400
Received: by yx-out-2324.google.com with SMTP id 3so266910yxj.1
        for <git@vger.kernel.org>; Wed, 13 May 2009 01:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=VWrsrhHFojGW87heSlbceKvNegkPK+DB/uCwggilMU4=;
        b=ZqbTu795zED7t+6o5r8bf/kn5vVJAr9BbxbVmPkkC6yueQKM2FGebhjgGAIGnQgaFy
         PFjzI/K32qalrtyq1WhOcOujVI+qMD5nNoICjyu0y9ke5lvcWV0MsciE8oUwFuuCgVrI
         s5nH5jw/UtRLn+b6kXR3q6G+Q0L0XTq1hyjWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=N2UIYks4GWVMX7IiV6woZjIJwjE0W4hSNWolgEr28hUKkos/oZ1sqoP5PHleQ+2cRV
         PZarNYuu3oANmfuEA6bspfeUXhtefsgUcYeIAW89urZe7cbAlJhxTEaPvcBLYTCFKR3A
         L3DcHV7f/5Ene4k6JO+RnMMR78JRGBe4Bjjdk=
Received: by 10.100.105.15 with SMTP id d15mr527520anc.140.1242202054322;
        Wed, 13 May 2009 01:07:34 -0700 (PDT)
Received: from ?10.10.2.8? ([212.143.191.180])
        by mx.google.com with ESMTPS id 4sm2815426yxd.24.2009.05.13.01.07.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 01:07:33 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <4A0A7D5E.1010909@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118999>



Johannes Sixt wrote:

> Ittay Dror schrieb:
>   
>> Alex Riesen wrote:
>>     
>>> 2009/5/13 Ittay Dror <ittay.dror@gmail.com>:
>>>       
>>>>> Alex Riesen wrote:
>>>>>           
>>>>>> * Reorder my history so that my commits are on top of the tip of
>>>>>> the old
>>>>>> upstream repository.
>>>>>>         
>>>>>>             
>>>>> Look at "git rebase -i" (interactive rebase)
>>>>>       
>>>>>           
>>>> well, i was hoping for something more automatic. git rebase will list
>>>> all
>>>> commits without author, so i'll have to manually figure which of them is
>>>> mine from the commend and reorder
>>>>     
>>>>         
>>> git rebase will list only commits not on upstream (simplified).
>>> Has nothing to do with author being absent.
>>>   
>>>       
>> tried git rebase, this is what i get:
>>     
>>> git rebase -i upstream master
>>>       
>> fatal: Needed a single revision
>> Invalid base
>>     
>
> I guess it should have been
>
>    git rebase -i --onto new-upstream old-upstream master
>
> That is, you take commits old-upstream..master and transplant them onto
> new-upstream.
>   
same thing:
 > git rebase -i --onto upstream old-upstream master
fatal: Needed a single revision
Does not point to a valid commit: upstream

> -- Hannes
>
>   

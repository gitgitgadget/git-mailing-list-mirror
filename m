From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH] defaults for where to merge from (take 3)
Date: Thu, 01 Mar 2007 11:17:28 +0100
Message-ID: <45E6A838.60605@lu.unisi.ch>
References: <es450f$d58$1@sea.gmane.org>	 <Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de>	 <81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com>	 <45E68897.8000607@lu.unisi.ch>	 <81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com>	 <45E68EDE.2090405@lu.unisi.ch>	 <81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com>	 <45E69297.8070001@lu.unisi.ch>	 <81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com>	 <45E69EEE.8070905@lu.unisi.ch> <81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 11:17:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMiM1-0007YT-UU
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 11:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbXCAKRi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 05:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbXCAKRi
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 05:17:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:52263 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964869AbXCAKRg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 05:17:36 -0500
Received: by nf-out-0910.google.com with SMTP id o25so845897nfa
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 02:17:35 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=nFiYSemQG0HiRMlf84Bldv3pl907PvyMIfvZdrtIZTRhZ+LNAZiTyTfU2yUzwmTJqUm+Lqd0zZh4MdaWgkigli3M+FhdbFj4DcYBP/XuujNfFIOVkdOPZqA5rsUKs2OvzGDzLvkjjA8RysuoQ/0EG4f6L7fW/SmCtOfHW+Q9BEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=upSsR5sq2o2rEVz5DN3W6ZxbsyFaSXT9qgBSTk1D0CyynEFhN62OSU454hAJJJbqQYJ47WbZejrxc/JzHJgbyi39YfrGZR/9/PDRp4y4uE9NVaFnF0oXKgoUp6wwwyFTqprMGU2LOL4VQiziXObo42zxt9K8E/WgkVs88BGw3K0=
Received: by 10.49.29.3 with SMTP id g3mr5268110nfj.1172744255462;
        Thu, 01 Mar 2007 02:17:35 -0800 (PST)
Received: from ?192.168.76.141? ( [195.176.176.226])
        by mx.google.com with ESMTP id e8sm6557711muf.2007.03.01.02.17.31;
        Thu, 01 Mar 2007 02:17:32 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
In-Reply-To: <81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41075>


>> Patch attached.  --remove-section will go in a separate patch.
> 
> Still think it is a very dangerous operation.

Agreed, that's why I put it in git-config.

Paolo

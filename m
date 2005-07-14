From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: Re: [PATCH] stgit: allow spaces in filenames
Date: Thu, 14 Jul 2005 03:22:35 -0400
Message-ID: <42D612BB.5040400@gmail.com>
References: <20050713083805.18461.87079.sendpatchset@bryan-larsens-ibook-g4.local>	 <tnxll4bdn7b.fsf@arm.com>  <42D55AC9.4000506@gmail.com> <1121290004.6876.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 09:23:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dsy3f-0005aS-To
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 09:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbVGNHWt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 03:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbVGNHWt
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 03:22:49 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:18673 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262925AbVGNHWf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2005 03:22:35 -0400
Received: by zproxy.gmail.com with SMTP id m7so197973nzf
        for <git@vger.kernel.org>; Thu, 14 Jul 2005 00:22:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Wwvd9Op6sMDHWn0/7hyKS+zDxL35o1nmg7hvpbxQp8nc79ShzsJ/10701xWvapeUAfOppL3ySYhhqDuU2QQQmelfPfz1wbrODS7M4sp1YuOXzVdglfLuRFF0lvsT2u3iJEPNJblvhn2oG7TTAS3vTTNRpACJprEXLJjAe7qAZGI=
Received: by 10.36.90.8 with SMTP id n8mr120503nzb;
        Thu, 14 Jul 2005 00:22:34 -0700 (PDT)
Received: from ?192.168.2.80? ([69.159.204.165])
        by mx.gmail.com with ESMTP id 19sm1729286nzp.2005.07.14.00.22.34;
        Thu, 14 Jul 2005 00:22:34 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <1121290004.6876.11.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


> Does it make that big difference if the commands are invoked via the
> shell? I haven't run any tests.
> 

It wasn't for the time difference that I bypassed the shell, it was to 
support spaces and other strange characters  in parameters.  It's easy 
to use spawnvp than it is to escape the parameters properly.

Bryan

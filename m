From: Frank Li <lznuaa@gmail.com>
Subject: Re: possible code error at run_command.c
Date: Mon, 21 Dec 2009 17:13:19 +0800
Message-ID: <1976ea660912210113k6a8b05abwf86a0ea4f74aa997@mail.gmail.com>
References: <1976ea660912202246k45732bf2p111bbeb78047693e@mail.gmail.com>
	 <4B2F214D.2020905@viscovery.net>
	 <1976ea660912202329x42f6add3j9175867e8723a4bd@mail.gmail.com>
	 <4B2F2727.4060405@viscovery.net>
	 <1976ea660912210018y15acfe32o78841d5e0968f793@mail.gmail.com>
	 <4B2F320A.6010908@viscovery.net>
	 <40aa078e0912210041g1fd94c77g6cf9f1b236b6ecd7@mail.gmail.com>
	 <4B2F3732.6030903@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: kusmabite@gmail.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 21 10:13:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMeKU-0000EK-Aq
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 10:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354AbZLUJNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 04:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593AbZLUJNV
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 04:13:21 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:51747 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781AbZLUJNU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 04:13:20 -0500
Received: by yxe17 with SMTP id 17so4671664yxe.33
        for <git@vger.kernel.org>; Mon, 21 Dec 2009 01:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=lSS81h/fQFriQNb9YIOHxQ7kFxmn+m+Uh1S0TsyR1mI=;
        b=vvKB+zzuhUGmSWcosWAYZ8gGJUc1EdeL/1fhRRf5EtyLMjd3pOTxcqsQ51uoG2zd+V
         kwTK4QG1ydrbvYr3gGwxihaGencn/eGg6d7hMt29uA6GaBNsmD3siuB1m9uzcenUkUET
         YUz9lZkAULugPc5ZpLypy+57zuCfoVZkcU7t4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=sl5lXaXwXNuN1b/zgTuODpXNJqC0Faufq9bkddOlDXmpKDwzi1mJhdvoH/8ZnR6Jn5
         Q4T+A/AOB8d3SujyPASrhHBBjGrq+fGKEh5B9u+CiHrYOOI0ZaqP22sr9S8sfviJPnF5
         1KF/qdFYcShavwCuMQIEvWW6nNYtF/i8oYM5A=
Received: by 10.150.78.1 with SMTP id a1mr10914470ybb.39.1261386799919; Mon, 
	21 Dec 2009 01:13:19 -0800 (PST)
In-Reply-To: <4B2F3732.6030903@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135552>

> This line will trigger the check. It initializes failed_errno with itself,
> which is still uninitialized at this time.
>
I see.
I always use release version at finial production.
This is not important. I read code again. There are not path.
Thank you take care.

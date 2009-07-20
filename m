From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 2/3] push: add --current
Date: Mon, 20 Jul 2009 13:50:53 +0200
Message-ID: <4A645A1D.8010401@gnu.org>
References: <1248071820-18289-1-git-send-email-bonzini@gnu.org>	 <1248071820-18289-3-git-send-email-bonzini@gnu.org> <be6fef0d0907200315j14089edcv8baa997d2ec34f3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 13:51:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSrOe-00018j-Mg
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 13:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbZGTLu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 07:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbZGTLu6
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 07:50:58 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:49216 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbZGTLu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 07:50:58 -0400
Received: by fxm18 with SMTP id 18so1908847fxm.37
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 04:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=oFsmMOngMqe26Y3mL4nthTPxA1lS0BXd7etDg7zZTIE=;
        b=Aytg+L0HESoxWNMPzUW+m6FnOHbaNhGTxUZknbMUDdo/G3/6EBTIFkIZbkmQSpyClD
         HWnxhk6KwjBLCgo/+gGZ/Ct/XbGpmetfebWac/jcfMX15vBoiQ2jJjqNh5BUD6r10I6J
         Pf2TCjaSDfiI5NLsCWAsGk7DNdMDnNC52BHMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=OqJ2TiYeT3Tb7SsTP2VNEJxb0hLdgfpJPAIq2XAgpakrZG0s5HRogQ7b9G99h/QEje
         uiYIOVkK8RBWQKv0zVumj/gfkXcwzVGWjQwjJTV6ipgmYgwDDfogLbBY/KqV8AEV8DFT
         r3BtybT3BxJr4P8xp1NKaVtc62mhaIEhykE7w=
Received: by 10.86.61.9 with SMTP id j9mr3607298fga.39.1248090656637;
        Mon, 20 Jul 2009 04:50:56 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id d4sm4412782fga.7.2009.07.20.04.50.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Jul 2009 04:50:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
In-Reply-To: <be6fef0d0907200315j14089edcv8baa997d2ec34f3f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123589>

On 07/20/2009 12:15 PM, Tay Ray Chuan wrote:
> Hi,
>
> On Mon, Jul 20, 2009 at 2:36 PM, Paolo Bonzini<bonzini@gnu.org>  wrote:
>>   t/t5516-fetch-push.sh      |   50 ++++++++++++++++++++++++++++++++++++++++++++
>
> since you're making modifications to pushing over HTTP, you should
> consider making tests also for HTTP repositories, or else your changes
> in http-push.c won't be used.

Yeah, I had tested them with a server I already had setup rather than 
with the testsuite, because the default Apache setup of Fedora is not 
detected correctly by lib-httpd.sh.  Any test I included would then be 
untested, while http-push.c was tested. :-)

However, I'll include the tests in v3 of the patch.

Paolo

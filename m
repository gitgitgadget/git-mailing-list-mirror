From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: Re: [PATCH] stgit: allow spaces in filenames
Date: Wed, 13 Jul 2005 14:17:45 -0400
Message-ID: <42D55AC9.4000506@gmail.com>
References: <20050713083805.18461.87079.sendpatchset@bryan-larsens-ibook-g4.local> <tnxll4bdn7b.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 20:20:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DslpN-0002hZ-OC
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 20:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVGMSTI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 14:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVGMSSy
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 14:18:54 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:25058 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261318AbVGMSRs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2005 14:17:48 -0400
Received: by zproxy.gmail.com with SMTP id x7so136219nzc
        for <git@vger.kernel.org>; Wed, 13 Jul 2005 11:17:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=PYXdOFMN1jXr7rtfA3hRCffuukKy6ry2q/0RtrTSEbAQBnN3Rbc6piBcfYCTpi82+0N19m7ZjHYQ/JdVABHoN1cQoNAXD9ashcCHu9XndUKQO3A8mRLjRu+hVSJHLRLI9kLU8+7ZlaJRYNvfduyFy3oUtgoCwwsBA3gB0AOQ5VE=
Received: by 10.36.22.13 with SMTP id 13mr1181549nzv;
        Wed, 13 Jul 2005 11:17:46 -0700 (PDT)
Received: from ?192.168.2.80? ([69.159.204.165])
        by mx.gmail.com with ESMTP id 16sm1266137nzo.2005.07.13.11.17.45;
        Wed, 13 Jul 2005 11:17:46 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <tnxll4bdn7b.fsf@arm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas wrote:
> An additional thing, can you please convert all the tabs to spaces?
> That's a better convention for a language like Python where you
> delimit blocks by indentation.

I would have hoped that emacs py-mode would "do the right thing". 
Anybody know how to make it do what Catalin wants?

> 
> 
>>+        fin, fout = os.popen2(['git-ls-files', '--others',
> 
> 
> What's the reason for having 'fin' as well? It doesn't seem to be used
> (this is found in other parts of the patch as well).

popen does not support bypassing the shell by using vectors of 
arguments.  Only popen2 and friends have this capability.

Unfortunate, yes.

> 
> I'm not sure whether the GIT guys are happy for us to use this mailing
> list for StGIT. If the StGIT traffic increases, I will try to create a
> separate mailing list (maybe using a site like sf.net).
> 

I'd very much like to stay on the same list.  By the same logic, cogito 
should have it's own list as well...

Bryan

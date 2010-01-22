From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/2] Allow to override mergetool.prompt with
	$GIT_MERGETOOL*_PROMPT
Date: Thu, 21 Jan 2010 17:58:02 -0800
Message-ID: <20100122015802.GA20620@gmail.com>
References: <4B572192.2020606@gmail.com> <20100121074427.GA26973@gmail.com> <4B582807.8070504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 02:58:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY8mz-0004VE-1U
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 02:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755667Ab0AVB6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 20:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755585Ab0AVB6L
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 20:58:11 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:52385 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818Ab0AVB6J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 20:58:09 -0500
Received: by yxe17 with SMTP id 17so622331yxe.33
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 17:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uqiTDq3KAOkVX95gvFAlV5kay2ZFE5O3AwzgX33QFsI=;
        b=oI9Hql+Kv9u5JGb/DeTigLjC8PFJm5XpJ7M+FTCWrcB5d9fBEiQDNeC4PAsvdPKON1
         A33N8KbmcxRNNpfPHG/GkdxeekzQWBCjIrxOAWmtNjbShO17drXItnnnRtKJ6nzsw8Jb
         Vtm6N3aN95YyM0d4wq2iFFtn69y5cJKdAZ2u8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kVCNWkV/YUbHwRDu5QPgDXMawWq2sm5OIrUfP3UhQxCUiTJTCEdEB7Fdv28OObdyv/
         3c49WwPbndRDwdeasoUKx3hczmFhoOnPcny8bPvXmKbFNrv6QXHU3jR6zfq3T8A84eUg
         5urjL4FGHLE9K46iN/6mz+PHJDP864i3w/nTM=
Received: by 10.101.82.19 with SMTP id j19mr3121534anl.44.1264125488390;
        Thu, 21 Jan 2010 17:58:08 -0800 (PST)
Received: from gmail.com (wdas-1.disneyanimation.com [198.187.190.1])
        by mx.google.com with ESMTPS id 8sm617883ywg.19.2010.01.21.17.58.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Jan 2010 17:58:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B582807.8070504@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137715>

On Thu, Jan 21, 2010 at 11:10:15AM +0100, Sebastian Schuberth wrote:
> On 21.01.2010 08:44, David Aguilar wrote:
>
>> The GIT_DIFFTOOL*_PROMPT variables are implementation details
>> about how git-difftool passes options to git-difftool--helper.
>> We don't advertise them in the documentation so we probably
>> shouldn't support them aside from what is needed for
>> git-difftool.  We can drop this part.
>
> Thanks for the explanation, I already was wondering why they don't  
> appear in the docs.
>
>> git-difftool falling back to mergetool.prompt when
>> difftool.prompt is not available is good, especially
>> since we advertise that feature.
>>
>> Once you drop the local declarations and the env. variable
>> it should be good to go.  Patch v2, soon?
>
> If I drop env. variable support, I don't see much reason to introduce  
> the should_prompt_merge () at all. I'd then leave git-mergetool* as-is,  
> and directly run "git config --bool mergetool.prompt" inside  
> should_prompt_diff (). Would that be OK with you?
>
> -- 
> Sebastian Schuberth

Sounds good.

Thanks,

-- 
		David

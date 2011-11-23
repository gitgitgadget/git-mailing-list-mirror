From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: Git ticket / issue tracking ERA: Git shouldn't allow to push a
 new branch called HEAD
Date: Wed, 23 Nov 2011 22:30:50 +0100
Message-ID: <op.v5e4podr0aolir@keputer.lokaal>
References: <1321970646.3289.19.camel@mastroc3.mobc3.local>
 <7vd3ckdjx9.fsf@alter.siamese.dyndns.org>
 <CAHVLzc=SPD+AHhAPP_=mEVv5cJvn0oiJ_k-KBEkG=Qhcw2UxHA@mail.gmail.com>
 <CAH6sp9OXzHj=r707zyRQxaJmndHm5_DcWWMLn_1zyLdEZ_TSbA@mail.gmail.com>
 <7v4nxudb73.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	"Daniele Segato" <daniele.bilug@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Jeff King" <peff@peff.net>, "Scott Chacon" <schacon@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 22:31:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTKPC-0008Qo-85
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 22:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879Ab1KWVay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 16:30:54 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52964 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755346Ab1KWVax (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 16:30:53 -0500
Received: by wwp14 with SMTP id 14so457650wwp.1
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 13:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=nLMJaVRzoMeaS4Ot9PutcDv+DNN6RZUb8G6YHSvD3OQ=;
        b=w3I0Jti+1fBUt/+228eyrcgHYA9smbrkV+1HlDZB590ZHapfRdGzbDhS3rFVaWlYAi
         nC2kCgxJACLYhOy1syu9UMxW9DFybJDkck2jOx0Wg92X5KUdKkoCD3Ck5HvIz+X9p+x+
         bHVJLqBmwU5PLCkhsXa6ty47MwgnZAbMzzqKY=
Received: by 10.216.185.85 with SMTP id t63mr3923839wem.7.1322083852239;
        Wed, 23 Nov 2011 13:30:52 -0800 (PST)
Received: from keputer.lokaal (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id bl10sm8645136wib.15.2011.11.23.13.30.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Nov 2011 13:30:51 -0800 (PST)
In-Reply-To: <7v4nxudb73.fsf@alter.siamese.dyndns.org>
User-Agent: Opera Mail/12.00 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185877>

On Wed, 23 Nov 2011 18:02:08 +0100, Junio C Hamano <gitster@pobox.com>  
wrote:

> Frans Klaver <fransklaver@gmail.com> writes:
>
>> The note from the maintainer[1] mentions
>>
>> 	git://git.kernel.org/pub/scm/git/git.git/
>> 	git://repo.or.cz/alt-git.git
>> 	https://github.com/git/git
>> 	https://code.google.com/p/git-core/
>>
>> I would assume one of those would be a nomination for 'official' repo.
>>
>> Maybe something for Scott C. to address?
>
> As long as the link says "Git source repository" without "the official",
> Scott is doing the right thing. It is just one of the copies that I push
> into, so it may be considered more official than a fork of my history by  
> a
> random unknown person.
>
> As Git is distributed, we do not need a single "official" repository. If
> you really want to name one, my private working repository at my home
> machine would be what is closest to one, as patches and pull requests are
> processed there and then the result is pushed out to the above four and a
> few others. But that "official" one is not exposed to the outside world  
> ;-)

Since official is a rather unreal term here, let's just drop it. There are  
a few repositories that the maintainer currently pushes to, and those are  
the most reliable ones to use if you want the latest git vanilla. Other  
than that, there's going to be no difference from the next git.git clone.

It might remove some confusion if these repos would be reflected on  
websites focusing on git as they are in the maintainers notes, but that's  
probably up to the respective webmasters then.

Frans

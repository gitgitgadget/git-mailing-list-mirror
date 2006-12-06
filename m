X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git UI nit
Date: Wed, 6 Dec 2006 17:23:23 +0100
Message-ID: <200612061723.23515.jnareb@gmail.com>
References: <el6jmt$mej$1@sea.gmane.org> <el6nul$58n$2@sea.gmane.org> <4576EA02.2010809@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 16:21:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tZscLL8L60NhMzY7VamMZpzltDnqDi3h/Ty9VN5UH+vJ5c0RMNsPnX0AsHvdDke23y0B+/I9nxXm7wT2CacmyU8CaxhnArgQa/7GbmIag/t7E+2ZNYQpZL98smj+icVnGvA3/FCcq+RrmOu8pAb8R7j4mB6y0ISae35Yspi+OFg=
User-Agent: KMail/1.9.3
In-Reply-To: <4576EA02.2010809@xs4all.nl>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33484>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrzWR-0003bx-9U for gcvg-git@gmane.org; Wed, 06 Dec
 2006 17:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936296AbWLFQVY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 11:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936325AbWLFQVY
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 11:21:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:7899 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S936296AbWLFQVX (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 11:21:23 -0500
Received: by ug-out-1314.google.com with SMTP id 44so189460uga for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 08:21:22 -0800 (PST)
Received: by 10.67.93.6 with SMTP id v6mr1068749ugl.1165422081865; Wed, 06
 Dec 2006 08:21:21 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id l33sm30378504ugc.2006.12.06.08.21.21; Wed, 06 Dec
 2006 08:21:21 -0800 (PST)
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote:
> Jakub Narebski escreveu:
>> Johannes Schindelin wrote:
>> 
>>> On Wed, 6 Dec 2006, Han-Wen Nienhuys wrote:
>>>
>>>> Johannes Schindelin escreveu:
>>>>>                     }
>>>>>                     if (quiet)
>>>>>                             continue;
>>>>> -                   printf("%s: needs update\n", ce->name);
>>>>> +                   printf("%s: dirty; needs commit\n", ce->name);
>>>> Yes - I'd just mention revert as an option too. 
>>> Actually, I like it that short.
>> 
>> So why not simply use "%s: dirty\n"?
> 
> because a newbie doesn't know how to resolve that problem.

But there are [at least] two ways to resolve this:
commit or revert (reset).

-- 
Jakub Narebski

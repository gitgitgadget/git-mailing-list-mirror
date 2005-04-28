From: Tejun Heo <htejun@gmail.com>
Subject: Re: [ANNOUNCE] gitkdiff 0.1
Date: Thu, 28 Apr 2005 20:01:11 +0900
Message-ID: <4270C277.4000303@gmail.com>
References: <4270711F.7020501@gmail.com> <20050428103655.GA14076@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 12:57:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR6hQ-000253-F2
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 12:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVD1LBz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 07:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVD1LBz
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 07:01:55 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:36441 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262012AbVD1LBV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 07:01:21 -0400
Received: by rproxy.gmail.com with SMTP id j1so326391rnf
        for <git@vger.kernel.org>; Thu, 28 Apr 2005 04:01:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=oyVK6S+xC0/z+OT45vqRq5sECaO2H+UwWy8f9rV5xUafJoh5edQq0j2qYEk03DWFcU/WbcJ5wYAZHsfX8NK/7QZ6SLTljZarKTDmwPGZgvjwhH5UGbNPF+sxoM++dXXDUiTuhDM5LlQZxqEKknFmdS6DI5L9FZ27vr8iYTyVUOY=
Received: by 10.38.88.70 with SMTP id l70mr2325004rnb;
        Thu, 28 Apr 2005 04:01:16 -0700 (PDT)
Received: from htj.dyndns.org ([222.97.233.99])
        by mx.gmail.com with ESMTP id 64sm985206rna.2005.04.28.04.01.15;
        Thu, 28 Apr 2005 04:01:16 -0700 (PDT)
Received: from [127.0.0.1] (htj.dyndns.org [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by htj.dyndns.org (Postfix) with ESMTP id 1FB2D1843E0;
	Thu, 28 Apr 2005 20:01:12 +0900 (KST)
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050428103655.GA14076@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ingo Molnar wrote:
> * Tejun Heo <htejun@gmail.com> wrote:
> 
> 
>> Hello, guys.
>>
>> I've hacked tkdiff and made a commit viewing utility.  Just download
>>the following tarball and unpack it whereever PATH points to.  It
>>assumes that all base git executables are visible via PATH.
>>
>> http://home-tj.org/gitui/files/gitui-200504281405.tar.gz
> 
> 
> very nice!
> 
> there's only one other utility i'm missing: a tool that does the 
> equivalent of 'bk annotate' - and to possibly integrate it with gitkdiff 
> and git-viz. That would make 'history browsing' very powerful: to 
> flexibly switch between changeset history graph view, annotated file 
> view and changeset history within one utility.
> 
> 	Ingo

  Actually, I am thinking about making a full gui history thing.  With 
commit history graph, annoatated file history and all those stuff (I 
think it will look a lot like bk revtool).  Can't say how long it will 
take but maybe in a week.  So, if you have some ideas/suggestions, 
please let me know.

-- 
tejun

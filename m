From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v2 00/14] Improve git-status --ignored
Date: Mon, 15 Apr 2013 22:06:23 +0200
Message-ID: <516C5DBF.1010102@gmail.com>
References: <514778E4.1040607@gmail.com> <516C4F27.30203@gmail.com> <7v1uabsin7.fsf@alter.siamese.dyndns.org> <7vwqs3r3m4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 22:06:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URpfn-0003aH-1u
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 22:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906Ab3DOUG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 16:06:27 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:62729 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599Ab3DOUG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 16:06:26 -0400
Received: by mail-ea0-f180.google.com with SMTP id d10so2340552eaj.11
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=k2sEkWLKEchnr9hmttWQ5o23hy/yReM7EdM8HXUAshc=;
        b=EBgvnxcZpFkUloZ/RmfbxrSTnDJBUhPM4+6xBlXNo4l1ko3/rmFUg/aJOwlhd5lBmr
         nJE4gqsCyPvtNgQWqVwO5LsjcoXGmruM2Vv5/Yww5RAvXdEQx2J0evmmLf5JBCyLAd+R
         5OkAUi+FGT0CjSCCHDoI3xBWO5RrMGtpLaqwd7nY5E5sashwWCFUoqhYNguzr/S7kTuJ
         ytPSJrRayx2vcDdwckRFQ55408fMvRPegNeJC4BIbcOpvipMke+xqYhFsj1iSC6gVqeE
         dwwN9APTp0ie6DnzAKu5s1nRhDIfZCRKKMRMzq4FKxLfoYWzyuxHeXX8jCuz4uZcY2Zh
         pEOA==
X-Received: by 10.15.98.141 with SMTP id bj13mr65458811eeb.29.1366056384909;
        Mon, 15 Apr 2013 13:06:24 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id j44sm19070412eeu.10.2013.04.15.13.06.23
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 13:06:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7vwqs3r3m4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221307>

Am 15.04.2013 21:33, schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Karsten Blees <karsten.blees@gmail.com> writes:
>>
>>> This patch series addresses several bugs and performance issues in
>>> .gitignore processing.
>>
>> A 8-patch series ending at 5d765dc7888b (dir.c: git-status: avoid
>> is_excluded checks for tracked files, 2013-03-18) has been cooking
>> in 'next'; in general we won't revert and requeue a new round for a
>> topic that has already merged to 'next'.
>>

I'm sorry to have caused such trouble. I thought you were expecting a reroll from this:

Am 19.03.2013 15:48, schrieb Junio C Hamano:
> Would we we better off kicking nd/read-directory-recursive-optim
> back to 'pu' (and eventually ejecting it) and replacing it with a
> reroll of Karsten's series when it comes, perhaps?


>> Is this "v2" an update for that topic?
> 
> Hmph, it seems to be the case.  I was hoping that the one in 'next'
> was basically in a good shape, not so broken to require a wholesale
> replacement like this.  Overall, this round of reroll seems to be
> better structured.
> 
> Let's revert the v1 from 'next', queue this one to 'pu', and make it
> advance slooowly this time.
> 

Thanks. I don't plan any more rerolls unless required by upcoming discussion.

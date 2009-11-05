From: Abdelrazak Younes <younes@lyx.org>
Subject: Re: [QGIT PATCH/RFC]
Date: Thu, 05 Nov 2009 11:19:11 +0100
Organization: LyX
Message-ID: <4AF2A69F.1090802@lyx.org>
References: <4AF19630.2070402@lyx.org> <e5bfff550911050141t751d45a0r4e340fa0d10af366@mail.gmail.com> <4AF2A538.7040303@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 11:19:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5zR7-00066D-LN
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 11:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbZKEKTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 05:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbZKEKTN
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 05:19:13 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:65284 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbZKEKTL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 05:19:11 -0500
Received: by bwz27 with SMTP id 27so9906456bwz.21
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 02:19:14 -0800 (PST)
Received: by 10.204.152.154 with SMTP id g26mr2806337bkw.54.1257416354486;
        Thu, 05 Nov 2009 02:19:14 -0800 (PST)
Received: from ?192.168.4.216? ([62.161.104.182])
        by mx.google.com with ESMTPS id 13sm641897bwz.10.2009.11.05.02.19.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Nov 2009 02:19:13 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4AF2A538.7040303@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132221>

Abdelrazak Younes wrote:
> Marco Costalba wrote:
>>
>>>  uint qHash(const ShaString& s) { // fast path, called 6-7 times per
>>> revision
>>>
>>>     
>>
>> Function:
>>
>> uint qHash(const QByteArray&);
>>
>> is already defined in the Qt Core libraries, so I have a link error
>> with your patch.
>>   
>
> By the way, this function of yours is not used anywhere AFAICS.

Ok, now I understand that this is used by QHash, sorry.

I have gcc-4.4.1 so maybe that's the reason why linking works in my 
case. But I don't which version of the qhash() function does take 
precedence...

Abdel.

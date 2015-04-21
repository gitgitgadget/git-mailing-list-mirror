From: =?windows-1252?Q?David_Rodr=EDguez?= <deivid.rodriguez@gmail.com>
Subject: Re: git's directory is _prepended_ to PATH when called with an absolute
 path
Date: Tue, 21 Apr 2015 20:17:47 -0300
Message-ID: <5536DA9B.1010801@gmail.com>
References: <5536C319.4000402@gmail.com> <xmqqzj61f90k.fsf@gitster.dls.corp.google.com> <5536C84E.8060702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 01:18:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkhQV-0007Un-7B
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 01:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbbDUXRy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Apr 2015 19:17:54 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35162 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964973AbbDUXRx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 19:17:53 -0400
Received: by qkhg7 with SMTP id g7so220208108qkh.2
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 16:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1C9kiS74JbuSoqfuPaNpNuK58N1b3QorsRV1CIzJCN4=;
        b=KnhVMsVxAvK8OIu1owt5ozGhORIhRvCzNlmyWO4rHAJzYvobwuGvJyx24QSVKxmlGs
         H9rKdzBtE74c6rYQqE9ESIakBt93FF72gSYyYBT0AwVesKgzMcPZ22JgXgN8/7FzxcIn
         6U8Te7SW4lgMTXKivLD/rppugJc84iPoLhmJycMzyTZNjCAfaBKaUbsrhcmqFtGEuonh
         6tA1T13ksNqiKzsOqa5xaC/7mId+cAuAcZ3AcjfBmRZusMG0UIHQhGXKPIkhYXuDA8l+
         iZW3P143We2PjNC/PxYS7QvrVmsL0ONIIFiubRkJHrx90+E7LHnUU8eUdGoQhPWLpILh
         pJaQ==
X-Received: by 10.140.150.19 with SMTP id 19mr27538326qhw.69.1429658273122;
        Tue, 21 Apr 2015 16:17:53 -0700 (PDT)
Received: from [192.168.1.103] ([186.237.38.30])
        by mx.google.com with ESMTPSA id k110sm2432039qgf.27.2015.04.21.16.17.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2015 16:17:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <5536C84E.8060702@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267571>

I'm actually not sure how to reply to an old thread...

 From the thread I gather that the intention is to prevent this behavio=
r=20
and stop prepending git's directory to the path. Is that right?

On 21/04/15 18:59, David Rodr=EDguez wrote:
> Thanks Junio for the useful link, I'll comment there.
>
> On 21/04/15 18:48, Junio C Hamano wrote:
>> http://thread.gmane.org/gmane.comp.versionlist-control.git/267143/fo=
cus=3D267251=20
>>
>

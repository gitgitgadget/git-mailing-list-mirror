Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 543B01FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 13:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbcFWNNv (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 09:13:51 -0400
Received: from mout.web.de ([212.227.17.11]:56561 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752204AbcFWNNu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 09:13:50 -0400
Received: from [192.168.4.69] ([79.223.122.121]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MZlMw-1awliN05La-00LTJj; Thu, 23 Jun 2016 15:13:41
 +0200
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
To:	Joey Hess <id@joeyh.name>
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
 <18617acb-bcdb-607d-007e-552dabd352cb@web.de>
 <20160622210958.GA24618@kitenet.net>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	joeyhess@gmail.com
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <1f76a4d3-68b1-db33-5c7b-dc5ab104a3ef@web.de>
Date:	Thu, 23 Jun 2016 15:13:39 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160622210958.GA24618@kitenet.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:f2oVvThi6B5ta9WhsWICSYhwyaKLL2XyKGKzt0RjkeRrQuUuBgU
 JfEOCqvzrTvbvIAevL77uh/tLnkSxrERVO8NDl+OHP+38p4jwDx29EyAXBsIrPDb8QG+MTP
 ltgRvEMNkHTYzXN0NsyDcc14EVCiSAkK/88JLn6eQVICWqOs9opOE2AxJtZnN0s9zNMakn7
 Aj7cN+gQ+K3/OB96jpIqA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:63YhIT/jsm0=:LwcskZlMXf4fsA7OrZXHdO
 kFgmW8UJzfnA7Z9C7hlVZU6ZwWA+oSNAFyWDr7m7XJPOxNeaDi/bmz3X4/WWwQJ3YiKuEm0NQ
 HqJHrtYCzgrqrt+71SHEo5ubm3vFx7g/2gRczL6cgYqEkntnfUnsN5Q/TbdcXu5ul+uL2LMTo
 scF7+Wj70XURFJdSMT1/lki/hlE9oImDdcvfhKHp+Nyl/eqz7lGA3ntV4lAddltLNFPwWs24f
 AUDielgA2uOvT1QRYVuy2UC0/zT/fTgGIOuegwRNai7a3IMluTUthrT/lHdnd30ke3QtJx0FQ
 EEEOqCsuAUWgyxO2HDrQJCFD64gbYWnBR6w9MRd/jIvLMlqn7wS73ReQBDHezUAjRZMMRCTry
 +1a2hmSqnrwVn+ib+k18lcCAWe/H8Tv8JuQXvfA1t2ZeGGhmcsnqZlVT7o+XUVEiqfrcaST7g
 d7PLI8SlPEAkC0+f+ocoR6svWiulSrJehfiEnnzLvxCDfjcP76r/2DmxFuGGIogadtYNLHcHM
 J1vLkW2r2pWuMXyEb2Xvt1cU0mci10UlJg8Ao/1hQ2r0ZdN038G+yLFDNtZJhfUsD536guIBZ
 8rf3sAH9doJ/KmJLDazhcoLDle3AfiggSXHRTNjgF5528dVdjSmrbQo2toHCRIWSxDXu52Mun
 rLLdY9TqPn/JfYGLBQLvFpMH7X/PajLjaVa4/zvRip41czwTtq057cRMy9/+U6WdE6RKFRqKI
 uY28tKchbfvlZCJFNz0Q4MQhjuz1Sh2reJPxMYAa7wPLC+sdOX+oMsScHWC5YG9QtzaOEtQYO
 9p/bl0+
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 22/06/16 23:09, Joey Hess wrote:
> Torsten Bögershausen wrote:
>> There is a conflict in pu:
>> "jh/clean-smudge-annex" does not work together with "tb/convert-peek-in-index"
>>
>> (And currently pu didn't compile)
> I'm sending a v4 of jh/clean-smudge-annex that is rebased on top of
> tb/convert-peek-in-index to fix this.
>
>> (I will hopefully be able to do a separate review of the smudge/clean patch)
> Would be appreciated. It'll be 2 weeks until I can work on this any more.
>
>> (And joeyh@joeyh.name is not reachable from web.de)
> I'd like to fix whatever's broken; you could send details out of band to
> joeyhess@gmail.com
>
Currently there is one comment:
The (new) usage of assert() in sha1_file.c:
   assert(would_convert_to_git_filter_fd(path));

The thing is that we need to check the file system to find .gitatttibutes,
even if we just did it 1 nanosecond ago.

So the .gitattributes is done 3 times:
-1 would_convert_to_git_filter_fd(
-2 assert(would_convert_to_git_filter_fd(path));
-3 convert.c/convert_to_git_filter_fd()

The only situation where this could be useful is when the .gitattributes
change between -1 and -2,
but then they would have changed between -1 and -3, and convert.c
will die().

Does it make sense to remove -2 ?



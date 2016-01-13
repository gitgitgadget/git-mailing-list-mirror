From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 0/4] Ensure that we can build without libgen.h
Date: Wed, 13 Jan 2016 07:15:06 +0100
Message-ID: <5695EB6A.1030402@web.de>
References: <cover.1452536924.git.johannes.schindelin@gmx.de>	<cover.1452585382.git.johannes.schindelin@gmx.de>	<56959DFA.9000704@ramsayjones.plus.com> <xmqq7fjeqjae.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:15:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJEiN-0005AV-4f
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 07:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbcAMGPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 01:15:23 -0500
Received: from mout.web.de ([212.227.15.14]:64554 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753095AbcAMGPW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 01:15:22 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MWS0g-1aht5m2J9G-00Xbg4; Wed, 13 Jan 2016 07:15:12
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <xmqq7fjeqjae.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:Fzxnh8jaxzOD1bH4VFv3LPcP9oMEtaqdv5MpYG/TwlLKdlO/OFH
 Nyi7kFModxL7rNu+nMDDKN9DIyZLe2bYdpRozNG/3iU1yRXxQvQf9knFEt/KFk6ERpF4/ho
 o5RTbm3JRjOzA/nSU7yFqZX5dqX/AMyufhaTCbqsnJYDtWQ6iOIbB2gP7a2WzgDh6YsebFC
 vZJ000CYYV5MgFXbt7qOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9dPMEdH1Qb0=:dkZ7opxkGDgMkhPLFajWpf
 gKEmyAXk1CFKhl4DJ4EhxUgbk6sBDdp5XQ8Yiipb6+1D7I08/EWz6KXFp/QRiz3cOqdR8hZeg
 sEiKLKHim9j+Y4BZsr+SObBNNZOYrsRF3Qspt91T+lezAzoOdT4I9VfjF6hQC2r5oKHKQyKhb
 HDDCZW4JVNH9OBCeBoWYAq7UQbLxqdVP5Er1p+Nwr6EIhKAwakAG4MJYddIoHlGqW5Co65rEP
 nSPnhaqmP8N3JU0bjDmuCgtzBBUX2a/tgnCaV9JmrnubGJrWweKzlq9OQkjo8C+geBuysLH4Z
 77OQA06RxFJKhrSxTeQXVtahYjPhyNspT4zizjLgFempTaec/QDXCRkWLRZL1J24KIHUwZXB1
 qooN2nuwPlHU0LXE73fCZB4OWCEFCytSkA1DydlLifj8L8Hjhu8l/mWTUGSZwKJ/XnUrBRhcm
 RZwM2TC8/b3OBIXFV1vpXgfnePRk1vIxnGjMrLxsT2hFGzWHxKAkJIyjzmwpD6w5IwqLcE4VO
 AJe/Fxu/3vEjABxKYxApVgpkIJw9Lq+4mAwEyhFtDMaRgYA8TcY5zhwURNkUNrrgZcNbH6NiT
 8+lpjO+SI4LsvD7+WesQl34P/IeRhFdOpq0K4WbTN/YMXZwYa/dnA1TYN2WyFyM0FKpNHH7+x
 2r4zIvZ1ZgKSTKbr3uHej5F4u6YxOD7GEiNRKh9AI5n/fi8ZdGFBZG+4ktQnDoqn7sTqp+xQc
 3/3YxAGqHMOKUgNrDmW5q2urO5XOrsWh/rv6FUYvKTFIydTzI4ZTo4BdMK380aQYOledlrhJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283880>

On 01/13/2016 03:56 AM, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>
>> Hi Johannes,
>> ...
>> I was somewhat disappointed that you ignored the implementation of
>> gitbasename() and gitdirname() that was included in the test-libgen.c
>> file that I sent you. I had hoped they would be (at worst) a good starting
>> point if you found them to be lacking for your use case (ie. for the
>> 64-bit versions of MSVC/MinGW).
> Sorry to hear that, but the 'next' branch has just been rewound and
> rebuilt with this series, so it is too late to replace them with
> another round of reroll.  It however is never too late to improve
> with incremental updates, though, so please work together and send
> in a follow-up patch series as/if needed.
>
Is there a chance to keep it in next (and not merge to master) until
we have found a solution for the broken t0060 test under Mac OS X ?

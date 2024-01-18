Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CEF2E850
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 21:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705612156; cv=none; b=UhsWJe19WaLWFszIZ01YhK6XANtf/CTaId8jvxIEI0Jgk1FTQyWRs7G/xg2wAQIo07TSXoAWDlQNBAfJsw78FYCHwGOs9DhedGngyfTZ5sYpBL9W0NT5czTEBFKoSzoBEcmC93UWtWdgmS+D9c9fdmuLsh5gdV2divICipfpHsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705612156; c=relaxed/simple;
	bh=nCxO4IuwMLTU0bskRiy/CheHaU1RXCYD3+iqZLhgoKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Skyu7xdH6OHVsFNfQRzx9WwbjR5wvogRT+XkcJrTXwU5ewj8MT7wAXkJekYjhJymnUYD4/yrybvtEXu47IhnqWdFyschFpHxsAdkaloHjnSG0rNzhqMR7PV+n1fEeGN179So6DHMHCtfnEFFIBjWgl8LSYKsMfsBlIJublY6BQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu; spf=pass smtp.mailfrom=delpeuch.eu; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delpeuch.eu
Received: from [192.168.178.189] ([93.206.14.11]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MRSdf-1rnS0S42lB-00NUC5; Thu, 18 Jan 2024 21:56:02 +0100
Message-ID: <00fd20e2-73f5-42ca-b9a8-1ee227150eff@delpeuch.eu>
Date: Thu, 18 Jan 2024 21:56:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] merge-ll: expose revision names to custom drivers
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <pull.1648.git.git.1705587974840.gitgitgadget@gmail.com>
 <pull.1648.v2.git.git.1705592581272.gitgitgadget@gmail.com>
 <xmqq1qaeqtw7.fsf@gitster.g>
From: Antonin Delpeuch <antonin@delpeuch.eu>
In-Reply-To: <xmqq1qaeqtw7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IvSfwEyBZMSeBVPlZXlv88WRQmKXVrXXY1Ofbrq30BW8POcnQEb
 rQg7suaJa7SpaIaaNK+YkDDfhXgVcvDzBy+65NT2RleljuRN40ll0okacdA9V4vepmcNRIw
 ZMk38zFqcrDFXtLbpsj0Q4vvSQOwWWesd8YDFXdR6dkLpYOXGEXkSp+xVT9jfIDETWiT7MG
 Icm6DSHT4b93IhoOgqbjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lLz/NBvvU7o=;8zBS0TgyXFONs3XUqFGCbr1q773
 PcIqKRnarDPcs5ZPlgjt1M1M0DEgXW0XDQ7GQlXjDW6TKP4mm4aYa3p1cVMT7KW31fHtr7Aw5
 i4hGmULrIwYlXDIGfvIbiJMViA8Or3DTffTgpfECR9xHWhJVstpsVaKtpdx8qBpGZF5+xC+6d
 5Z8vTW3PAXUGocffmTiVtnqo5VlCO8BagNoocmOFi1TPU4g1wQLY77XcHlXBLxwlEKqbWWCuC
 PfbBkWSgSwQ+VcN2bxtug1PNyzKcdp3Qdvjz7HxE3FFfJdblrhgbzjiYeYxdt6mlQhuctf0fb
 us5YD5Ano6Sf7d/t4l+ATaZqZMiyKN/mwHbmAoFFsPjto8kMMV96ieGdYwmHT+Ev03BYVgk4/
 D1gT2dM5R7CqjSoqKC/rYA5QTjEfpOiTp+FoyrRCmHQhOoOLMJLMs/z6CECDBlxKHzXHcqk03
 kuGclybJ3xqsRqmeOMdLs8XTZfako/TrphXX2vWcVSnH/NS4tQC3QKBaSlpMvrYmvdwr9CkU5
 cZfUAR3XUmH+f8dcqlcyT+gBxLZOAuShRfH6I7+Ze6R154KeUGXyvStZ9qjPH2lxHOjrfAOYg
 71PvhqMBa7j+y4nRLBVY+qpBsWpQ3jF33rhw2JlI7a6NixL1XBwIVOV5sYFWcFlA/lraxarPN
 rpSUX/zgYt30PCVJTIu6794iZ/KTOOfzABgeZGf+/+HXtWdBvxMZ1thRoBiC4I3D1Tpry1Wh2
 T1qa9QMrSnTehStTH6mzub9EJ8g0emD/l5nbGWc5aHWxyVANGW9NRa9XUHAF9+XxHnuKZxweK
 gzh4MMGHrvpqUxcDnBjWwR0Aq8IXmkcZ5twlrZ6l6HUUVsIn4F5ZnnWLn6062AdH85/eZxFan
 MwlbSY74Ve+4txQ==

Hi Junio,

Thanks a lot for your review! (and many apologies for the double sending 
as HTML…)

On 18/01/2024 21:16, Junio C Hamano wrote:
> Or you could fix %O's description "while at it" and use the right
> term from the get-go for %S.
Agreed, I'll do that, it also feels more fitting to me.
> I see some funny indentation for "S" here.
Oops, sorry about that.
>> @@ -173,7 +179,7 @@ test_expect_success !WINDOWS 'custom merge driver that is killed with a signal'
>>   
>>   	git reset --hard anchor &&
>>   	git config --replace-all \
>> -	merge.custom.driver "./custom-merge %O %A %B 0 %P" &&
>> +	merge.custom.driver "./custom-merge %O %A %B 0 %P %S %X %Y" &&
>>   	git config --replace-all \
>>   	merge.custom.name "custom merge driver for testing" &&
> ;-)
>
> This one is expected to die and not produce meaningful output;
> I was wondering why this does not need to make corresponding changes
> to the expected output pattern like the earlier tests.

As far as I can tell, this test does not compare the result of the merge 
to the expected merge driver output, because that output is expected to 
be disregarded by git given that the merge driver died (see the last two 
lines). So it seems normal to me that we don't need to adapt the 
expected output: the repository files are still left unchanged.

I'll submit a new version of the patch with the two changes above.

Antonin

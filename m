From: Maxime Boissonneault <maxime.boissonneault@calculquebec.ca>
Subject: Re: GIT get corrupted on lustre
Date: Thu, 17 Jan 2013 11:41:13 -0500
Message-ID: <50F829A9.7090606@calculquebec.ca>
References: <50D861EE.6020105@giref.ulaval.ca> <50D870A0.90205@interlinx.bc.ca> <50EC453A.2060306@giref.ulaval.ca> <50EDDF12.3080800@giref.ulaval.ca> <50F7F793.80507@giref.ulaval.ca> <CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com> <50F8273E.5050803@giref.ulaval.ca> <871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	=?ISO-8859-1?Q?S=E9bastien_?= =?ISO-8859-1?Q?Boisvert?= 
	<sebastien.boisvert@calculquebec.ca>
To: "Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>
X-From: git-owner@vger.kernel.org Thu Jan 17 17:41:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvsX0-0008HP-Uy
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 17:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757232Ab3AQQlO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2013 11:41:14 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:61960 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757073Ab3AQQlN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 11:41:13 -0500
Received: by mail-qa0-f46.google.com with SMTP id r4so4440836qaq.19
        for <git@vger.kernel.org>; Thu, 17 Jan 2013 08:41:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=o0REREI45mVDDt0JFhEUyPc/AbSjjyQB23r3xmkplmE=;
        b=h/OmR48LD7V4xV//i8yM2DKJmggdJrnXQmYHRZjM4QWOutpd0L1bjcleTt8x6YPbsq
         8cpMyQR3YEV7V08eWb3HiI9h1ViZ5/WQKT57Ik5Vva1KaEKe3jc6nX1WL0/ytudEKz62
         L4Lb4+W19I0qBlYTxcvSwkpZxNw+hybSQUg/QjPRJTObJkdEU3K8VTX3ov5vhyCpvbzx
         R1XEf2Q1ckKo+QlGB1+PTSs1MRXslIwZBgDuCBKVQ/gZR5ICJENgwNnt8QYIg5jqyIip
         9Qu9yajDG3ef758/n0WjCWH2nT3x6dyX+MIbIv8PslMpfL5QIS2+1Pq97rV9jt1z6stC
         t5fw==
X-Received: by 10.49.127.180 with SMTP id nh20mr7070737qeb.19.1358440872861;
        Thu, 17 Jan 2013 08:41:12 -0800 (PST)
Received: from dhcp-106-204.gel.ulaval.ca ([2620:0:1af0:f100:618d:6e9f:f467:219e])
        by mx.google.com with ESMTPS id ks10sm1066944qeb.13.2013.01.17.08.41.10
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Jan 2013 08:41:11 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil>
X-Gm-Message-State: ALoCoQksHff8eilQoTn/OamrE6g290Cx4x67SPfPI3SASI85vATl3Am2djSwQIVHNdQhIEKEJuQI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213856>

I don't know of any lustre filesystem that is used on Windows. Barely=20
anybody uses Windows in the HPC industry.
This is a Linux cluster.

Maxime Boissonneault

Le 2013-01-17 11:40, Pyeron, Jason J CTR (US) a =E9crit :
>> -----Original Message-----
>> From: Eric Chamberland
>> Sent: Thursday, January 17, 2013 11:31 AM
>>
>> On 01/17/2013 09:23 AM, Philippe Vaucher wrote:
>>>> Anyone has a new idea?
>>> Did you try Jeff King's code to confirm his idea?
>>>
>>> Philippe
>>>
>> Yes I did, but it was running without any problem....
>>
>> I find that my test case is "simple" (fresh git clone then "git gc" =
in
>> a
>> crontab), I bet anyone who has access to a Lustre filesystem can
>> reproduce the problem...  The problem is to have such a filesystem t=
o
>> do
>> the tests....
> Stabbing in the dark, but can you log the details with ProcessMon?
>
> http://technet.microsoft.com/en-us/sysinternals/bb896645
>
>> But I am available to do it...
> -Jason


--=20
---------------------------------
Maxime Boissonneault
Analyste de calcul - Calcul Qu=E9bec, Universit=E9 Laval
Ph. D. en physique

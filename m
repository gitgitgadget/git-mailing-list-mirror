Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="coxz4zDs"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECCF1AA
	for <git@vger.kernel.org>; Tue,  5 Dec 2023 12:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1701809906; x=1702414706; i=l.s.r@web.de;
	bh=ZN34ymJTNXFhKcTj6q3RrHHXzLd68u5oDjEOQW179yU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=coxz4zDs2B0VTE8RfhVEFnzfxw4M3r93G0Hz0emYOqertwo2CYl5nqdk+V9KoOAu
	 WcO3dis1rStiPKdnTn+fyqHj/61XemcmB1FkHEfH0dG02YKeWP8gWeDd3Oo6KQI4E
	 rnILmeFdgczSnCPQd9650zGAmZQUAEO6JMIG473LSjAhDQ7ziHXSyvv7/NbC/X7oO
	 WmdPrH+yzTE9SjDNRccvHLaVdshz3JYAadDJ+tAfXgNMyO6ODZ+YpsNMxMzqXOhUl
	 0B9IbL2s28GmLBHg1auO9cL2vmTCX8N3VMCdMMf2kkUsdE1hXukZJreSMz2CWkW0h
	 WoPoUUlvh8w9FBD9oQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.29.38]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MoecP-1rcqhH1yzB-00obQ1; Tue, 05
 Dec 2023 21:58:26 +0100
Message-ID: <ea020e16-7d07-4fa0-84b1-5d2f76a6fe34@web.de>
Date: Tue, 5 Dec 2023 21:58:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] This PR enables a successful git build on z/OS.
To: Eric Sunshine <sunshine@sunshineco.com>,
 Haritha via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
 Haritha D <harithamma.d@ibm.com>
References: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
 <pull.1537.v2.git.git.1701699574054.gitgitgadget@gmail.com>
 <CAPig+cQ8eEU0TOoBf2KavTyf0OLhNtmOzs8+WqZy9JMXa=ydPQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAPig+cQ8eEU0TOoBf2KavTyf0OLhNtmOzs8+WqZy9JMXa=ydPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iih1NR0rFYUv38d/h2Yof42tRPDKpVaC3WGVGQnzTNuIkEUznd0
 zFi+ejj/SAeTzFqH6zXa5za4KgRW2gXCmV7NYixwEfaiyoQvlCDxKSIAop316jGcfRANtXB
 2Afd+31spyJzMZ80UdHiNq0SXgB93yf8sfRPAqj+a3fNkqM2gjAkGf1HXMZ+j7OyumkuxYi
 bKZ/rfuOSWMEfAIz3S0rg==
UI-OutboundReport: notjunk:1;M01:P0:K5iYB1+Ws8E=;5WaCWqOZ3oUldAdqlOFE2x0gKK2
 kmfRFn5f0UN7OWub9I+RDofEd9vhNBB892/Z5srVL9948HCfn9tYUcHpE6yX/DtGW2mYYsCGw
 dDvjyiZ23CLrgydELcqwU+4aaT14qpQFgzdOqyJW0EB4vQ0ekgcUfq695O5b4Ub7T7IF1UccO
 Krp7aCOJoUIyxFhrZosPI6HWDeBjgyjCCp/EB9MIMcGOnkYxN4wYdn2GFpYPEXOFs3AEgSViQ
 61ZOWhsifWGZCFdFZTEsJ2l1p1uWNO50qTRI3IBsdWBo3BZORtD5ZQzW0NHzHOE5SPSnBZtbF
 4N/J9dWngdsvK4855xD70XupC2ZbZCaKgUKBeI5zYkykQmdJtCaw6kKvICnf/iU+TISAxiyTK
 HU5tGGy+pJi8BfZPFDMNpJeNKffWH/pyJoZlUpxZEy89A+hsraA7fPNOR+wEWYEfsUIBd7jeD
 vTGPzut+pEnENiN7//ukl7HVSA4ntFOOYKaYaVc25IlSmdSQsiRCrAwJc/cyv5J5rDyZXXAIc
 16ck/dqU6o34hF6cnznfCkjzCc1oJRc+Z0/HpFjScsXUoxzOenFdlbH0yxHuMSoOBW5SxUmox
 T4Ie9MymDDo+ywP0krfvSwMK2cGK82vab/PNjAKAYKYv/Nc+ET+LO6SmDWNqa39hNwO2gyJ7F
 pUNOKtNDpEx/QQikrebLqFwP0t7ceXmB+R2gahZkOY5ZiIz+twPBHsdfnJN4cA9U4hAZ+ISXG
 BXQn5dOYq5kW1o/kgopvWvs5wc6bmMpyYaaseHNysmL5u2OogSSn2da34EXMb3NScgv+JDnD1
 EnOGTuJ21ceY47iSFmqDyIZ8LCZ/6BOZCVVHg7350nE9Rh8mI6NYVPdmwUsntn1PRGDo/FD1F
 ZpxlXerYA9R1+V7zA/7it4aJ6aB0++IZPz4Ml9AAWAjFOOPjYLTxiHbICbtRA0bNexqk80xS1
 uTPV9g==

Am 04.12.23 um 22:46 schrieb Eric Sunshine:
> On Mon, Dec 4, 2023 at 9:19=E2=80=AFAM Haritha via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> diff --git a/fetch-negotiator.h b/fetch-negotiator.h
>> @@ -47,7 +47,7 @@ struct fetch_negotiator {
>> -       void (*release)(struct fetch_negotiator *);
>> +       void (*release_negotiator)(struct fetch_negotiator *);> diff --=
git a/fetch-pack.c b/fetch-pack.c
>> @@ -1232,7 +1232,7 @@ static struct ref *do_fetch_pack(struct fetch_pac=
k_args *args,
>>         if (negotiator)
>> -               negotiator->release(negotiator);
>> +               negotiator->release_negotiator(negotiator);
>>         return ref;
>>  }
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> @@ -223,7 +223,15 @@ struct strbuf;
>> +#ifdef __MVS__
>> +       #define release stdlib_release
>> +       #define fetch stdlib_fetch
>> +#endif
>>  #include <stdlib.h>
>> +#ifdef __MVS__
>> +       #undef fetch
>> +       #undef release
>> +#endif
>
> So, the problem is that z/OS is polluting the C namespace or the
> preprocessor namespace with names "release" and "fetch"? When we've
> run across this problem on other platforms, we modify
> git-compat-util.h or some other files in compat/ to suppress the
> pollution introduced by the platform headers rather than "fixing" the
> Git source code. For instance, if "release" and "fetch" are macros on
> z/OS, then you may be able to simply #undef them after pulling in
> whichever z/OS header defines them. If they are actual system
> functions (rather than macros), you may be able to employ the
> #undef/#define dance to rename them to something else, such as
> "zos_release" and "zos_fetch" _before_ including the system header
> which declares those functions.

I assume that [1] and [2] link to the documentation of these functions.
Both pages include the following paragraph:

   "To avoid infringing on the user's name space, this nonstandard
    function has two names. One name is prefixed with two underscore
    characters, and one name is not. The name without the prefix
    underscore characters is exposed only when using the runtime library
    extensions."

[3] defines "runtime library extensions" and mentions the macro __EXT
and LANGLVL(EXTENDED).  Do you need those extensions?  If you don't then
perhaps turning them off avoids the name collisions without needing to
change the code?

Ren=C3=A9


[1] https://www.ibm.com/docs/en/zos/3.1.0?topic=3Dfunctions-fetch-get-load=
-module
[2] https://www.ibm.com/docs/en/zos/3.1.0?topic=3Dfunctions-release-delete=
-load-module
[3] https://www.ibm.com/docs/en/zos/3.1.0?topic=3Dreference-zos-cc-compile=
r-feature#compiler_feature__ext_lib_func


X-Greylist: delayed 1444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 04:58:21 PST
Received: from mut-mta1-se01a-zose1-rescue-fr.yulpa.io (mut-mta1-se01a-zose1-rescue-fr.yulpa.io [185.49.21.247])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F97EBA
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 04:58:21 -0800 (PST)
Received: from [185.217.155.54] (helo=mut-zose1-mta-hub-outmua01b-fr.yulpa.io)
	by mut-mta1-se01a-fr.yulpa.io with esmtps (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <git@matthieu-moy.fr>)
	id 1rCfUA-000RfT-3T; Mon, 11 Dec 2023 13:34:12 +0100
Received: from localhost (localhost [127.0.0.1])
	by mut-zose1-mta-hub-outmua01b-fr.yulpa.io (Postfix) with ESMTP id C68BD1017BA;
	Mon, 11 Dec 2023 13:34:08 +0100 (CET)
Received: from mut-zose1-mta-hub-outmua01b-fr.yulpa.io ([127.0.0.1])
	by localhost (mut-zose1-mta-hub-outmua01b-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id rNKGuVJx-Sh8; Mon, 11 Dec 2023 13:34:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mut-zose1-mta-hub-outmua01b-fr.yulpa.io (Postfix) with ESMTP id D0AB81017C5;
	Mon, 11 Dec 2023 13:34:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at mut-zose1.yulpa.io
Received: from mut-zose1-mta-hub-outmua01b-fr.yulpa.io ([127.0.0.1])
	by localhost (mut-zose1-mta-hub-outmua01b-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VqN5pV99cp52; Mon, 11 Dec 2023 13:34:07 +0100 (CET)
Received: from [134.214.142.79] (nautfst12.univ-lyon1.fr [134.214.142.79])
	(Authenticated sender: matthieu.moy@matthieu-moy.fr)
	by mut-zose1-mta-hub-outmua01b-fr.yulpa.io (Postfix) with ESMTPSA id 3E7331017BA;
	Mon, 11 Dec 2023 13:34:07 +0100 (CET)
Message-ID: <24a42fa6-7bc4-4a3b-8bf4-a0ef85dc457a@matthieu-moy.fr>
Date: Mon, 11 Dec 2023 13:34:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re* [BUG] git-bisect man page description of terms command
 doesn't mention old/new support
Content-Language: fr
To: Junio C Hamano <gitster@pobox.com>,
 Britton Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
References: <CAC4O8c9ieZC4SBJf54ZuTfAvnkhGuDaibBQ-m9Zw_n5VhUFPag@mail.gmail.com>
 <xmqqzfyjmk02.fsf@gitster.g>
From: Matthieu Moy <git@matthieu-moy.fr>
In-Reply-To: <xmqqzfyjmk02.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-yulPa-Domain: mut-zose1.yulpa.io
X-yulPa-Username: 185.217.155.54
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.217.155.54@mut-zose1.yulpa.io
X-yulPa-Outgoing-Class: ham
X-yulPa-Outgoing-Evidence: Combined (0.09)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+f6pv7mGzVolObcR6FH4W5PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5yTJ7LxQF64CHhQpUvabvAJ+MjBInvU3LaEVMeEjEqsCy3C
 ueNfqMJBYzPoh8qXShALoRkLTrjMt9ms9ecPYK2/TFFcpMF0/CzLBR+oLw/EucrTe0zrzdDWGq2t
 L69jBpdnJp9a1tpqjSEs3z+e5Y5IgaIklYgfSyUWpjLOA4/D8rfgLSpDJEMwTgKguln1W71mJFia
 ikvVxgjp0/k+1t1ZqjX7HlbR20JWrC3DWMQHNV2Oa7QzFrg6D3juj9vUlkF9B8fUuqtRpRzuX5VG
 bRJnxi8bExZ09S6HjTDouvl2AK8k3iPNM/IUbeMvHjH9X9NVyymfg6B6tC4se5nVh7xdPwFjw4xN
 vFYo1FJlAgQJq1wbKojRqtiBqzV6/8TU4C7V8GDOb5Y/I6ziSUV3GNc6DA5Y1S9u6TrFXJx1DE44
 trkVV4P+GIk7DjCmMhgneKTYZ00gWnYa9olzNq56OPL0/nS4Mip/YUa5e3+XzCBIJOWBOXp8nHKe
 0R+FkIqN7hnTQMoKDphoUVvpZKwCZd10t1b0nbm6rQ6/kz4UWOYpThpRgmiLUqI+bb7cseB9FrjY
 5Qx4fJOk03R5fJtf/Dv/102E2X3w1lFuRDggRmmwg/+S3KUQNLB4HA+aJMIzcAg/vy0/Q3Mx9w1p
 gQ+E6nteXAh4Z4SdDw0tMBFHk8VqmrIDC99jzjTUlR+8183XBmoP/VRg8DyOkrVLuYR3uOKEHyt6
 YA4pqOucBHCwLpRe32UAxv4l0RRNh7vApgFH4R49vz1ahYQzHhHCjBpTAJ/xZe8qW/92W6XbiMJN
 gk8ETu3O5tpcV4zMjKpBfM0x6dkhu1/rdU1t/SWu+yxj6TsAFrmdem8qac7iyHa9gVEQWzYksH5x
 znejQRGIVacrOaU5iIEVdtbW+u5+Lw9u4E5iJryKhGLyc7V+sTkdC7001n/RVD7V77GVoESrF1Xc
 DxGEM0Fy1htTjUl7elPAE5eaEN72vxxny+8/iOyLyb1ALWe/ZaBVhrOmh41CfYezVULTBjHr1VSj
 YpMC0NH6vxTrLyJg76LajsxKEAfE0DyOLbkEMWWDci/2nplSOlA+h1o=
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io

On 12/9/23 17:13, Junio C Hamano wrote:

> so you could read that
> 
> 	git bisect terms --term-good
> 	git bisect terms --term-old
> 
> are the same thing, and when you squint your eyes, you can probably
> guess that
> 
> 	git bisect terms --term-bad
> 	git bisect terms --term-new
> 
> are the same.  But I agree that the documentation should not force
> you to guess.

Agreed.
> --- c/Documentation/git-bisect.txt
> +++ w/Documentation/git-bisect.txt
> @@ -20,7 +20,7 @@ on the subcommand:
>   		  [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]
>    git bisect (bad|new|<term-new>) [<rev>]
>    git bisect (good|old|<term-old>) [<rev>...]
> - git bisect terms [--term-good | --term-bad]
> + git bisect terms [--term-(good|old) | --term-(bad|new)]

Nit: just above we have the description for `bisect start` saying:

--term-{new,bad}=<term> --term-{old,good}=<term>

it probably makes sense to make both homogeneous (start with the same 
alternative, and make the {...,...} vs (...|...) notations consistent. 
The (...|...) notation seems the most common).

In any case, the patch looks good to me, thanks.

-- 
Matthieu Moy
https://matthieu-moy.fr/

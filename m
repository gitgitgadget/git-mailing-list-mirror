Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237A439853
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="pntH4d3p"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5212CA
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1697744872; x=1698349672; i=tboegi@web.de;
	bh=QxQZiTmZadrzUQWKMtLq2ntbnWQaVKvXYe2bRGcmWEY=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=pntH4d3pKOpHjiPWlXxg3yf34evwU+F/ecMNwoOeoxX+2/+HfKjM2gB284ivOXP6
	 VTG9c3C+0pVZfGagkNv3h2MJ67Mkk80ZI8V0i8Foz+RgJe3kvzF19a+Y+hRKWQfu3
	 Fg5EaZbg9GSAJ3frg3tWJ4E5RvVMCBWmdpArHXkbiuTyJOI1ZTFW5l9e4qbwQ8osG
	 EQKLfiHXs4jlVDX8pL4/SFINzkkeN6l1ilRwkDWA7FrwTNQBQHpn67vZ+SyLpQ76U
	 NjXoahVKotinNjiAD07ehwPFCpWJ9ekSpI6GHyGOul6Bf5wNIKTYK5UvgaVSudELH
	 2H8uH/3Hq4la1I3Svg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQxnv-1r8DRH1Orf-00NeNS; Thu, 19
 Oct 2023 21:47:52 +0200
Date: Thu, 19 Oct 2023 21:47:47 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Jeff Hostetler <jeffhostetler@github.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Git List <git@vger.kernel.org>, jmas@softcatala.org,
	alexhenrie24@gmail.com, ralf.thielow@gmail.com,
	matthias.ruester@gmail.com, phillip.szelat@gmail.com,
	vyruss@hellug.gr, christopher.diaz.riv@gmail.com, jn.avila@free.fr,
	flashcode@flashtux.org, bagasdotme@gmail.com,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	alessandro.menti@alessandromenti.it, elongbug@gmail.com,
	cwryu@debian.org, uneedsihyeon@gmail.com, arek_koz@o2.pl,
	dacs.git@brilhante.top, "insolor@gmail.com" <insolor@gmail.com>,
	peter@softwolves.pp.se, bitigchi@me.com, ark@cho.red,
	kate@kgthreads.com, "vnwildman@gmail.com" <vnwildman@gmail.com>,
	pclouds@gmail.com, "dyroneteng@gmail.com" <dyroneteng@gmail.com>,
	"oldsharp@gmail.com" <oldsharp@gmail.com>,
	"lilydjwg@gmail.com" <lilydjwg@gmail.com>,
	"pan93412@gmail.com" <pan93412@gmail.com>,
	"franklin@goodhorse.idv.tw" <franklin@goodhorse.idv.tw>
Subject: Re: Is there any interest in localizing term delimiters in git
 messages?
Message-ID: <20231019194747.GC25301@tb-raspi4>
References: <CAP6f5Mmi=f4DPcFwfvEiJMdKMa0BUyZ019mc8uFXyOufgD4NjA@mail.gmail.com>
 <xmqqzg0gx6k9.fsf@gitster.g>
 <CANYiYbHK90Ptq5v4EbquyRA7N9jo=xwkg=WuM=r60Wh9HMxdyA@mail.gmail.com>
 <xmqqwmvkve83.fsf@gitster.g>
 <CANYiYbEqTH975j9E0GTbSbexrw3MLhKwBCw7mibfnWbxZ+-_yw@mail.gmail.com>
 <xmqqcyxaxzxw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcyxaxzxw.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:hKYLMNgHuj9BgMZCR1OiGLxNX1qxsGcMKIUNLfPwscOvgXmkRU9
 HKLrxcvvNjxY72h6Hm0V7I6ltIJqDu1xVs5EJGjuGdcHwBACLrvIy2RHxlEwl5wInjGSPVI
 oJfS6vPn+PFwflD9OZQAVnGAehFGwcTpxI6Lt1jZWHISn2ko7XpTkHr+ol8WKCQjbViWc5M
 lsoqsQKbMeuLK0A8GRrNw==
UI-OutboundReport: notjunk:1;M01:P0:ozEokGTb8L4=;X0JGFFM96T6ScbUbRikIUBbGKD3
 OKFIpei5e71yJUarlV6QpOLgFiGutLuVxN1fIOvAzae8gutIffD+wjFP8D6dddFrqIS7nzBdg
 ioHX7st0whP9ft0nYju1r+0iv/NTAhCiWAbz/z0u/iBINCj0Ir21Fa9LsWo7dM92G0hcJ+8PW
 u+BrOtzc7xZ7Taatan6nJoP6b18OTFEqhjPMUkOm5p/TG2Xeple6c2zZR7j67r4zEau/qPxaB
 uvpgrFWkueHtWXKiaEog2P9U5Skilmb4nfq/9vjnMCQ+wmI+h1RHWnp62mWB/kDodTuGVBfI5
 BWtKpVtpfnRjD+PxB6QN5MvdybImYKVMy8hS9XiH1TzcDA1dGi+pQJozmxEm6+11cimLPwwAK
 lcmMWnAcK8ADSuwcrBbGapJ6YBo1undH3IMCfOkGO5fkCZQemfXZVgCrECTC+o6n44zui2ME+
 0vosVvFuIATJT5zNQ+9ZhLarkGOaXNY98i7bbPdx9V2uIRkP0XfUsZMsat1ZCyo5B1jv1QP3W
 diEHyS7xHkF0O0jDzJ/b1RfgAeS5TuOcndLzumWsmoxi188wsq9WukQ4ZwEQmi6NG2aj5YY5W
 asPUc4Oq6PbxUIOUhk53olJ9tuBfcCH7qcjH6fXCld/7VjOtTLOBkXm1ZtsMPe5HTZaRHQvp0
 KmUIt/ASG1t/oAP0q5ru4J9FWa4CDjaxNTtlj/a1frtg5IZ40ZWoEHxDX3P1ymeA3iVUIvBYk
 kEbZ/TC4v6EPQsx1b0w/L5jb4zrHUAf9xHL8N001xZ4PhZjx6tsVGp9EUI88VrE/4B/c7PqlJ
 YPL8TBGqpGvSZWNkhwRWvBedcZWd6sl6qnVOtEidDJ0QpMTLxszBS2qoRQFezykFDZJkGlFSP
 7cqy7ZEOoBcsbQtigMEMQSPEudQzUqtcBOEYaRbPhK6pajW1AK7/CrbH8NcOFZz/vGc29NRWG
 gJhSzz54GY12jO2FnKAuUX0v5+I=
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 10:52:11AM -0700, Junio C Hamano wrote:

>
> Also some of them might better be a BUG(), instead of die(_()).
>
> >  * crlf_action in convert.c:
> >
> >     warning(_("illegal crlf_action %d"), (int)crlf_action);
>
> [jch: cc'ed Torsten for area expertise].
>
> For example, can convert.c::output_eol() be called with an illegal
> crlf_action that is not covered by the switch() statement due to
> data error, not a programming error?  From my quick scan, it looks
> like that the error should never happen no matter what end-user
> mistakes (e.g., misspelt attribute and configuration variable names
> in their files) are fed to convert_attrs(), and can come only from a
> bug in that function (e.g., long and convoluted if/else cascade fails
> to assign any value to ca->crlf_action and leaves an undefined and
> "illegal" value there).

The switch case covers all 8 values of "enum crlf_action",
and removing these 2 lines
 -	warning("Illegal crlf_action %d\n", (int)crlf_action);
 -	return core_eol;
does still compile without a compiler warning.
So yes, a BUG is more appropriate here.
I hopefully find some time to send a patch the next days.

>
> Thanks.
>

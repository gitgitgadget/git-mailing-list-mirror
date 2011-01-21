From: Jello huang <ruifeihuang@gmail.com>
Subject: Re: cannot fetch arm git tree
Date: Fri, 21 Jan 2011 22:30:38 +0800
Message-ID: <AANLkTi=wHO4TrVe_x05+gCrfz0rsLcSLyJ5b8pT6c6-O@mail.gmail.com>
References: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com>
	<20110116092315.GA27542@n2100.arm.linux.org.uk>
	<20110116110819.GG6917@pengutronix.de>
	<AANLkTinrZ0GnT71GCueUUpAXM5ckq+LBd0RjA51DMR-a@mail.gmail.com>
	<20110116134248.GD27542@n2100.arm.linux.org.uk>
	<4D398C43.1000306@vollmann.ch>
	<20110121134728.GO14956@pengutronix.de>
	<20110121135725.GR13235@n2100.arm.linux.org.uk>
	<4D3997FE.5030109@vollmann.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2061661870=="
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, git@vger.kernel.org,
	=?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Detlef Vollmann <dv@vollmann.ch>
X-From: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org Sat Jan 22 22:24:09 2011
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Envelope-to: linux-arm-kernel@m.gmane.org
Received: from bombadil.infradead.org ([18.85.46.34])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>)
	id 1PgkwK-0001Vx-IQ
	for linux-arm-kernel@m.gmane.org; Sat, 22 Jan 2011 22:24:08 +0100
Received: from canuck.infradead.org ([2001:4978:20e::1])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Pgkvb-0003eG-Qo; Sat, 22 Jan 2011 21:23:24 +0000
Received: from localhost ([127.0.0.1] helo=canuck.infradead.org)
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PgkvZ-0004A0-VT; Sat, 22 Jan 2011 21:23:22 +0000
Received: from mail-fx0-f49.google.com ([209.85.161.49])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PgI0f-0008IP-Fz for linux-arm-kernel@lists.infradead.org;
	Fri, 21 Jan 2011 14:30:42 +0000
Received: by fxm19 with SMTP id 19so1858275fxm.36
	for <linux-arm-kernel@lists.infradead.org>;
	Fri, 21 Jan 2011 06:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type;
	bh=n0OF0iGr0T68NQ56eDj3ldKkW9gda83+OMmmS8j1iZU=;
	b=MCy/Gpq+FVKhwTSVZMUAVw+eP3KZd6WAmsN6zDJfW85rDIWPHc6qYaNS14/SGi9+jf
	lsINFx7Mg+hneidLBGK/5noaCfjax/1BT7FpxkXq4xWgtLAmeMm3b4YkfkbDyGaXTX1p
	hx4YhhpOYSf+wa1ztSAz/gdtP2FsF9D/e8EYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	b=aTkfW5WPidMFDenLLnwoPN8k/9+0/5/w+FgEpdCQAn9S4yxfOZtP4ZBx7Gj0lHUUyb
	4TKz8ZFSeKMkqTo/nFZCGEFOcywdfuoSlOIaGSP+/W+WXiT2uX9jUeUQ93S2t+o6mYLQ
	zmQCY3qjxECWMwM2eWBPFsyvE20/C396PIwyc=
Received: by 10.223.79.74 with SMTP id o10mr750630fak.63.1295620238280; Fri,
	21 Jan 2011 06:30:38 -0800 (PST)
Received: by 10.223.86.13 with HTTP; Fri, 21 Jan 2011 06:30:38 -0800 (PST)
In-Reply-To: <4D3997FE.5030109@vollmann.ch>
X-CRM114-Version: 20090807-BlameThorstenAndJenny ( TRE 0.7.6 (BSD) )
	MR-646709E3 
X-CRM114-CacheID: sfid-20110121_093041_866170_E3D8B02E 
X-CRM114-Status: GOOD (  18.19  )
X-Spam-Score: -0.8 (/)
X-Spam-Report: SpamAssassin version 3.3.1 on canuck.infradead.org summary:
	Content analysis details:   (-0.8 points)
	pts rule name              description
	---- ----------------------
	--------------------------------------------------
	-0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at http://www.dnswl.org/,
	low trust [209.85.161.49 listed in list.dnswl.org]
	0.0 FREEMAIL_FROM Sender email is freemail (ruifeihuang[at]gmail.com)
	0.0 HTML_MESSAGE           BODY: HTML included in message
	-0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
	author's domain
	0.1 DKIM_SIGNED            Message has a DKIM or DK signature,
	not necessarily valid
	-0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
X-Mailman-Approved-At: Sat, 22 Jan 2011 16:18:43 -0500
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165417>

--===============2061661870==
Content-Type: multipart/alternative; boundary=20cf30434544110913049a5c1819

--20cf30434544110913049a5c1819
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

not a lucky dog. i used 1.6.0,there was a large pack.

On 21 January 2011 22:28, Detlef Vollmann <dv@vollmann.ch> wrote:

> On 01/21/11 14:57, Russell King - ARM Linux wrote:
>
>> On Fri, Jan 21, 2011 at 02:47:28PM +0100, Uwe Kleine-K=F6nig wrote:
>>
>>> Hi Detlef,
>>>
>>> On Fri, Jan 21, 2011 at 02:38:11PM +0100, Detlef Vollmann wrote:
>>>
>>>> On 01/16/11 14:42, Russell King - ARM Linux wrote:
>>>>
>>>>> Let's say you already have a copy of my tree from a month ago, and
>>>>> Linus
>>>>> has pulled some work from me into his tree, and repacked his tree int=
o
>>>>> one
>>>>> single pack file.  At the moment, the largest pack file from Linus is
>>>>> 400MB plus a 50MB index.
>>>>>
>>>>> You already have most of the contents of that 400MB pack file, but if
>>>>> you're missing even _one_ object which is contained within it, git wi=
ll
>>>>> have to download the _entire_ 400MB pack file and index file to
>>>>> retrieve
>>>>> it.
>>>>>
>>>> I thought this has changed with "smart http" in git 1.6.6.
>>>> Am I missing something?
>>>>
>>> Well, not all http repos offer smart http.  E.g. Russell doesn't[1],
>>> probably because the serving machine doesn't have the power to nice
>>> serve a repo via git:// or smart http://.
>>>
>>
>> What is smart http?  I don't particularly follow git developments.
>>
> It seems to be an implementation of the git protocol using
> HTTP as transport.
> Some info on this is at <http://progit.org/2010/03/04/smart-http.html>.
>
>  Detlef
>
>


--=20
JUST DO IT,NOTHING IS IMPOSSIBLE

--20cf30434544110913049a5c1819
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf-8=
">not a lucky dog. i used 1.6.0,there was a large pack.<div><br></div><div =
class=3D"gmail_quote">On 21 January 2011 22:28, Detlef Vollmann <span dir=
=3D"ltr">&lt;<a href=3D"mailto:dv@vollmann.ch">dv@vollmann.ch</a>&gt;</span=
> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div><div></div><div class=3D"h5">On 01/21/=
11 14:57, Russell King - ARM Linux wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Fri, Jan 21, 2011 at 02:47:28PM +0100, Uwe Kleine-K=F6nig wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi Detlef,<br>
<br>
On Fri, Jan 21, 2011 at 02:38:11PM +0100, Detlef Vollmann wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 01/16/11 14:42, Russell King - ARM Linux wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Let&#39;s say you already have a copy of my tree from a month ago, and Linu=
s<br>
has pulled some work from me into his tree, and repacked his tree into one<=
br>
single pack file. =A0At the moment, the largest pack file from Linus is<br>
400MB plus a 50MB index.<br>
<br>
You already have most of the contents of that 400MB pack file, but if<br>
you&#39;re missing even _one_ object which is contained within it, git will=
<br>
have to download the _entire_ 400MB pack file and index file to retrieve<br=
>
it.<br>
</blockquote>
I thought this has changed with &quot;smart http&quot; in git 1.6.6.<br>
Am I missing something?<br>
</blockquote>
Well, not all http repos offer smart http. =A0E.g. Russell doesn&#39;t[1],<=
br>
probably because the serving machine doesn&#39;t have the power to nice<br>
serve a repo via git:// or smart http://.<br>
</blockquote>
<br>
What is smart http? =A0I don&#39;t particularly follow git developments.<br=
>
</blockquote></div></div>
It seems to be an implementation of the git protocol using<br>
HTTP as transport.<br>
Some info on this is at &lt;<a href=3D"http://progit.org/2010/03/04/smart-h=
ttp.html" target=3D"_blank">http://progit.org/2010/03/04/smart-http.html</a=
>&gt;.<br><font color=3D"#888888">
<br>
 =A0Detlef<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>JUST DO IT,NOTHI=
NG IS IMPOSSIBLE<br>

--20cf30434544110913049a5c1819--


--===============2061661870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2061661870==--

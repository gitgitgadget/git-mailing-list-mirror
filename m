From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re: [PATCH 0/3] Win32: nanosecond-precision file times
Date: Thu, 12 Feb 2015 23:30:51 +0100
Organization: gmx
Message-ID: <db4e2b740bef943fb1adaf2b22893136@www.dscho.org>
References: <54DBEAA5.6000205@gmail.com>
 <xmqqbnkysygl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Karsten Blees <karsten.blees@gmail.com>, Git List <git@vger.kernel.org>,
 msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCZPH74Q5YNRBIOT6STAKGQE5PA54KI@googlegroups.com Thu Feb 12 23:31:00 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBIOT6STAKGQE5PA54KI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f57.google.com ([209.85.215.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBIOT6STAKGQE5PA54KI@googlegroups.com>)
	id 1YM2Hj-0006xO-Tq
	for gcvm-msysgit@m.gmane.org; Thu, 12 Feb 2015 23:30:59 +0100
Received: by labgm9 with SMTP id gm9sf3205078lab.1
        for <gcvm-msysgit@m.gmane.org>; Thu, 12 Feb 2015 14:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:content-transfer-encoding:date:from:to:cc
         :subject:organization:in-reply-to:references:message-id:user-agent
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=t8mH2rztTJrVF/fCjClGDau+dVtt5dqj9UfRSLudvVU=;
        b=kYed96r+QrPDaicDdv5am/tlRsHZyFw/MH14+ob2Fjo+dU5MndPR9I6wLp7iJGxQzo
         nahAt9RCI7QR8wD1+Evfi8s0KWrDtp90XiG8m9rOcrUOYoQAK/WDibqpy9vaJQSG+Kxw
         hC1BKff3BgWG46GmVBJgwfN5ASwTeJMn9OBWo9e5V1ngKjt+zAiVrH0wnCekH8MxfJL5
         F45kBERArNhT3LsvAPpJOXuZ4M6S9+yhSagJv28kuF29YAHnPXoe6wRTYO0D2YcBi62w
         AC3wYr1wZz+s7TXM3vdD4qM8aH5sHWYde8JLi9nyDeXv0CQSu1R7RPW2AZwcKuhG1h9P
         4G1Q==
X-Received: by 10.180.77.116 with SMTP id r20mr57880wiw.5.1423780259587;
        Thu, 12 Feb 2015 14:30:59 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.181.11.198 with SMTP id ek6ls206107wid.27.gmail; Thu, 12 Feb
 2015 14:30:57 -0800 (PST)
X-Received: by 10.180.105.228 with SMTP id gp4mr840071wib.6.1423780257448;
        Thu, 12 Feb 2015 14:30:57 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.20])
        by gmr-mx.google.com with ESMTPS id o9si2897012wiw.0.2015.02.12.14.30.57
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2015 14:30:57 -0800 (PST)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.20 as permitted sender) client-ip=212.227.17.20;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MKYpv-1YLDTA2TJ9-001xnh; Thu, 12 Feb 2015 23:30:51
 +0100
In-Reply-To: <xmqqbnkysygl.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:9I8Qk4PgZSNXsr+ZTPg+oNQznqkLlSJ6G2atcS03TYeu3F0BpXg
 LmkPPhjEs+S/F811Lsh3LxCzqGD1jpprzqW2KR5WMNzCXgw7rOhiCrPjhcFnwVuSCkglnQh
 rF700WT1rreLNDOp+LfLhxb53bmRZ8IFhc+09dJAZVE5YJYAm02ry9hQJ6T0g3cmVsWAmJC
 LYhIMv6zurDrRfeer5Rsw==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.20 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263775>

Hi,

On 2015-02-12 20:48, Junio C Hamano wrote:
> Karsten Blees <karsten.blees@gmail.com> writes:
>=20
>> This patch series was inspired by the problem that Git does not
>> detect changed file content if st_size, st_mtime and st_ctime
>> are unchanged. This was apparently caused by VSS2Git resetting
>> mtime to a value in the past. [1]
>>
>> I believe (or rather hope) that all involved in the discussion
>> agree that Git cannot reasonably be expected to detect changed
>> file content if file time(s) are reset on purpose.
>>
>> However, some users have expressed concerns that 'same size and
>> mtime' [2] may theoretically happen by chance in daily operation.
>=20
> Hmph.
>=20
> Haven't we already accepted that it is not just "may theoretically
> happen" and had counter-measures in racy-git detection machinery
> for quite some time?

I agree that the "racy-git" reference is more of a red herring; it appears =
that the report Karsten referred to is based on a different understanding o=
f the mtime than mine (it is purported that the mtime of a file should refl=
ect the time when it entered the repository, rather than the time when the =
file was written to disk).

Please let that not distract you.

This patch series has merits on the basis of populating st_mtim.tv_nsec alr=
eady. We can provide this information in the common case (i.e. NTFS, *not* =
FAT), so we should.

Ciao,
Dscho

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

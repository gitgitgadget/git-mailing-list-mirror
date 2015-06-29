From: =?UTF-8?Q?Stefan_N=c3=a4we?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: 4th release candidate of Git for Windows 2.x, was Re:
 3rd release candidate of Git for Windows 2.x
Date: Mon, 29 Jun 2015 16:49:24 +0200
Message-ID: <55915AF4.5000808@atlas-elektronik.com>
References: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
 <b085dab2e617742b690ccb99ba4a3076@www.dscho.org>
 <8224736a18724f751312d57e67967d69@www.dscho.org>
 <55910AE7.3000206@atlas-elektronik.com>
 <426859781bd04ca4ebb13719350537ed@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Git Mailing List <git@vger.kernel.org>,
	"msysgit@googlegroups.com" <msysgit@googlegroups.com>,
	"git-for-windows@googlegroups.com" <git-for-windows@googlegroups.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: msysgit+bncBDK4H2WVWYLBBAVWYWWAKGQETHXUN5I@googlegroups.com Mon Jun 29 16:49:39 2015
Return-path: <msysgit+bncBDK4H2WVWYLBBAVWYWWAKGQETHXUN5I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f192.google.com ([209.85.212.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDK4H2WVWYLBBAVWYWWAKGQETHXUN5I@googlegroups.com>)
	id 1Z9aNO-0004Zi-Lx
	for gcvm-msysgit@m.gmane.org; Mon, 29 Jun 2015 16:49:38 +0200
Received: by wivz2 with SMTP id z2sf13761071wiv.0
        for <gcvm-msysgit@m.gmane.org>; Mon, 29 Jun 2015 07:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=subject:to:references:cc:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-spam-checked-in-group:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe;
        bh=sv20ECq/cQK7QLePg3HhlJH8S6M+UJ+8WCGrkOjPwtY=;
        b=a8wTlGgiJcqQsizCf/yn/Rm1pFxBK5OXc0gFom+XKiGR3rlS/2zEWmSQMTR5IiVBnz
         RwZ5jmvIJknUn7zQtyn5GQ0WZO3i976SF3HiplGZAWHL4GTZK4TOCpzmBkmaUJA+Vodc
         8cE/WkNd3Sl4FFQsZoUlkbNyfVYiQJo3iHTlAv5BunLtScVVP8V2MQxrCYn6X7mS0RGC
         cy8mVqyZfsfGalTaWAr4A5pQMPPcoSBx0PIJJgF2R2w8rfmEEq64ygwirhSC6xhZyPX3
         T1PMqnHiLofdqqJB++1aEU7HXR18OfU/YwrnUmgnDhOAylnhgKSMQEkst1dGFfQTBrA5
 
X-Received: by 10.180.205.137 with SMTP id lg9mr63389wic.18.1435589378391;
        Mon, 29 Jun 2015 07:49:38 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.94.10 with SMTP id cy10ls602924wib.25.gmail; Mon, 29 Jun
 2015 07:49:37 -0700 (PDT)
X-Received: by 10.180.90.106 with SMTP id bv10mr8838368wib.6.1435589377737;
        Mon, 29 Jun 2015 07:49:37 -0700 (PDT)
Received: from mail96.atlas.de (mail96.atlas.de. [194.156.172.86])
        by gmr-mx.google.com with ESMTPS id ec7si414095wib.3.2015.06.29.07.49.37
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 07:49:37 -0700 (PDT)
Received-SPF: neutral (google.com: 194.156.172.86 is neither permitted nor denied by best guess record for domain of stefan.naewe@atlas-elektronik.com) client-ip=194.156.172.86;
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 34BE910121;
	Mon, 29 Jun 2015 16:49:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lvNNieyvJSKp; Mon, 29 Jun 2015 16:49:26 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Mon, 29 Jun 2015 16:49:26 +0200 (CEST)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 3930F27169;
	Mon, 29 Jun 2015 16:49:25 +0200 (CEST)
Received: from [10.200.54.122] (10.200.54.122) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server (TLS) id 8.3.327.1; Mon, 29 Jun
 2015 16:49:25 +0200
Openpgp: id=2DF5E01B09C37501BCA99666829B49C5922127AF
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
In-Reply-To: <426859781bd04ca4ebb13719350537ed@www.dscho.org>
X-Original-Sender: stefan.naewe@atlas-elektronik.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 194.156.172.86 is neither permitted nor denied by best guess
 record for domain of stefan.naewe@atlas-elektronik.com) smtp.mail=stefan.naewe@atlas-elektronik.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272953>

Am 29.06.2015 um 16:37 schrieb Johannes Schindelin:
> Hi Stefan,
>=20
> On 2015-06-29 11:07, Stefan N=C3=A4we wrote:
>> Am 29.06.2015 um 10:30 schrieb Johannes Schindelin:
>=20
>>> I just uploaded the 4th release candidate for the upcoming Git for
>>> Windows 2.x release. Please find the download link here:
>>>
>>> https://git-for-windows.github.io/#download
>>>
>>> The most important changes are the update to Git 2.4.5 and a fix for th=
e crash when running Git Bash
>>> with a legacy `TERM` setting (this should help 3rd party software to up=
grade to Git for Windows 2.x).
>>
>> Thanks.
>> It seems that this link:
>>
>>    https://github.com/git-for-windows/git/releases/latest
>>
>> doesn't point to the latest release.
>>
>> Might be because the tags have the same date ?
>=20
> Wooops. Sorry for being so slow (been interviewing today). It should be c=
orrect now, can you verify, please?

Yes.

https://github.com/git-for-windows/git/releases/latest
redirects to "Fourth release candidate of Git for Windows 2.x" now.

Thanks,
  Stefan
--=20
----------------------------------------------------------------
/dev/random says: Documentation is the castor oil of programming.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696=
b2e636f6d'.decode('hex')"=20
GPG Key fingerprint =3D 2DF5 E01B 09C3 7501 BCA9  9666 829B 49C5 9221 27AF

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

From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re: [PATCH bc/connect-plink] t5601-clone: remove broken
 and pointless check for plink.exe
Date: Thu, 13 Aug 2015 10:37:05 +0200
Organization: gmx
Message-ID: <77beda92482eca76cdb0c7ee3743945f@www.dscho.org>
References: <55CA6066.5070500@kdbg.org>
 <866a41f50ef9b4807da72576a4bca717@www.dscho.org>
 <CABPQNSZHtAKbe6JwxRoK3LpCabfp6r2_kTmF1qokObt_yKnSDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Johannes Sixt <j6t@kdbg.org>, Git Mailing List <git@vger.kernel.org>,
 msysGit <msysgit@googlegroups.com>
To: kusmabite@gmail.com
X-From: msysgit+bncBCZPH74Q5YNRBM5OWGXAKGQEQKT5K5Y@googlegroups.com Thu Aug 13 10:37:17 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBM5OWGXAKGQEQKT5K5Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f185.google.com ([209.85.212.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBM5OWGXAKGQEQKT5K5Y@googlegroups.com>)
	id 1ZPo0f-0003Y5-Kb
	for gcvm-msysgit@m.gmane.org; Thu, 13 Aug 2015 10:37:13 +0200
Received: by wicul11 with SMTP id ul11sf10524249wic.0
        for <gcvm-msysgit@m.gmane.org>; Thu, 13 Aug 2015 01:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:content-transfer-encoding:date:from:to:cc
         :subject:organization:in-reply-to:references:message-id:user-agent
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-spam-checked-in-group:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe;
        bh=MG47SmyB/504CWyhiRcL8AEQA/AM8BEEfTJZev6ube0=;
        b=H5rYTrtt+DRMG3bX60MXR4orR2OWUrJfu13IU8BKVuu2ZWLjTv/E3i/WVXA83zc4KH
         xUid6ieRzRtLKBEdUkhXIzp8AHU6+C48d37bzuqJsGFUppGuxycL3oBMD8axG71GshoH
         Wljs74ZoI5Qyc9NN3xDi5ttswxHK2wYt9rIEPt6cuOUymH3OWnFauuUVOI5gDz3OGDJk
         vRaKCyL4E/Q6lL+wSFNKIcf5h67VumDnJBJKoOzKc9XtxiaHSWRYXXlM+DcyZcbE0czz
         FGuh57X5/t2PvAubAFqwVnJMt8AewSuC4ssZ2OUs9pU4CWOQaa+KEEMQWjR0YA6Y 
X-Received: by 10.152.234.203 with SMTP id ug11mr257611lac.4.1439455028273;
        Thu, 13 Aug 2015 01:37:08 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.21.194 with SMTP id x2ls147494lae.33.gmail; Thu, 13 Aug
 2015 01:37:07 -0700 (PDT)
X-Received: by 10.112.54.166 with SMTP id k6mr10955263lbp.0.1439455027352;
        Thu, 13 Aug 2015 01:37:07 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id c3si49741wiz.2.2015.08.13.01.37.07
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2015 01:37:07 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lzc5y-1YmqIN3Sq2-014jEc; Thu, 13 Aug 2015 10:37:05
 +0200
In-Reply-To: <CABPQNSZHtAKbe6JwxRoK3LpCabfp6r2_kTmF1qokObt_yKnSDg@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:XOV4doDALiXgmzQU3bmNBLkUo7Kij966c23Sm+ywYeSBpbFehNA
 81oBAEoyylt/3N2RLCX281zL7HnxBYr9vXSc6FXggGfiaQxNl9ZjGRLNlmYRfZ0v/lbqJ6L
 1LTKyi6cpoqmElJmr5RL6jYwnfdxW2bjgaqZ8FddxeYOBbGLR8Jom5qi1Tz84kpby+YaNbn
 UU/XORa0wasZ3ta5foMVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KPU4xI6/EBc=:3EsFDLnnWQTNTuBfj+8mBh
 NdjHCeyj+IauW8sUOb1Z4j+y/rcn5ywD/GR5yKjYvStzM3SuLrPtUY37gtGeTW1nZDqHSJ1ZN
 CaUnYWf70zjPyhYaGkJmm81uB68yHCGL4DqOdeEguakVy2bvhqvBiNuagp8cqiBpSP0azG0ub
 7PPEVdUS7awZp+LAveVOBY8p7JFpZ9rLH3XnHFOl4ONaDnvJ6yvB1LoRg0bx9QgO0Ly3pVFSw
 vwwtRrI3rMQbTa9faiqBVLpapovneft2boycNxkWujfv/nf6ZlNTrOzuf0xehfV9VahVqbXKr
 PGrHoEZrngndDhXnF7S7kOiQXwpctV0T8DQhVBgiG+SXEaGlA0BiGU6rsST2+kRVq6Wsab5S0
 HDnol4AazTk4Ki3+KyNJGK+b1d/n/bzxPNLE1G0sOHIsewt6Ln9qvPJ03mr+mkWwfufCjB77U
 TjAfSMnZB8IAa+9u50c991lZbx//PL30tA/Jui4XFRWucwLV3dF4cHmyofT4ekmNsFqYZ1PYn
 GBWClPDMnUnhDeNeGWVrUG+4NmhWGRXWrjwaIbRwgZU6abj3YaJ7P+xSW0zYPp7W5wtncZPhJ
 tyaOoz4RYg7IA/etnG2VJGI3kdwS2lhm6IsUpzInHUShV4NtHQh9KcDAgT7cofkElQT8Z61r1
 NiOI1/gnLkRQBkmXkFhuv1Oq8EasMBHV3HIlJqQbW4W+R8a5stOoizZ5DCWcBC/DrtlQhf1v9
 o9fDMGf6GkjYDBqchWdPZVJL39kBO9cxmNSx8w==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.15 as
 permitted sender) smtp.mailfrom=johannes.schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275838>

Hi kusma,

On 2015-08-12 13:58, Erik Faye-Lund wrote:
> On Wed, Aug 12, 2015 at 1:07 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>>
>> On 2015-08-11 22:51, Johannes Sixt wrote:
>>> Invoking plink requires special treatment, and we have support and even
>>> test cases for the commands 'plink' and 'tortoiseplink'. We also suppor=
t
>>> .exe variants for these two and there is a test for 'plink.exe'.
>>>
>>> On Windows, however, where support for plink.exe would be relevant, the
>>> test case fails because it is not possible to execute a file with a .ex=
e
>>> extension that is actually not a binary executable---it is a shell
>>> script in our test. We have to disable the test case on Windows.
>>
>> Oh how would I wish you were working on Git for Windows even *just* a bi=
t *with* me. At least I would wish for a more specific description of the d=
evelopment environment, because it sure as hell is not anything anybody can=
 download and install as easily as Git for Windows' SDK.
>>
>> FWIW Git for Windows has this patch (that I wanted to contribute in due =
time, what with being busy with all those tickets) to solve the problem men=
tioned in your patch in a different way:
>>
>> https://github.com/git-for-windows/git/commit/2fff4b54a0d4e5c5e2e4638c9b=
0739d3c1ff1e45
>=20
> Yuck. On Windows, it's the extension of a file that dictates what kind
> of file it is (and if it's executable or not), not the contents.

Careful. If you continue along those lines, interactive rebase, `git add -p=
` and all those wonderful scripts Git has will have to stop working.

Because those scripts completely disagree with what you just said about Win=
dows if you think about it: *none* of them has an extension.

I know that you do not mean this, of course, but that is the argument you w=
ere making... ;-)

> If we get a shell script written with the ".exe"-prefix, it's considered =
as
> an invalid executable by the system.

And if we get a shell script without any `.exe` suffix, it is still conside=
red as an invalid executable by the system. And even if we tack on an `.sh`=
 suffix (which is *not* in line with the way Git works), it is *still* cons=
idered as an invalid executable by the system.

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

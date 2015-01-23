From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Re: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT
Date: Fri, 23 Jan 2015 07:00:53 +0100
Message-ID: <54C1E395.30003@web.de>
References: <20150114211712.GE1155@peff.net>	<064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>	<xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>	<20150115222719.GA19021@peff.net>	<xmqqa91j6537.fsf@gitster.dls.corp.google.com>	<20150115235752.GB25120@peff.net>	<xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>	<20150116013256.GA25894@peff.net>	<BEFF558C-774D-4891-96A0-BE962F8070E7@gmail.com>	<20150116033445.GA29572@peff.net> <20150116091648.GA2450@peff.net>	<xmqqfvba37bq.fsf@gitster.dls.corp.google.com>	<xmqqzj9i1rci.fsf@gitster.dls.corp.google.com> <54BAF1C2.60103@web.de>	<xmqq61bzwyqp.fsf@gitster.dls.corp.google.com>	<54C170E9.4010401@web.de> <xmqqlhkusc4h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>, 
 msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?=
 =?UTF-8?B?c2Vu?= <tboegi@web.de>
X-From: msysgit+bncBCUZ3EUT2ADRBGWHQ6TAKGQEEUC7F3A@googlegroups.com Fri Jan 23 07:00:59 2015
Return-path: <msysgit+bncBCUZ3EUT2ADRBGWHQ6TAKGQEEUC7F3A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f192.google.com ([74.125.82.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCUZ3EUT2ADRBGWHQ6TAKGQEEUC7F3A@googlegroups.com>)
	id 1YEXIg-0007rn-U6
	for gcvm-msysgit@m.gmane.org; Fri, 23 Jan 2015 07:00:58 +0100
Received: by mail-we0-f192.google.com with SMTP id u56sf442713wes.9
        for <gcvm-msysgit@m.gmane.org>; Thu, 22 Jan 2015 22:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=q2fs6hTuSI5ofWor7UFXWm/sPgjLyh+uvWKciDaxhuk=;
        b=CYYzi953s/3uR/1nDIXQTt5SUdDk4F11vRWtK5laO2V9hBiP5WYMcqaecJ7g3aSXDz
         JiohBxSvSWmRYfSoL1p8oo4eBqxEDLnPApYulOH7BfK5/hXPv9H9mnlndazf+wuNzq5J
         DbWVWL/vwnplVJGhPjKTH2t5MoQq/vN3CDEwKUOHegY1mvIvXWmw93r6ACbnogNJJVfe
         4svgWpbm826lhDFshTVhlnbwFhAz9ua90LGrJCZ+iPJZ2DvfHxBn0ZTeL+r2T49bQjhr
         ZHg/vZybPoYGUv03FuVRFhQ+yG4hsF5eHo6vgU+v9joTfv15OKNvltv8G5qh3nTCL0+k
         MbRg==
X-Received: by 10.180.79.10 with SMTP id f10mr860wix.8.1421992858587;
        Thu, 22 Jan 2015 22:00:58 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.99.9 with SMTP id em9ls37320wib.12.gmail; Thu, 22 Jan 2015
 22:00:57 -0800 (PST)
X-Received: by 10.194.86.1 with SMTP id l1mr740828wjz.0.1421992857817;
        Thu, 22 Jan 2015 22:00:57 -0800 (PST)
Received: from mout.web.de (mout.web.de. [212.227.17.11])
        by gmr-mx.google.com with ESMTPS id s6si27644wif.0.2015.01.22.22.00.57
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jan 2015 22:00:57 -0800 (PST)
Received-SPF: pass (google.com: domain of tboegi@web.de designates 212.227.17.11 as permitted sender) client-ip=212.227.17.11;
Received: from macce.local ([78.68.171.36]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0Mf0pJ-1Y3DZs2lJJ-00OatJ; Fri, 23 Jan 2015 07:00:53
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqlhkusc4h.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:D0+P5ssaSym44Lfz6Iqw1yun7MX5PoN9KR3hqhYQsCSLtKDinXM
 PluGs2g/GRu6GSmRvAokj/4ct4RC4PH6R2BqstR7VEOdoIA+R+x/556K4ZE+QCHBHXN+KoG
 AGUgvEnvH0dGO9c/QErUsgrXPA4XXQPLaGc20ZZsFqAlHaD5VEDlb593w1NwT5zQY/2BJ5l
 i+k6onFsr2JBIWovJCfgg==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: tboegi@web.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of tboegi@web.de designates 212.227.17.11 as permitted
 sender) smtp.mail=tboegi@web.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262901>

On 2015-01-22 23.07, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> If I run that sequence manually:
>> chmod 755 .
>> touch x
>> chmod a-w .
>> rm x
>> touch y
>>
>> x is gone, (but shoudn't according to POSIX)
>> y is not created, "access denied"
>=20
> Good (or is that Sad?).
It feels that this is by design:
In old days under MS/DOS the only way to hinder people
from deleting a file was to make it "read only" with help
of the ATTRIB command.
https://en.wikipedia.org/wiki/ATTRIB

Later NTFS introduced the (ACL like) secutity information,
and (unless I am completely wrong) the "delete file" is part
of the "modify" permission, not write.
>=20
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -1039,7 +1039,17 @@ test_lazy_prereq NOT_ROOT '
>>  # When the tests are run as root, permission tests will report that
>>  # things are writable when they shouldn't be.
>>  test_lazy_prereq SANITY '
>> -       test_have_prereq POSIXPERM,NOT_ROOT
>> +       mkdir ds &&
>> +       touch ds/x &&
>> +       chmod -w ds &&
>> +       if rm ds/x
>> +       then
>> +               chmod +w ds
>> +               false
>> +       else
>> +               chmod +w ds
>> +               true
>> +       fi
>>  '
>=20
> It looks like a better approach overall.
>=20
> Because we cannot know where $(pwd) is when lazy prereq is evaluated
> (it typically is at the root of the trash hierarchy, but not always)
> and we would not want to add, leave or remove random files in the
> working tree that are not expected by the tests proper (e.g. a test
> that counts untracked paths are not expecting ds/ to be there), your
> actual "fix" may need to be a bit more careful, though.
>=20
> Thanks.
>=20
So true, what is a better place or way to run the test ?
Can we use /tmp  (Which may be a different file system)?
Or can we use $HOME/$$ds (Which is an artificial HOME)

We already "pollute" the $PWD here
test_lazy_prereq CASE_INSENSITIVE_FS '
  	echo good >CamelCase &&
	echo bad >camelcase &&
	test "$(cat CamelCase)" !=3D good
'
and here:
test_lazy_prereq UTF8_NFD_TO_NFC '
....

Would=20
mkdir $HOME/ds
be a better approach then ?

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

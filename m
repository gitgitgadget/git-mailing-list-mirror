From: =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>
Subject: Re: 1.7.9, libcharset missing from EXTLIBS
Date: Fri, 10 Feb 2012 11:21:17 +0100
Message-ID: <4F34EF9D.8030509@aegee.org>
References: <4F3472F4.4060605@aegee.org> <7v1uq3toyq.fsf@alter.siamese.dyndns.org> <CACBZZX45=mr=FMqFF+Pw4KPaDAtvs-ePLbFATpyFA93vSfZatw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080006090705000006030208"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 11:21:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvnbo-0007Pp-Ca
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 11:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758821Ab2BJKV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 05:21:28 -0500
Received: from mailout-aegee.scc.kit.edu ([129.13.185.235]:59498 "EHLO
	mailout-aegee.scc.kit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173Ab2BJKV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 05:21:28 -0500
Received: from smtp.aegee.org (aegeeserv.aegee.uni-karlsruhe.de [129.13.131.80])
	by scc-mailout-02.scc.kit.edu with esmtp (Exim 4.72 #1)
	id 1RvnbX-0001Qt-DB; Fri, 10 Feb 2012 11:21:23 +0100
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
Received: from [192.168.2.104] (p4FDCFE97.dip.t-dialin.net [79.220.254.151])
	(authenticated bits=0)
	by smtp.aegee.org (8.14.5/8.14.5) with ESMTP id q1AALQdo026266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Fri, 10 Feb 2012 10:21:27 GMT
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <CACBZZX45=mr=FMqFF+Pw4KPaDAtvs-ePLbFATpyFA93vSfZatw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.97.3 at aegeeserv
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190399>

This is a multi-part message in MIME format.
--------------080006090705000006030208
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

>> What platform is this?  Is there a guarantee that any and all system that
>> use "#include<libcharset.h>" has to link with "-lcharset"?
>
> I've had some similar (privately sent) bug reports about the i18n
> stuff from someone who built his own Linux distro.

I run Linux from scratch.

>> What I am wondering is there are systems that need to include the header,
>> but locale_charset() does not live in /lib/libcharset.a, in which case we
>> cannot make HAVE_LIBCHARSET_H imply use of -lcharset.

I do not understand this.  If you want to use a function from 
libcharset, you have to use both #include <libcharset.h> and -lcharset.

Със здраве
   Дилян

On 10.02.2012 11:06, Ævar Arnfjörð Bjarmason wrote:
> 2012/2/10 Junio C Hamano<gitster@pobox.com>:
>> Дилян Палаузов<dilyan.palauzov@aegee.org>  writes:
>>
>>> Hello,
>>>
>>> git 1.7.9 makes use of libcharset and /Makefile contains:
>>>
>>> ifdef HAVE_LIBCHARSET_H
>>>          BASIC_CFLAGS += -DHAVE_LIBCHARSET_H
>>> endif
>>> ...
>>> and the problem is, that libcharset is not used when linking.  To
>>> solve this, please replace the above extract from /Makefile with
>>>
>>> ifdef HAVE_LIBCHARSET_H
>>>          BASIC_CFLAGS += -DHAVE_LIBCHARSET_H
>>>        EXTLIBS += -lcharset
>>> endif
>>
>> Thanks.
>>
>> What platform is this?  Is there a guarantee that any and all system that
>> use "#include<libcharset.h>" has to link with "-lcharset"?
>>
>> What I am wondering is there are systems that need to include the header,
>> but locale_charset() does not live in /lib/libcharset.a, in which case we
>> cannot make HAVE_LIBCHARSET_H imply use of -lcharset.
>
> I've had some similar (privately sent) bug reports about the i18n
> stuff from someone who built his own Linux distro.
>
> Basically we make assumptions that certain stuff will be in the C
> library on certain platforms, certain headers go with certain
> libraries etc.
>
> Evidently none of this can really be relied upon and we'd have to
> probe for each one if we wanted to make it reliable.

--------------080006090705000006030208
Content-Type: text/x-vcard; charset=utf-8;
 name="dilyan_palauzov.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dilyan_palauzov.vcf"

YmVnaW46dmNhcmQNCmZuO3F1b3RlZC1wcmludGFibGU6PUQwPTk0PUQwPUI4PUQwPUJCPUQx
PThGPUQwPUJEID1EMD05Rj1EMD1CMD1EMD1CQj1EMD1CMD1EMT04Mz1EMD1CNz1EMD1CRT0N
Cgk9RDA9QjINCm47cXVvdGVkLXByaW50YWJsZTtxdW90ZWQtcHJpbnRhYmxlOj1EMD05Rj1E
MD1CMD1EMD1CQj1EMD1CMD1EMT04Mz1EMD1CNz1EMD1CRT1EMD1CMjs9RDA9OTQ9RDA9Qjg9
RDA9QkI9RDE9OEY9RDA9QkQNCmVtYWlsO2ludGVybmV0OmRpbHlhbi5wYWxhdXpvdkBhZWdl
ZS5vcmcNCnRlbDtob21lOis0OS03MjEtOTQxOTMyNzANCnRlbDtjZWxsOis0OS0xNjItNDA5
MTE3Mg0Kbm90ZTpzaXA6ODM3MkBhZWdlZS5vcmcNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQN
Cg0K
--------------080006090705000006030208--

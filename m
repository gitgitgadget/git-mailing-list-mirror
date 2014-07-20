From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 2/3] wrapper: add xgetcwd()
Date: Sun, 20 Jul 2014 17:22:41 +0200
Message-ID: <53CBDEC1.7010800@web.de>
References: <53CBA59C.8050901@web.de> <53CBA640.1010601@web.de> <CACsJy8BUaAkO8_fjGCtVDyoSKkBQ+VKJLtjN_HZfV7XHOnS_yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 17:23:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8sxC-0002FT-Ds
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 17:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbaGTPXH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2014 11:23:07 -0400
Received: from mout.web.de ([212.227.15.3]:55948 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbaGTPXF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 11:23:05 -0400
Received: from [192.168.178.27] ([79.253.172.97]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MddXQ-1WuUGH1hBE-00POyc; Sun, 20 Jul 2014 17:23:01
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CACsJy8BUaAkO8_fjGCtVDyoSKkBQ+VKJLtjN_HZfV7XHOnS_yA@mail.gmail.com>
X-Provags-ID: V03:K0:fH9M/0sbBw7KeUpDqI9KFTU2XtdGFqcqe0/puTmHXc4qyfXqTYa
 555FHHQoTEDYW7n4587p0KwvCPqb5yidjGZxvp7AOvc2YtXckb8gc6PjU8e52o6E3Y9P0WW
 BUlZuSmYclmCkCvRm1sm1FNirioSK/rATXWPZsiZD8wW2Rbb940oUUjiJVNIV/JflxIHUlz
 4bWDyXDGR1vwFgmSrC31g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253928>

Am 20.07.2014 14:35, schrieb Duy Nguyen:
> On Sun, Jul 20, 2014 at 6:21 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
>> +char *xgetcwd(void)
>> +{
>> +       struct strbuf sb =3D STRBUF_INIT;
>> +       if (strbuf_add_cwd(&sb))
>> +               die_errno("unable to get current working directory")=
;
>
> Wrap the string with _() to make it translatable? I can't see why any
> script would want to grep this string..

Sure, good idea.

>
>> +       return strbuf_detach(&sb, NULL);
>> +}

Thank you for the review,
Ren=C3=A9

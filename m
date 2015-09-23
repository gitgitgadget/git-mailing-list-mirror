From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v7 0/7] git-p4: add support for large file systems
Date: Wed, 23 Sep 2015 13:42:43 +0200
Message-ID: <F05CC31A-ECE2-41E4-9805-F1747DD02713@gmail.com>
References: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com> <CAE5ih7_PBRMgobhBATUMOaRH8yPWWnEVDiFVdk+qjRzoyPq+CQ@mail.gmail.com> <CE59FE83-4EE1-41EF-85B6-63EA51BD9E3B@gmail.com> <A29B974F-2B42-475F-92B6-8B25A54FCDEE@gmail.com> <CAE5ih7-NqSd+zSqTungDt5oWzy4QT--vjYaShd=YDzGxHosz3A@mail.gmail.com> <ECBECF84-28A9-4E10-907C-8E670F864A25@gmail.com> <CAE5ih7_StiXA-c5yER9jhc941vsKfvEUONLXQ4E7JANOhCxMxQ@mail.gmail.com> <CAE5ih7_m050wcWZ+7UvL3GscKgSxLWGT+bj4_gSVA8R7RZm=tg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Sep 23 13:43:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeiS1-0003wY-0s
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 13:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754313AbbIWLms convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Sep 2015 07:42:48 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34960 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467AbbIWLmr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Sep 2015 07:42:47 -0400
Received: by wicge5 with SMTP id ge5so203323988wic.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 04:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LX+ZVhQVyz5bp6eTbTBNgLUB+W+x3MjUAnxV8zPm2Gc=;
        b=VgchZaJ2K53yMWpHiTNv+uNtqvKMg8D5MCqUDgRzknlSPsK9hSeD6e5iYG0tsXLzPp
         qMNSGmhHBM3ejfyfMBR1yknxHEi6HCyg3JX0kkomj4QpjC6Gpg97WWQKZWUFJtAWjEx6
         5AhnwdDyq2Qy1SdCYQeSya6OtMTb0oBW8qaoegeNg66uaG+XfqHlL9sz/vgpXhCyauPe
         Takdu4wUIYyzwYqOuvIJ1EL33x/QCAFumEkpS0sCVXOm+bQqkCzoKzSHhxidgjqiAOpk
         XGDnE4qo8RmirLpm+1hPNMCBujdfrCiaY9mEJQsd+E2LK6GJRzXR5ecRnLncoeu8MbCC
         pbrA==
X-Received: by 10.180.186.98 with SMTP id fj2mr3825887wic.58.1443008566141;
        Wed, 23 Sep 2015 04:42:46 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id go2sm8150861wib.20.2015.09.23.04.42.45
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Sep 2015 04:42:45 -0700 (PDT)
In-Reply-To: <CAE5ih7_m050wcWZ+7UvL3GscKgSxLWGT+bj4_gSVA8R7RZm=tg@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278484>


On 23 Sep 2015, at 13:25, Luke Diamand <luke@diamand.org> wrote:

> Adding back git@vger.kernel.org, which I inadvertently dropped off th=
e thread.
>=20
> On 23 September 2015 at 12:22, Luke Diamand <luke@diamand.org> wrote:
>> On 23 September 2015 at 11:09, Lars Schneider <larsxschneider@gmail.=
com> wrote:
>>>=20
>>> On 23 Sep 2015, at 11:22, Luke Diamand <luke@diamand.org> wrote:
>>>=20
>>>> On 23 September 2015 at 09:50, Lars Schneider <larsxschneider@gmai=
l.com> wrote:
>>>>>=20
>>>>> On 23 Sep 2015, at 10:18, Lars Schneider <larsxschneider@gmail.co=
m> wrote:
>>>>=20
>>>> <snip>
>>>>=20
>>>>>=20
>>>>> I think I found an easy fix. Can you try it?
>>>>>=20
>>>>> (in case my mail app messes something up: I changed line 2240 in =
git-p4.py to 'self.cloneDestination =3D os.getcwd()=92)
>>>>=20
>>>> It fixes the problem, but in re-running the tests, I'm seeing t980=
8
>>>> fail which doesn't happen on next.
>>> Confirmed. I fixed it.
>>> Do you think it makes sense to create a new roll v8 for Junio?
>>=20
>> How about we leave it a day or two in case anything else crawls out =
of
>> the woodwork?
>>=20
>> Thanks!
>> Luke
sounds good to me!

Thanks,
Lars
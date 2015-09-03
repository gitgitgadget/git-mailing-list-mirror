From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 1/4] git-p4: add optional type specifier to gitConfig reader
Date: Thu, 3 Sep 2015 22:53:47 +0200
Message-ID: <6FAAE139-9010-4C68-AA97-2739E9A09564@gmail.com>
References: <1441298148-63885-1-git-send-email-larsxschneider@gmail.com> <1441298148-63885-2-git-send-email-larsxschneider@gmail.com> <55E8A5C2.9090500@diamand.org> <A76D6BC6-E0AD-48F4-AE33-80BD0803BFA3@gmail.com> <xmqqmvx3i7dg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 22:53:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXbW6-0004bN-OS
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 22:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757167AbbICUxv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 16:53:51 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35358 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593AbbICUxu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Sep 2015 16:53:50 -0400
Received: by wicge5 with SMTP id ge5so794580wic.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 13:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Lx2uuPdhZ1jUDh9wtdZp6wZtGkxmxhrZTlfih0QD4/w=;
        b=h5fL68ULx5EV+mZpCoYMD2LIdlhhTD+7Wsk/JTuk1oJxHJ6drtYk8X+K0tejSpw/cP
         ZDHVsuSUudYvdhNP3XJeIsLrqoJnMXD8ywNTdoBLhEYpMMt5RAyx+rj///aUA0wiX7v5
         24iDRmSglvmN7BReiSPPkBNi1g+B59UnR4OrztWqwU52GwnmOMO7py/b3wOQWo53CS0q
         HLaEksfnin9L3VleZsSO5HeZmMpVn5p9yQ6sPb1UOWar/OR7KAYUP2Ogmn2tcyOSPSPn
         VL/wyIOplhPE76F9kq5k/SlqDS79i2uonqLjc59BEmaQasyoVtmZufpEpOOFDBkyc8cn
         GGbA==
X-Received: by 10.180.106.66 with SMTP id gs2mr309710wib.14.1441313629226;
        Thu, 03 Sep 2015 13:53:49 -0700 (PDT)
Received: from slxbook3.fritz.box (dslb-092-078-130-241.092.078.pools.vodafone-ip.de. [92.78.130.241])
        by smtp.gmail.com with ESMTPSA id lj2sm301556wic.1.2015.09.03.13.53.48
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 13:53:48 -0700 (PDT)
In-Reply-To: <xmqqmvx3i7dg.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277257>


On 03 Sep 2015, at 22:18, Junio C Hamano <gitster@pobox.com> wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>> On 03 Sep 2015, at 21:55, Luke Diamand <luke@diamand.org> wrote:
>>=20
>>> On 03/09/15 17:35, larsxschneider@gmail.com wrote:
>>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>>=20
>>>=20
>>> I think this commit may need some explanation!
>>=20
>> The functions =93gitConfig=94 and =93gitConfigBool=94 are almost
>> identical. Make =93gitConfig=94 more generic by adding an optional t=
ype
>> specifier. Use the type specifier =93=97bool=94 with =93gitConfig=94=
 to
>> implement =93gitConfigBool. This prepares the implementation of othe=
r
>> type specifiers such as =93=97int=94.
>=20
> OK.
>=20
>> OK?
>=20
> Not really ;-).  The point of Luke's message is that all of the
> above belong to the log message, I think.
Right, it is my intention to add this as commit message. I just wanted =
to check upfront if the message is what he expects.

That leads me to a general question:
In case I agree with a reviewer. What is the more appropriate action? A=
 response like the one above or a new role that includes the change rig=
ht away? I don=92t want to spam the list with lots of tiny changes=85

Thanks!
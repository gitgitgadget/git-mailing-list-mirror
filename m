From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : git-send-email: threaded view issue with Thunderbird
Date: Thu, 24 Aug 2006 08:52:48 +0000 (GMT)
Message-ID: <20060824085248.66612.qmail@web25814.mail.ukl.yahoo.com>
References: <200608241043.02731.madcoder@debian.org>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 10:52:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGAxJ-0003XL-3R
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 10:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWHXIwu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 24 Aug 2006 04:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWHXIwu
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 04:52:50 -0400
Received: from web25814.mail.ukl.yahoo.com ([217.146.176.247]:63066 "HELO
	web25814.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750933AbWHXIwt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Aug 2006 04:52:49 -0400
Received: (qmail 66614 invoked by uid 60001); 24 Aug 2006 08:52:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=d3YFLJinZRYuTyb5De1PgM384pPK5dV/VfKYehKQTlTrCf+chgk7tV9poaJJsAm7VcTKx7RcBdK0b2Dw28cg6X8NxQKhE+VP79rm9HgyUafOBIE0cOwhSL/eavRDbnRFiiAGQXtw1IPOmADyq6e5J5bYSPDioVetfRxP1CKClN4=  ;
Received: from [194.3.162.233] by web25814.mail.ukl.yahoo.com via HTTP; Thu, 24 Aug 2006 08:52:48 GMT
To: Pierre Habouzit <madcoder@debian.org>
In-Reply-To: <200608241043.02731.madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25950>

bonjour,

Pierre Habouzit wrote:
> Le jeu 24 ao=C3=BBt 2006 10:12, moreau francis a =C3=A9crit :
>> Hi,
>>
>> Sometimes, actually most of the time, git-send-email _seems_ to not
>> work properly with Thunderbird: for example if I send a patchset mad=
e
>> up by 4 single patchs, then Thunderbird show me this patchset
>> 'broken' that is [PATCH 2/4] is not shown as a reply to [PATCH 1/4].
>>
>> For example I can see:
>>
>> [=E2=80=A6]
>>
>> [PATCH 0/7] C cleanup series, mostly nasty shadowing
>>
>> Does anybody have an idea on what's going wrong ?
>=20
> here the problem is that I manually sent the 0/7 as the initial mail,=
=20
> and passed its msg-id into --in-reply-to switch of git-send-email. bu=
t=20
> I did not specified the brackets, and those were not added, meaning=20
> that the reference was bad formatted.
>=20

well the problem occur with your [PATCH 2/7] and [PATCH 3/7] too. I don=
't
think you manually setup the headers for these patches, do you ?

> I don't know where your other problems come from. What I know for sur=
e=20
> is that I will write my own git-send-email version, with less perl, a=
nd=20

that would be great since I don't speak perl.

=46rancis

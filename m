From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] git-p4: add optional type specifier to gitConfig reader
Date: Thu, 03 Sep 2015 13:18:51 -0700
Message-ID: <xmqqmvx3i7dg.fsf@gitster.mtv.corp.google.com>
References: <1441298148-63885-1-git-send-email-larsxschneider@gmail.com>
	<1441298148-63885-2-git-send-email-larsxschneider@gmail.com>
	<55E8A5C2.9090500@diamand.org>
	<A76D6BC6-E0AD-48F4-AE33-80BD0803BFA3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 22:18:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXayH-0000vp-Oc
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 22:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbbICUSy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 16:18:54 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36283 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbbICUSx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 16:18:53 -0400
Received: by pacwi10 with SMTP id wi10so624314pac.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 13:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=i+W9qAo+s05kTZMledHLdjynhRaXlTaU4QVVNDReiPU=;
        b=tnTCA4sC3t1qANiFYEVThEqvsVbWz2UWo8rO5BlB0e50S8poV6AShHW6OfILxoUNHT
         Xl753OXPOAV4PcNRABqjBOwDEjpL3GtUg5CntR/hAMjS9eQUTLS7K/I3aOJqeT/MiswG
         3ZSGMQozU2dC6HbH+7M44YYVXmd9wJ0z+qLofrZdln6WdMFRBzZ6poHW17cRGKtSLhGx
         HIQuoReqBPQWgd8Z73Hjms7K8MCi0+/Kifp8aJOfaehhT7pi5g6zd898/ytzhvvMzc65
         XXzAvnSO6ru15nepjyZPFHuqnbDEpeXlRoQJcGaIMASUJsp0Dj2EsPST4FntfMpLuBRQ
         ECyA==
X-Received: by 10.68.175.3 with SMTP id bw3mr70800848pbc.106.1441311533192;
        Thu, 03 Sep 2015 13:18:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id ll8sm26428853pab.39.2015.09.03.13.18.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 13:18:52 -0700 (PDT)
In-Reply-To: <A76D6BC6-E0AD-48F4-AE33-80BD0803BFA3@gmail.com> (Lars
	Schneider's message of "Thu, 3 Sep 2015 22:14:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277254>

Lars Schneider <larsxschneider@gmail.com> writes:

> On 03 Sep 2015, at 21:55, Luke Diamand <luke@diamand.org> wrote:
>
>> On 03/09/15 17:35, larsxschneider@gmail.com wrote:
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>=20
>>=20
>> I think this commit may need some explanation!
>
> The functions =E2=80=9CgitConfig=E2=80=9D and =E2=80=9CgitConfigBool=E2=
=80=9D are almost
> identical. Make =E2=80=9CgitConfig=E2=80=9D more generic by adding an=
 optional type
> specifier. Use the type specifier =E2=80=9C=E2=80=94bool=E2=80=9D wit=
h =E2=80=9CgitConfig=E2=80=9D to
> implement =E2=80=9CgitConfigBool. This prepares the implementation of=
 other
> type specifiers such as =E2=80=9C=E2=80=94int=E2=80=9D.

OK.

> OK?

Not really ;-).  The point of Luke's message is that all of the
above belong to the log message, I think.

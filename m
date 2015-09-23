From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v7 1/7] git-p4: add optional type specifier to gitConfig reader
Date: Wed, 23 Sep 2015 09:38:39 +0200
Message-ID: <C363CF9F-0104-4874-9C88-F966CFD2EA77@gmail.com>
References: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com> <1442875273-48610-2-git-send-email-larsxschneider@gmail.com> <xmqqd1xa15ws.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 09:38:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeedZ-0000Hq-SK
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 09:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbbIWHin convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Sep 2015 03:38:43 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37732 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbbIWHim convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Sep 2015 03:38:42 -0400
Received: by wicfx3 with SMTP id fx3so56040382wic.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 00:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=c8c0G43h1AU8ajia31QbdSOqfIi3p82uetuAOldAVSc=;
        b=0FgSGi43WtebzVLfZBMOJE9hxPtyAWhMg1NGDsySWsFz9WTTW71hcdSLnBbZiJrssw
         39RZK7lOzhM1Dyk1KjYD/xbKJqhUkT1ZLnr8UvHch/MPah0MmGU5+bk4RbUBkuw2f5jH
         52Bm//lXlPqeAIfUgLvk4YHHGqfu/1xs/RF9HDKcEmqD1D0JqsEGMxMnYbGpP4GodmRg
         Cl1B1gt9ebhyW1soJ2jE/rrov6F2G6tX8rUnDdpSuSiqT4Ukny7ZP/3JR2v3RqwmxwLY
         2qK6LJSL3OZxsg8ZgElLWE3sC22JkHsA4Ynl+M0bETTf+Gg1XsC6g8kMoxsKAZGIeiOB
         9IyQ==
X-Received: by 10.180.211.10 with SMTP id my10mr2406481wic.84.1442993921098;
        Wed, 23 Sep 2015 00:38:41 -0700 (PDT)
Received: from [10.146.248.63] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id kj5sm5791151wjb.19.2015.09.23.00.38.40
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Sep 2015 00:38:40 -0700 (PDT)
In-Reply-To: <xmqqd1xa15ws.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278473>


On 22 Sep 2015, at 23:49, Junio C Hamano <gitster@pobox.com> wrote:

> larsxschneider@gmail.com writes:
>=20
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> The functions =93gitConfig=94 and =93gitConfigBool=94 are almost ide=
ntical. Make =93gitConfig=94 more generic by adding an optional type sp=
ecifier. Use the type specifier =93=97bool=94 with =93gitConfig=94 to i=
mplement =93gitConfigBool. This prepares the implementation of other ty=
pe specifiers such as =93=97int=94.
>=20
> What is this overlong single line paragraph?  Is this a MUA artifact
> on my end?
>=20
No. It looks like I messed that up. Same is true for the commit =93git-=
p4: add gitConfigInt reader=94. I=92ll be more careful in the future.

Sorry,
Lars

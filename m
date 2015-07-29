From: =?iso-8859-1?Q?Zo=EB_Blade?= <zoe@bytenoise.co.uk>
Subject: Re: [PATCH] userdiff: add support for Fountain documents
Date: Wed, 29 Jul 2015 12:19:06 +0100
Message-ID: <0B100A08-4387-4BDE-A3E5-049303343C8D@bytenoise.co.uk>
References: <1437484966-664-1-git-send-email-zoe@bytenoise.co.uk> <xmqqk2ttuwyy.fsf@gitster.dls.corp.google.com> <FCF96FC6-2DCB-42F2-9B75-A97F84ED2D94@bytenoise.co.uk>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 13:19:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKPOP-00029J-Dp
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 13:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbbG2LTR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2015 07:19:17 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:51350 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbbG2LTP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2015 07:19:15 -0400
Received: from [192.168.0.26] ([82.69.105.163]) by mrelayeu.kundenserver.de
 (mreue005) with ESMTPSA (Nemesis) id 0LwE4w-1YowSp0VEU-017zaP; Wed, 29 Jul
 2015 13:19:09 +0200
In-Reply-To: <FCF96FC6-2DCB-42F2-9B75-A97F84ED2D94@bytenoise.co.uk>
X-Mailer: Apple Mail (2.1878.6)
X-Provags-ID: V03:K0:p4jdVw0GQZedjN3hZf2AMpGaUxle+DaUt94VtncjpVy1BuYRTA8
 n760p8hGmEWmyC40+9akA0srcgRveu2T+zDHtZpETEda9ihAiBaqqVUMx9xai9AC3U5Wi8L
 x8FGb1LmUIBS8D+Hsle/zg4DQvhT1FhcRAadINYMwg7yd6/2o3JmXsgJBsMSwYhtK0fD8gD
 TLmzpTOVBSdUxlBW2lYzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k00NCxmcmPQ=:wJSq8quAba15wsD3faB5sh
 N/1G6NqUM07pTPZi5BU056TRO3y554FHFRaXKiOSXglA2ZuWWzouwCYIBytYSYOGqO63GYWx8
 uUfx3ynN+e9k+3a+aI8vN0Ghi7+JjSV5A8YdkDWrCPdFaO2GJKMXi0bFQHaX8e62kkwPDAzPF
 FHcyplU+0rZQzSuj1BumZr82RI8T8h1gARuGrgr7vu3xeAA6mutVAj35HPYsft7473WzaMsdT
 ZVjePJvFSdg3ScirozJF1JUPgJqPWu4YbFydceXiHQAtHwM9/v2NtXAAhfebCgjf6ApLoMH3O
 MVVfuxuCHzhDtjIzNuhAK2KMXektNmQmz6LSCcvCSmsM/lTkBvjhRBSyzBvbK3rOvPzhFSMhS
 yjvTgyS6jX/p7iMjEPHxrX7AqTETq7/kpVz7qtjiCjsdhGSQvlCvFJad4dsGATQPCiM+cVlg1
 ut5KAkZnGJBdZpdKEXO7yqI8ealKo1WOjYueoPmE+HEfpuIbG0mjfFYCY4118k/f0aJcDVwMn
 R/o0vcKzBUdruciGd3WwRnktvMwpXpFLOvSYPDvv7NY4s88BfJD+Y8ESu1iPMOzn9IBoF7Yrq
 ORQqfcbAiXolhC2BY4fUUjxcHK0Rrl3mr39jtCPAC4WYcBh0BnFS/7v3lyjAu//tsswcBRzJX
 7xmuw5w4Y6ZiZaa9Vhx6BZ94qqGBDfVN1lEDWxg4E71GV9A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274892>

Hi again!

Where's this at?  Your last regex looks perfect to me:

^((\\.[^.]|(int|ext|est|int\\.?/ext|i/e)[. ]).*)$

Do you need anything else from me?

Thanks,
Zo=EB.
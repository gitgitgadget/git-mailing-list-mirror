From: l.stelmach@samsung.com (=?utf-8?Q?=C5=81ukasz?= Stelmach)
Subject: Re: [PATCH] send-email: support NNTP
Date: Wed, 24 Apr 2013 09:31:36 +0200
Message-ID: <87txmw75bb.fsf@samsung.com>
References: <1366715634-21790-1-git-send-email-l.stelmach@samsung.com>
 <7vobd5l277.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 09:31:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUuB5-0008Ss-UA
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 09:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757686Ab3DXHbk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Apr 2013 03:31:40 -0400
Received: from mailout4.w1.samsung.com ([210.118.77.14]:65388 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757655Ab3DXHbj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Apr 2013 03:31:39 -0400
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MLR0074P0O6HK70@mailout4.w1.samsung.com> for
 git@vger.kernel.org; Wed, 24 Apr 2013 08:31:38 +0100 (BST)
X-AuditID: cbfec7f4-b7fb86d000007679-0a-51778a5a2917
Received: from eusync2.samsung.com ( [203.254.199.212])
	by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id C0.F2.30329.A5A87715; Wed,
 24 Apr 2013 08:31:38 +0100 (BST)
Received: from localhost ([106.116.147.110])
 by eusync2.samsung.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTPA id <0MLR00L4J0WQXX70@eusync2.samsung.com>; Wed,
 24 Apr 2013 08:31:38 +0100 (BST)
In-reply-to: <7vobd5l277.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprILMWRmVeSWpSXmKPExsVy+t/xK7pRXeWBBnPWy1h0XelmsmjovcLs
	wORx8ZKyx+dNcgFMUVw2Kak5mWWpRfp2CVwZ9y+bFKxgrfj117GBcRlLFyMnh4SAicSKSw9Y
	IWwxiQv31rN1MXJxCAksZZR4fGoeM4TTxCSx+fUrZpAqEQE1iYlth8C6mQXEJdbNPc8OYgsL
	6EqcWbkDrEZIoEji4pSjYDabgL3E3H/PwepZBFQlpp2dCGZzCphJvHo7DWwzr4CGxKo/a8Hq
	RQUsJRrfXGGBiAtK/Jh8D8jmANqlLjFlSi7EWm2JJ+8usE5gFJiFpGoWQtUsJFULGJlXMYqm
	liYXFCel5xrqFSfmFpfmpesl5+duYoQE45cdjIuPWR1iFOBgVOLhdZxbFijEmlhWXJl7iFGC
	g1lJhDeGoTxQiDclsbIqtSg/vqg0J7X4ECMTB6dUA2N3RXT7lygujYmPpqekP582Ve3TnMjl
	rCWaQlUfJ4UpPgyxLz0YnpOj/Ctl3YtWjlAe4zm8j9ZGf21hzFrCcIrz9nqztC/SYZcvLz6h
	s2Fim5bFtkv66o9eMtp0Gk7jX/r0X5OlqvKzwqstRxhZjI8laUadjGNq4RSZpPHXo2BlhtRa
	PUbH1UosxRmJhlrMRcWJAHBSjSskAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222231>

It was <2013-04-23 wto 17:02>, when Junio C Hamano wrote:
> =C5=81ukasz Stelmach <l.stelmach@samsung.com> writes:
>
>> Enable sending patches to NNTP servers (Usenet, Gmane).
>> ---
>>
>> The patch implements support for sending messages to groups on NNTP =
serviers.
>
> Cute.
>
> A Perl guru might want to encapsulate the differences between $smtp
> and $nntp codepaths into two Perl modules, but it looks like a good
> starting point.

You mean *one* perl module like Git::EmailTransport which hides the
differences.

--=20
=C5=81ukasz Stelmach
Software wizzard
Samsung Poland R&D Center

Al. Armii Ludowej 26, 00-609 Warszawa
http://www.rd.samsung.pl

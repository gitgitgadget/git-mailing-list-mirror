From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: A slight inconvenience with 'git archive --format=tar'
Date: Wed, 13 Jun 2012 21:58:31 +0200
Message-ID: <4FD8F0E7.40706@lsrfire.ath.cx>
References: <20120613144758.GA2438@blackspire> <7vmx47gl6n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?UmFmYcWCIE11xbx5xYJv?= <galtgendo@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 21:59:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SetiQ-0005LW-Ft
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 21:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189Ab2FMT6u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 15:58:50 -0400
Received: from india601.server4you.de ([85.25.151.105]:58255 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389Ab2FMT6t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 15:58:49 -0400
Received: from [192.168.2.105] (p4FFDA3B2.dip.t-dialin.net [79.253.163.178])
	by india601.server4you.de (Postfix) with ESMTPSA id D82A92F8050;
	Wed, 13 Jun 2012 21:58:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7vmx47gl6n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199940>

Am 13.06.2012 19:45, schrieb Junio C Hamano:
> Rafa=C5=82 Mu=C5=BCy=C5=82o <galtgendo@gmail.com> writes:
>
>> I just stumbled upon this while checking a few mailing lists.
>> I haven't found any mails about in in the archives yet, so I assume,=
 that
>> no mail have been written yet.
>>
>> The problem is described here:
>> http://sourceforge.net/projects/sevenzip/forums/forum/45798/topic/53=
22604
>
> Thanks.  It sounds a bit more than "slight inconvenience" to me ;-)

Indeed, but two mitigating factors, if you will, are that this only=20
affects files whose path or link target contain non-ASCII characters,=20
and -- as Rafa=C5=82 wrote -- that GNU tar silently accepts signed chec=
ksums=20
as well, which makes it a bit difficult to test.

Ren=C3=A9

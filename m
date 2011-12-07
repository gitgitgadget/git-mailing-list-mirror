From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 3/3] grep: disable threading in all but worktree case
Date: Wed, 07 Dec 2011 17:54:19 +0100
Message-ID: <4EDF9A3B.607@lsrfire.ath.cx>
References: <cover.1322830368.git.trast@student.ethz.ch> <4ED8F9AE.8030605@lsrfire.ath.cx> <4EDE9BBA.2010409@lsrfire.ath.cx> <201112070911.08079.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Herman <eric@freesa.org>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Dec 07 17:54:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYKlV-0002Pe-6R
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 17:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504Ab1LGQyi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 11:54:38 -0500
Received: from india601.server4you.de ([85.25.151.105]:39092 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab1LGQyf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 11:54:35 -0500
Received: from [192.168.2.104] (p4FFD9BF7.dip.t-dialin.net [79.253.155.247])
	by india601.server4you.de (Postfix) with ESMTPSA id C484D2F8032;
	Wed,  7 Dec 2011 17:54:33 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <201112070911.08079.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186472>

Am 07.12.2011 09:11, schrieb Thomas Rast:
> Ren=E9 Scharfe wrote:
>> Am 02.12.2011 17:15, schrieb Ren=E9 Scharfe:
>>> How about adding a parameter to control the number of threads=20
>>> (--threads?) instead that defaults to eight (or five) for the workt=
ree=20
>>> and one for the rest? That would also make benchmarking easier.
>>
>> Like this:
>>
>> -- >8 --
>> Subject: grep: add parameter --threads
>>
>> Allow the number of threads to be specified by the user.  This makes
>> benchmarking the performance impact of different numbers of threads
>> much easier.
>=20
> Sounds good, though in the end we would also want to have a config
> variable for the poor OS X users who have to tune their threads
> *down*... :-)

We could set different defaults for different platforms..

Ren=E9

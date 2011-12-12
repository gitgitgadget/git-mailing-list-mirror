From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v3 0/3] grep attributes and multithreading
Date: Mon, 12 Dec 2011 23:37:02 +0100
Message-ID: <4EE6820E.7010605@lsrfire.ath.cx>
References: <4ED8F9AE.8030605@lsrfire.ath.cx> <cover.1323723759.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Eric Herman <eric@freesa.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Dec 12 23:37:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaEUk-0000l2-37
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 23:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab1LLWhJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Dec 2011 17:37:09 -0500
Received: from india601.server4you.de ([85.25.151.105]:39594 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204Ab1LLWhI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 17:37:08 -0500
Received: from [192.168.2.105] (p4FFDA9B5.dip.t-dialin.net [79.253.169.181])
	by india601.server4you.de (Postfix) with ESMTPSA id 358DA2F8032;
	Mon, 12 Dec 2011 23:37:06 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <cover.1323723759.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186967>

Am 12.12.2011 22:16, schrieb Thomas Rast:
> I think we should finish up these three patches for the next release.

> I already posted a bunch of POC patches, but doing the timing manuall=
y
> has been getting on my nerves lately.  So I would first like to
> formalize some of the performance testing, perhaps along lines alread=
y
> drawn up by Michael Hagger, perhaps not.  Then we can revisit the
> issue of grep performance.  But I would prefer not to block the -W fi=
x
> and two easy and confirmed speedups on that.

Yes, that's a good idea.  The three patches are uncontroversial=20
incremental improvements.

> I dropped this part entirely:
>
>> How about adding a parameter to control the number of threads
>> (--threads?) instead that defaults to eight (or five) for the worktr=
ee
>> and one for the rest?  That would also make benchmarking easier.
>
> It does make testing a lot easier, but the interface is IMHO not fit
> for users and I have a feeling that the "right" for-debugging
> interface will end up falling out of the performance testing work
> (probably an environment variable).  The end-user option should be a
> config setting, if any.

Agreed; users shouldn't need to specify such a parameter -- our=20
heuristic should be good enough.

Ren=C3=A9

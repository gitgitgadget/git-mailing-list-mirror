From: =?UTF-8?B?R3LDqWdvaXJlIEJhcmJpZXI=?= <gb@gbarbier.org>
Subject: Re: [PATCH] added #define DEFAULT_MAX_REQUESTS for USE_CURL_MULTI
 mode
Date: Mon, 21 Jan 2008 10:57:41 +0100
Message-ID: <47946C95.4080607@gbarbier.org>
References: <1200756171-11696-1-git-send-email-gb@gbarbier.org>	<1200756171-11696-2-git-send-email-gb@gbarbier.org>	<1200756171-11696-3-git-send-email-gb@gbarbier.org>	<1200756171-11696-4-git-send-email-gb@gbarbier.org>	<1200756171-11696-5-git-send-email-gb@gbarbier.org> <7v1w8c6nnm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 10:58:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGtQJ-0004oR-J9
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 10:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758590AbYAUJ5p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2008 04:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758490AbYAUJ5p
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 04:57:45 -0500
Received: from relay3-v.mail.gandi.net ([217.70.178.77]:53220 "EHLO
	relay3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758456AbYAUJ5o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 04:57:44 -0500
Received: from localhost (mfilter1-c.gandi.net [217.70.182.21])
	by relay3-v.mail.gandi.net (Postfix) with ESMTP id 08EB3BA1B;
	Mon, 21 Jan 2008 10:57:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter1-c.mgt.gandi.net
Received: from relay3-v.mail.gandi.net ([217.70.178.77])
	by localhost (mfilter1-c.mgt.gandi.net [217.70.182.21]) (amavisd-new, port 10024)
	with ESMTP id fGV1ea7uRzrc; Mon, 21 Jan 2008 10:57:37 +0100 (CET)
Received: from [192.168.79.1] (soy95-1-82-229-96-169.fbx.proxad.net [82.229.96.169])
	by relay3-v.mail.gandi.net (Postfix) with ESMTP id 1D4E3B9FF;
	Mon, 21 Jan 2008 10:57:37 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <7v1w8c6nnm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71248>

Junio C Hamano a =C3=A9crit :
> Gr=C3=A9goire Barbier <gb@gbarbier.org> writes:
>  =20
>> From: Gregoire Barbier <gb@gbarbier.org>
>>
>> I'm not sure of which value is the good one, but 4 seems good since =
it's
>> not very high which would lead to resouce consumption problems.
>> ---
>>  http.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/http.c b/http.c
>> index 8b04ae9..7b1bcb8 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -4,6 +4,7 @@ int data_received;
>>  int active_requests =3D 0;
>> =20
>>  #ifdef USE_CURL_MULTI
>> +#define DEFAULT_MAX_REQUESTS 4
>>  static int max_requests =3D -1;
>>  static CURLM *curlm;
>>  #endif
>>    =20
>
> Why is this needed?
>
> How does this interact with an existing #define in http.h that
> defines it to 5?
>  =20

Ok, please forget my patch and forgive my stupidity, I've juste realize=
d=20
why I needed to define -DUSE_CURL_MULTI by hand in the Makefile, I'm so=
=20
stupid...

I will answers you other mail and Johannes' later.

--=20
Gr=C3=A9goire Barbier - gb =C3=A0 gbarbier.org - +33 6 21 35 73 49

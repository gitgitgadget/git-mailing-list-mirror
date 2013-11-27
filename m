From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] commit-slab: document clear_$slabname()
Date: Wed, 27 Nov 2013 05:39:17 -0500
Message-ID: <CAPig+cRmNsGLr1=xrWCgs8DxJ0QVhn1na=0UtjwVswKvPGdqDw@mail.gmail.com>
References: <cover.1385405977.git.tr@thomasrast.ch>
	<7f773c5c5ea16b19840f67ba99961be132940d32.1385405977.git.tr@thomasrast.ch>
	<xmqqa9gsxll5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 11:39:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlcWh-0002Lh-NQ
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 11:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828Ab3K0KjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 05:39:19 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35365 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465Ab3K0KjT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 05:39:19 -0500
Received: by mail-ie0-f180.google.com with SMTP id tp5so11199247ieb.39
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 02:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QGcOka9rOw4D3+q9qXuYVG7nwpU+3vaGei993joBpEo=;
        b=zJ65KVClzxQYih0CvmE+6lVO3v+2x7pw7aq04TOGKatwtXUEdT0F5zdnWbyqEdsoXt
         EpCuuDE8waeecfmzY3pCf4Z85TJRjVD5XTpHSm6P/x06taESFjWNvESk8/uvr98hPxFN
         xdt/0HqyaKhbPi9RGNVYgJJrwX5dAXjKMUxrDs/EnMQnGHVFR4YL0giEvXp90Ylga0k8
         +zdvDB2dnbYcDeUNJl0utZoo7XNRv+hASLil1pHvCZVRZI96QwsShJdN1l/iPsScgMn4
         2SY4IkzvQQYoO0IsuLVO9EBrEBQC/0hkrzEHO+L5OHP7FMIAFH6xmRVcVTUUkpq/Gdc0
         5f2g==
X-Received: by 10.50.147.65 with SMTP id ti1mr21365342igb.12.1385548757542;
 Wed, 27 Nov 2013 02:39:17 -0800 (PST)
Received: by 10.64.250.198 with HTTP; Wed, 27 Nov 2013 02:39:17 -0800 (PST)
In-Reply-To: <xmqqa9gsxll5.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: OLNwEMkpusrv1sNioBMVKKgj8-g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238411>

On Mon, Nov 25, 2013 at 3:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thomas Rast <tr@thomasrast.ch> writes:
>
>> The clear_$slabname() function was only documented by source code so
>> far.  Write something about it.
>>
>> Signed-off-by: Thomas Rast <tr@thomasrast.ch>
>> ---
>>  commit-slab.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/commit-slab.h b/commit-slab.h
>> index d4c8286..d77aaea 100644
>> --- a/commit-slab.h
>> +++ b/commit-slab.h
>> @@ -24,6 +24,10 @@
>>   *   to each commit. 'stride' specifies how big each array is.  The slab
>>   *   that id initialied by the variant without "_with_stride" associates
>
> Is that "id" a typo for "is"?

And, s/initialied/initialized/

>>   *   each commit with an array of one integer.
>> + *
>> + * - void clear_indegree(struct indegree *);
>> + *
>> + *   Free the slab's data structures.
>>   */
>>
>>  /* allocate ~512kB at once, allowing for malloc overhead */
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

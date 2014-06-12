From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/2] add strbuf_set operations
Date: Thu, 12 Jun 2014 17:18:29 -0400
Message-ID: <CAPig+cT_StMkTgEd-RVpm=4e_A23zj+V5k83PhMtaN=tr4GBzA@mail.gmail.com>
References: <cover.1402557437.git.jmmahler@gmail.com>
	<f4d043b7c1e00f9c967faff39244274fe40fd371.1402557437.git.jmmahler@gmail.com>
	<539960B8.1080709@virtuell-zuhause.de>
	<20140612082218.GA5419@hudson.localdomain>
	<xmqqmwdi55co.fsf@gitster.dls.corp.google.com>
	<20140612193642.GB17077@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 23:18:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvCOI-0007tA-Bf
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 23:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbaFLVSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 17:18:30 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:45249 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbaFLVSa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 17:18:30 -0400
Received: by mail-yh0-f50.google.com with SMTP id t59so1445733yho.23
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 14:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=lZMTi4Y/Lq+LPhsk11eihwQHryg3vagHUpbIyXFZIh8=;
        b=s5NIeKf196NBXKqYCDZmyvaJ4aPY9dZlsuJ0xRw99q10i4BNeY774QEe1omaUFsdGG
         504scGvlk+lE+6FHQh9CnwvpmE8ALDxYYlPE+C9B+ZoLINYFyPb0CuzDby9RxTawZjTg
         yuCAt3DZxh6YeWKqeqSUpOcqhcZffxju6BKwY0KMe52wv5gYKL4LOcuDiT8WRZ7YeP3p
         7lmIKd405PZneFg8iBDjxGrPBK02UtrdJCdm/JdO++/ZtIPWghfWHYmn9leqJSh/B7v1
         cCV7uL7ZgHGvS+LMvRUxnyCzUcLaW6yXmN7f50pFuzaldGyXXyf5d1GJ/w1PmdoZ7yYB
         6CoA==
X-Received: by 10.236.141.80 with SMTP id f56mr7149740yhj.149.1402607909458;
 Thu, 12 Jun 2014 14:18:29 -0700 (PDT)
Received: by 10.170.36.19 with HTTP; Thu, 12 Jun 2014 14:18:29 -0700 (PDT)
In-Reply-To: <20140612193642.GB17077@hudson.localdomain>
X-Google-Sender-Auth: tktzZooJ-S_1E4TJnWRHbG1p6F8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251496>

On Thu, Jun 12, 2014 at 3:36 PM, Jeremiah Mahler <jmmahler@gmail.com> wrote:
> On Thu, Jun 12, 2014 at 11:51:19AM -0700, Junio C Hamano wrote:
>> Jeremiah Mahler <jmmahler@gmail.com> writes:
>>
>> > Thomas,
>> >
>> > On Thu, Jun 12, 2014 at 10:11:36AM +0200, Thomas Braun wrote:
>> >> Am 12.06.2014 09:29, schrieb Jeremiah Mahler:
>> >> > A common use case with strubfs is to set the buffer to a new value.
>>
>> strubfs???
>>
> I was trying to make it plural.  Perhaps strbuf's?

Junio was pointing out your misspelling, not your intention to pluralize.

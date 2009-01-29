From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2] http-push: refactor request url creation
Date: Fri, 30 Jan 2009 06:31:52 +0800
Message-ID: <be6fef0d0901291431v5d728c0fl638e445ed881d031@mail.gmail.com>
References: <4981C43B.9030409@gmail.com>
	 <alpine.DEB.1.00.0901291608330.3586@pacific.mpi-cbg.de>
	 <7vk58ef2il.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 23:34:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSfRv-0005Ao-Hz
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 23:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757992AbZA2Wbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 17:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757625AbZA2Wby
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 17:31:54 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:45246 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755678AbZA2Wbx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 17:31:53 -0500
Received: by rv-out-0506.google.com with SMTP id k40so139443rvb.1
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 14:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+awimwTpn1JMEiPm1jVlR4Z3yBxBzNVCzH+EiBLqw04=;
        b=DN0bzpNBkbtLDYuLEgKLddSwVo83ay0elcFz0DMwTZxeJDYUxdKwZgQQPPqkvBKU0E
         kgE3cCbTEbJvPZqm3RItqS2K7yB91L+KZwM18lBUvG9MiC1m+izrLgN4S05j09dPCkx5
         V6gURcfXaiJzgfxNreyKDlwxXhkE3DwOSakkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vwiX0bwult/NX1FlDd6FHxWo4DVKxU3ip3SHysTsw4N/m3ccSWv8XmpxBaJ8W2yQio
         nfLZbvKNLo2TMYbGFsotYoIgQun4lw3lwVfKWXBxCT2f21YeeiIUncHV3Y9ZQoqNks7b
         hipT4Ua7u/RXjwMM2a7RMwJdj57qn2ZCHjrbM=
Received: by 10.114.205.1 with SMTP id c1mr324776wag.11.1233268312880; Thu, 29 
	Jan 2009 14:31:52 -0800 (PST)
In-Reply-To: <7vk58ef2il.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107739>

On Fri, Jan 30, 2009 at 1:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Thu, 29 Jan 2009, Tay Ray Chuan wrote:
>>
>>> Currently, functions that deal with objects on the remote repository have to
>>> allocate and
>>> do strcpys to generate the URL.
>>
>> That is a funny way to wrap the commit message :-)
>
> That's format=flowed in action, isn't it?

Ok, I've turned that off.

Eh, no I didn't wrap anything, my message looks fine here:

http://permalink.gmane.org/gmane.comp.version-control.git/107691

...turning off format=flowed would fix that?

-- 
Cheers,
Ray Chuan

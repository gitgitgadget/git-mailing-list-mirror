From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 11/13] remote-hg: force remote push
Date: Thu, 4 Apr 2013 12:56:39 -0600
Message-ID: <CAMP44s22KDoWVApwnVcGBH=EVDV+wnCQUAdEp=SRLQeb9E0J=g@mail.gmail.com>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
	<1365089422-8250-12-git-send-email-felipe.contreras@gmail.com>
	<7vip42jldt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 20:57:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNpLS-00065O-Kk
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763304Ab3DDS4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:56:41 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:65406 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763274Ab3DDS4l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:56:41 -0400
Received: by mail-la0-f42.google.com with SMTP id fe20so2814109lab.29
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 11:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=mra5kDE6Y2KIMIZV6ulD/EmjagiU5skcOcGvqhKFfvY=;
        b=gPV5OdVqhy0J/i2xNnFkkmqZUYfD5gECXUb5acNKl4HdxC04UihZxmk5TJo9e9MiEz
         uXAPR52Ca4jC8EjZO0zSc/LjFeolfUiXSBBdoTXJBAn3ixTP7pkg0gg1KV/twZy4IduY
         jC545pkOuHwgc0JGaPPCRwlSK6dFpEKbIV1G00+FL5KDOd3Bdgmry39r5uJRgeYYeXE2
         49zWazDiKI67QPZWQ9PE7DPjXUXJ9Pj7N7P3LG337Axs7G8ejT4DI4XroLjX0pQ6MPyz
         kG0JNCjzhlItgBrh0kmvmTL49TCbzuEHh7Ltm/zYAuGgQLLX7Uv19djQ26nQZd1QR8+f
         Cj5A==
X-Received: by 10.112.130.201 with SMTP id og9mr4215434lbb.65.1365101799562;
 Thu, 04 Apr 2013 11:56:39 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Thu, 4 Apr 2013 11:56:39 -0700 (PDT)
In-Reply-To: <7vip42jldt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220063>

On Thu, Apr 4, 2013 at 10:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Ideally we shouldn't do this, as it's not recommended in mercurial
>> documentation, but there's no other way to push multiple bookmarks (on
>> the same branch), which would be the behavior most similar to git.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>
> In the previous round you wanted me to exclude this one to force
> split head at the remote, and I saw you and Max Horn discussing
> (rather, shouting at each other ;-) why it is needed/desirable.

No, that was "don't update bookmarks unnecessarily", and it seems you
skipped it appropriately.

> Have you changed your mind and you want this as part of the series,
> or is it just you forgot to exclude it?

Nope, I still see no reason not to push this.

-- 
Felipe Contreras

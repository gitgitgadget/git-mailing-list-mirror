From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-bzr: update old organization
Date: Tue, 14 May 2013 15:06:12 -0500
Message-ID: <CAMP44s1rZmo3cQecGmYVMZ7KSq=z3_mfVnAK+so4QL_JfEe_uw@mail.gmail.com>
References: <1368505227-16661-1-git-send-email-felipe.contreras@gmail.com>
	<7v1u99lb8w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 14 22:06:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcLUI-0004JR-6I
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 22:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757884Ab3ENUGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 16:06:14 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:60504 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab3ENUGN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 16:06:13 -0400
Received: by mail-la0-f49.google.com with SMTP id fp13so366029lab.36
        for <git@vger.kernel.org>; Tue, 14 May 2013 13:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=LuxC60wB8gPss3mlrWRPVkKRquiv8utAQP04pyCUmkk=;
        b=iW/4ju6a6LE6miISL/403RWoXWbGu+Thtyo94SjNaSDpgZXQHYSH0Q8Dx7IVnHgmLV
         jYo29I+t4dwoNAZA0NMtjpZ7gLJOTmJmgW8KoyZaB5GcMJI0+ISPZQb5UBuFC8txTdLA
         s1W0PFBrhuJfLLs3RGuLNCvQt3KGncgWz/eGBl+CgxmBhNw0STguvJrde50b1vQAEuUB
         jzcOPKc/AnaOgR8P3jUt2QZllcjqe6koQ/uq3S26y/a04aIFiGc0ZJH/BRdef1bzxCUD
         apkCMe6blF+7xLv3XhF0Q728AHQH+uFvixPB1fR+6M+OM91/QKoLgBkTqZJdT0yduCQT
         OjVA==
X-Received: by 10.112.63.169 with SMTP id h9mr1339456lbs.135.1368561972118;
 Tue, 14 May 2013 13:06:12 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 14 May 2013 13:06:12 -0700 (PDT)
In-Reply-To: <7v1u99lb8w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224331>

On Tue, May 14, 2013 at 12:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> If a clone exists with the old organization (v1.8.2) it will prevent the
>> new shared repository organization from working, so let's remove this
>> repository, which is not used any more.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>
> What happens with and without this patch to an existing user from
> 1.8.2 days, when she does what?

I already explained it would prevent the new shared repository
organization from working, so the old organization would be used; the
repositories won't be shared.

> A sample answer (to show the level of descriptiveness, not the
> content, I am epecting) might go something like "Because the
> organization is different, it will barf whenever she tries to
> incrementally update from the other side. By removing the old one
> 1.8.3 contrib/ does not understand, at least we can unstuck her; she
> ends up reimporting the whole history, though."

Bazaar won't barf, the repositories will be duplicated, so the shared
feature won't work.

-- 
Felipe Contreras

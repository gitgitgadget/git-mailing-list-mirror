From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 02/10] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
Date: Sat, 10 Oct 2015 22:52:30 +0530
Message-ID: <CAOLa=ZQaMbqXc8GT_DC5_csjNO-47ksbOoOGnPrBB+JPYvrY_g@mail.gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
 <1444295885-1657-3-git-send-email-Karthik.188@gmail.com> <vpqpp0pmbxf.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Oct 10 19:23:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkxrP-0000gp-10
	for gcvg-git-2@plane.gmane.org; Sat, 10 Oct 2015 19:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbbJJRXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2015 13:23:01 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:33450 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbbJJRXA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2015 13:23:00 -0400
Received: by vkaw128 with SMTP id w128so11482937vka.0
        for <git@vger.kernel.org>; Sat, 10 Oct 2015 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6yR6ClC976axTxAhpygrLD5jMcz3y484V7gdeSkoVv8=;
        b=WRbmv4d8jD0rZG7jpPx9MtJQ0PzJoe7/gbZPtCqZ6ECc6dyYZXmlDIrHtn/3UdDyUE
         RYlVwmpmNzmgvngajtUO/MlTdJMXEvBt6LZS/e+ezfq6LF6W3LRpuw0pZd7wZRb0VR48
         W9wjbB3RUAPxnzknPVoMV9AHxF7Eyg3E2eqYAhfU7ixujJ4RsKz5KiPgj01fFAxd0Kgn
         FpNiJnhp2L2mE50GbZ/YiW94VkPcGDihsOTAJFyZcC0L+vlrXDE2g49ukrmZDVBs80fq
         GZ8KqNzDA2S3J5HqrLxT+vx9CBeGmsUUXoU4iRIiykmmiSODkdB/DIdzhtbbIkkFAoB5
         +PTQ==
X-Received: by 10.31.50.214 with SMTP id y205mr12837748vky.77.1444497779373;
 Sat, 10 Oct 2015 10:22:59 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Sat, 10 Oct 2015 10:22:30 -0700 (PDT)
In-Reply-To: <vpqpp0pmbxf.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279327>

On Fri, Oct 9, 2015 at 12:21 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> @@ -309,11 +319,19 @@ static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_st
>>       if (if_then_else->then_atom)
>>               die(_("format: %%(then) atom used more than once"));
>>       if_then_else->then_atom = 1;
>> +
>>       /*
>
> Useless new blank line.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

Will remove it, thanks!

-- 
Regards,
Karthik Nayak

From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 4/9] ref-filter: modify "%(objectname:short)" to take length
Date: Sat, 3 Oct 2015 12:58:53 +0530
Message-ID: <CAOLa=ZQVXwQzv8io=Z+4eCrpArF4t=qwwaw+=59G4xRTPmhF_A@mail.gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
 <1443807546-5985-5-git-send-email-Karthik.188@gmail.com> <xmqqd1wx3rxt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 09:29:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiHG4-0005dX-Q2
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 09:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbbJCH3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 03:29:24 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35155 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbbJCH3X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 03:29:23 -0400
Received: by vkao3 with SMTP id o3so72080704vka.2
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 00:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=omhcX6jOQyRCAfZUtcp79a/JVvxvJKoDoszYEcw4/nQ=;
        b=S1u7ef+rBRGZasfODNK8u4XejWuS/q6lyAxFcC90g5gc8cVUieoLRRIHA6Blr2mmro
         FvcOHZqLFlb+RpVMNKoJyprIvIXFCaf/8ID7/fJK0jvWhJjvDLJN+fnnictCI5yQBdGt
         NTxAiOTwvTqXnKoqqhixBphIUuSIvMMTg5um1rWxUKn23gsNJ52jGWQZFQKOwI2qW6Rc
         ZR+VzkP8/xPqr1sVYZfS/cx3ZRc2ZV4QCHy8SxVePRji/BuvhT0k+5q866l9MUFhwfgd
         ooBZJSDJDTCM5U9qMBQE01sxqyrdA/uD3p/n2kd9AaJaFsTiupNEr1Zr4cXBfKcWZjrB
         wmwQ==
X-Received: by 10.31.50.214 with SMTP id y205mr12663094vky.77.1443857362862;
 Sat, 03 Oct 2015 00:29:22 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Sat, 3 Oct 2015 00:28:53 -0700 (PDT)
In-Reply-To: <xmqqd1wx3rxt.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278961>

On Sat, Oct 3, 2015 at 2:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Add support for %(objectname:short,<length>) which would print the
>> abbreviated unique objectname of given length. When no length is
>> specified 7 is used. The minimum length is 4.
>
> It would have to be "short=<length>", not "short,<length>", if I
> recall the previous discussion on width=<w>, etc., on the %(align)
> atom.

Yea, I got confused by "The "align:" is followed by `<width>` and
`<position>` in any order
separated by a comma". Will change, Thanks.

-- 
Regards,
Karthik Nayak

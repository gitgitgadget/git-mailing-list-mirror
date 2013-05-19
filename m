From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Random thoughts on "upstream"
Date: Sun, 19 May 2013 17:24:34 +0530
Message-ID: <CALkWK0mOH8ZpmDR3HWW3j-q9fEpSawNonLDDWixD9LrPcKNnDA@mail.gmail.com>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org> <CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
 <7vobca3465.fsf@alter.siamese.dyndns.org> <7vzjvu1jes.fsf@alter.siamese.dyndns.org>
 <CALkWK0=rHFQ14G8baYpY7gYo+Qb+5a0qOKZGBTrp6BamKC2vRg@mail.gmail.com>
 <7vk3mx1rox.fsf@alter.siamese.dyndns.org> <CALkWK0mLtc8dmMPOcLMez1agF1+ZMUDAUwtwmiKSxOCfyiW0Bw@mail.gmail.com>
 <7vk3mxze8v.fsf@alter.siamese.dyndns.org> <CALkWK0kYKZGhthdrb6-7RD_c2A7E9rscAZU3=JHM-4rYre6w=Q@mail.gmail.com>
 <7vmwrr1pem.fsf@alter.siamese.dyndns.org> <CALkWK0=6L529C452MaNGksL5KeVb+cL1SeC=FwA9veS=tNQurA@mail.gmail.com>
 <CAMP44s3HaEc1UoULYHYnzd_B_VayfedG_Gd1gT27=SeMdp4=eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 13:55:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue2Cv-0007wy-TN
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487Ab3ESLzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 07:55:16 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:50625 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483Ab3ESLzP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 07:55:15 -0400
Received: by mail-ie0-f169.google.com with SMTP id u16so12168535iet.14
        for <git@vger.kernel.org>; Sun, 19 May 2013 04:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=d4B4TsugR5pLDnsGhEc/xBNjSQhBt9DtFpSRynerqCI=;
        b=ymZXk/+ppzjl/Pe5vCUb6YXkUkZ2Kc9LbhTNrz3pMIgi1bvwhvhvkOr+gTP0PBrLOL
         5dLyX7A1Swza+UfDhcK39kLMfmd62iFb0S3F5r2HXFeSappHRZyYdlSU0TzM3zQSjcN4
         18SfVc/+5Ae+xGD5ZGkhnlaAQFkcbwYYXwe6keMLMeQ0apDN5TkLXibjNC2nEGfr9hvP
         AGwYdct0Wv6P2/Ctehw5hyg9AHH09b8FRnwIKjKe7CQkKbw/Y6/dbeRbbhL5/1R1TTPq
         Dw7m3P0s8Mbm48HrV65awoDZeUdo46SDp07vPy4D/YPjxx3P7CtoQKYGaMRdZ4DdBqTw
         m9/A==
X-Received: by 10.50.73.65 with SMTP id j1mr2907237igv.49.1368964514832; Sun,
 19 May 2013 04:55:14 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sun, 19 May 2013 04:54:34 -0700 (PDT)
In-Reply-To: <CAMP44s3HaEc1UoULYHYnzd_B_VayfedG_Gd1gT27=SeMdp4=eg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224872>

Felipe Contreras wrote:
> You can't represent push.default = single either.

Right.  And I propose that we extend the refspec to be able to
represent it, instead of having "single" sticking out like a sore
thumb (and possibly introducing more sore thumbs like this in the
future).

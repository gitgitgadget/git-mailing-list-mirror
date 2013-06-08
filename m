From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] tests: fix autostash
Date: Sat, 8 Jun 2013 21:05:11 +0530
Message-ID: <CALkWK0k6Ut_uiV753cAQLNt7UsCuhMUViEBO5V-Fp7NoCY---A@mail.gmail.com>
References: <1370648714-7872-1-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0=OdcLDCd9OonUS6kBZhA=oz3HYJT8Eiqnh1A++s5yWww@mail.gmail.com>
 <CAMP44s3rYXOmGWR3JM8xy8ON4pqDRhYWVMQqOAyODVr5myq+yg@mail.gmail.com>
 <CALkWK0=qVXL=DtJzYRGFLQQh3_-cGC_t_zpaiTL9KVKN4--mVg@mail.gmail.com>
 <CAMP44s1p-VDMLNhoym5fH3XAn8CWqu2yqGq0mb+55qHOq-r_ww@mail.gmail.com>
 <CALkWK0mBnG7houMKHDorz3oSm=R7u4Va1s=AepSM0CPY6Gy4cw@mail.gmail.com> <CALWbr2x4xGjYXa30vpbK4Q2WAVfmzuz1jNWFyGKSPO0To4P-0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 17:35:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlLBM-0005XQ-RZ
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 17:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801Ab3FHPfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 11:35:52 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:64383 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759Ab3FHPfw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 11:35:52 -0400
Received: by mail-ie0-f178.google.com with SMTP id at1so9155434iec.37
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 08:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nXR8l2AUcPhoZRBlqJ/DhhBanB0WK1cEmyOhPtYim1E=;
        b=wDqBU8fUBeiSwan9cpKt4U1Sui9N8JEpwqL8k5bOFQQlu5agC47RcBEiW8riVEch9q
         2QGL+KcsYXxraPP4eW7md6qatVJp2IPHYGzOfBmeTrmrzIwco7yFE6PP8vNl/aNyhLxP
         K3Ed9ArpbnICRByxiQQNQQ6Vs3H4MBpbYhKkCeok01V8QUk8pqb9hp52UYquUz8bhK3w
         ZCUM65qANqeM41lY9yhYl1FXDdJ4M4jaMhcXj66D8Gv5InWoSjzm5KoZNp/3UPZMlcvR
         kcFKUCzJzXkjp+fb5S3YAiQunGtUYAGUyNXP3eQwxurpYA9e56SqSqh8zhu4HNfrvqfe
         Qmkw==
X-Received: by 10.50.55.99 with SMTP id r3mr1075450igp.0.1370705751675; Sat,
 08 Jun 2013 08:35:51 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 8 Jun 2013 08:35:11 -0700 (PDT)
In-Reply-To: <CALWbr2x4xGjYXa30vpbK4Q2WAVfmzuz1jNWFyGKSPO0To4P-0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226835>

Antoine Pelisse wrote:
>>> The more the test relies on implementation details, the worst.
>>
>> I'm not convinced about this.
>
> My understanding of these tests is that they make sure new/better
> implementations don't break the user experience/defined behavior. If
> the test relies on the implementation, then they lose most of their
> interest.

Makes sense, thanks.

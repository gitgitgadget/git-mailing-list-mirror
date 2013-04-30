From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 17:08:32 -0500
Message-ID: <CAMP44s2FqsK-46QVjHYFkWTqCkcAHZUw+XEbZdV6y=5+sZCJ=A@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
	<7vppxcdjd1.fsf@alter.siamese.dyndns.org>
	<CALkWK0=GbhALxX0G-ka5oAbixoJv4uKPHAx5LPezgTyGxW_3MQ@mail.gmail.com>
	<CAMP44s28aQ7aDCBk=TwPJsb4xoyQMfx85DhaNB4P+XzbgctoPw@mail.gmail.com>
	<CALkWK0m6VeHxwi4ytSFrib2r5GS1acph+WA+YXD80KuBhr74+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 00:08:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXIj0-0003Tw-Q9
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 00:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760097Ab3D3WIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 18:08:35 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:39770 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560Ab3D3WIe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 18:08:34 -0400
Received: by mail-lb0-f182.google.com with SMTP id p10so1002053lbi.27
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 15:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=3Kfk04jl4+8gfvaKFBabwFvpuhvPmq1CU00uasJgqOM=;
        b=SHO/Ie5KGhDsT6fwvQxWnT2cnkNQWs8H8XG7QVpYoVp+NtYs115zHB8M3+adi/89VE
         vaDv8L8ir1EyBnhMNiFGu9aw+QD91QHurqzuXm2iuVX9c7bEDEH/GysnFlJ1oFxzQZJv
         ZOzkcxU31gM3qj72dsxk2dulsQjFgCjaFAaio+vfaH0RJiYglAODHh0D1ncOc2FhJ8+T
         HVFSnAnWTiyoMBmJDogiW2Zroox+NSdE+G1mRm/Z2SzMeqdIm8hnZhwrNtzhOSOvp0Ub
         SAaq+L+imbixEAlnvKakINbhZLzLN5DcaHbQximxYhizYN8UBkr9uCrdzIJtr15dEzF7
         6t/Q==
X-Received: by 10.112.146.133 with SMTP id tc5mr295312lbb.88.1367359712587;
 Tue, 30 Apr 2013 15:08:32 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Tue, 30 Apr 2013 15:08:32 -0700 (PDT)
In-Reply-To: <CALkWK0m6VeHxwi4ytSFrib2r5GS1acph+WA+YXD80KuBhr74+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223025>

On Tue, Apr 30, 2013 at 1:45 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> It's not. The same way master^0^0~4 is not useful, yet it's works;
>> it's a logical result from the syntax.
>
> It's logical if you explain @ as a shortcut for @{0}, and make
> @{0}@{1} resolve somehow [*1*].

But @{-1}@{1} does resolve, and so does @{u}@{1}. So @ would be a
shortcut of @{this ref}, a no-op on the ref.

-- 
Felipe Contreras

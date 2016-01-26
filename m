From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 12/15] ref-filter: align: introduce long-form syntax
Date: Tue, 26 Jan 2016 15:09:57 +0530
Message-ID: <CAOLa=ZSVJXqNUELV-01xFPOhSG9zbFf8iY70NDMB5=2DF420zw@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
 <1451980994-26865-13-git-send-email-Karthik.188@gmail.com> <CAP8UFD0NUoZtJxo_+M2U20AZcHEZiwPms6TBAU_xqBU0+zSk4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 10:40:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO06z-0003Nt-Gd
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 10:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbcAZJka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 04:40:30 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33250 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934067AbcAZJk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 04:40:27 -0500
Received: by mail-vk0-f42.google.com with SMTP id e64so89279692vkg.0
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 01:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5kIBKLFZk8UdLT8AstWtO84Fpxpvxq0U0wjqfE5rN0Y=;
        b=EtWW6P57gEX1BgUERdZpVPkDCdQNt8Z1iGi4l7ScfL4Q9Ac2eZ9QuGJAXh6gAO8cs7
         f4lOhopMgnPT8O47nfw/MCOkYt8Zg2MCtXHcKPJNWzUF8nHhuMLUS+AEde32UIIsob25
         BAv3HYfPJYit6yu4XrvKHaXbbhJ6nkdcZRbO2R5xZZyF5BID9iMNhWXTOuEb2P7VhN/d
         XKSPtyqUKvA+ieUULOEAZMN4iv/jDdfQUd3so4x99aCDdpSFM4ABGe3prpnKuTdTa4VA
         X0tB2ygb6iz88GbTkQDZcwJsWGPaJ3Eh3S5cYehUK3lvuURim803zEH+8X3ZELsXj89l
         mtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=5kIBKLFZk8UdLT8AstWtO84Fpxpvxq0U0wjqfE5rN0Y=;
        b=XDUo42hSuRkWcxSap24C+yWrr0JZc+agsfGc13WBnudJBijfEqOrw3Yr07mlcvKUeM
         T1oaXf2stYTxlOWNZBMhl81ea7s0dDHcPCTNrHFFJsPJCJvZ46IOZdRF7qCv+Yo3o2Vq
         QP3cMyFaZf2MSfTJ3WwxGhUGRtOiekEA7wgBpNXX0NyvYAyhP/nFpQ9LmCHu3L6gMHbS
         eKHPNmFzDnuZURFB9uKOnd3USd/gy+YgckIX/yRbcbbXJ26PGZtLozme/aBot5C7YF+W
         VhYE34xLMFmEF328e0hf2zqrgu3W9iR3gml2r0Vv4dUV2BVPIaUOJ4t8WVU9uziVq2nG
         lg3g==
X-Gm-Message-State: AG10YOQkUaEeiYNO4to1mTu888fk0XG60nmrHrNVQGscEXX3hUugkeuBs4PWHONZSrmmMGnNSwfv8HdZsV42Ng==
X-Received: by 10.31.155.131 with SMTP id d125mr5995264vke.146.1453801226776;
 Tue, 26 Jan 2016 01:40:26 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Tue, 26 Jan 2016 01:39:57 -0800 (PST)
In-Reply-To: <CAP8UFD0NUoZtJxo_+M2U20AZcHEZiwPms6TBAU_xqBU0+zSk4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284795>

On Tue, Jan 26, 2016 at 10:46 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, Jan 5, 2016 at 9:03 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce optional prefixes "width=" and "position=" for the align atom
>> so that the atom can be used as "%(align:width=<width>,position=<position>)".
>>
>> Add Documetation and tests for the same.
>
> s/Documetation/Documentation/
>
> Thanks!

Ah! thanks for that.

-- 
Regards,
Karthik Nayak

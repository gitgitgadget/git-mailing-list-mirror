From: Junio C Hamano <gitster@pobox.com>
Subject: Re: co-authoring commits
Date: Wed, 17 Jun 2015 13:57:12 -0700
Message-ID: <xmqqmvzy59zr.fsf@gitster.dls.corp.google.com>
References: <CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com>
	<xmqq4mm66r99.fsf@gitster.dls.corp.google.com>
	<CAOvwQ4j2bjR1jnLVyZbw1OCE=xQxbCEFGKcK1bpuv1K3s_Y2EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 22:57:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5KOd-00055S-MH
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 22:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbbFQU5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 16:57:15 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37601 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbbFQU5O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 16:57:14 -0400
Received: by igbsb11 with SMTP id sb11so46285627igb.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 13:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=q3hvFS9zf/I4HSwj1B0fde8CgAYF+0ydveyvNQImLcw=;
        b=YsAt5F3ehxgb5awpJGTQKh8J9N6iy93LTzWhk4mzZ+xMl+6IWuJ2IZ+ZacsJV8lifd
         7OCsXsLh2qxFZvBCukKywnNQqDPomClln/S3voKF96TbeK1DAs/qwt2qGdYCEOmB0Vcc
         PUsNXeSUU+Nkd206j0bRhL6idhcVCwUOiM7Sac1ZPWAEOl23TSlte5kNJmblA0Z8+36u
         rAYyo9CgYBeTOqQQGpbGpWyTlSSrI19Zp59yjJIW8Bv9i51CoecQtEaGwnRhWxh303Uw
         xm4fNRN0yRo125CAJfqVLoqJRPTLWRhg4wCglPEJ9K1j2N9weXU7zjKh98FWZ9jgZX/F
         XFdg==
X-Received: by 10.50.141.164 with SMTP id rp4mr38372582igb.2.1434574633467;
        Wed, 17 Jun 2015 13:57:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id u35sm3342339iou.7.2015.06.17.13.57.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 13:57:12 -0700 (PDT)
In-Reply-To: <CAOvwQ4j2bjR1jnLVyZbw1OCE=xQxbCEFGKcK1bpuv1K3s_Y2EQ@mail.gmail.com>
	(Tuncer Ayaz's message of "Wed, 17 Jun 2015 22:26:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271910>

Tuncer Ayaz <tuncer.ayaz@gmail.com> writes:

> On Wed, Jun 17, 2015 at 9:58 PM, Junio C Hamano wrote:
>> Tuncer Ayaz <tuncer.ayaz@gmail.com> writes:
>>
>> > Is this something that breaks the design and would never be
>> > implemented,
>>
>> Yes.
>
> Junio, thanks for the quick response.
>
> I suppose things have changed since Jonathan Nieder's response in [1]
> (2010),...

I do not think there is anything changed.  Jonathan was being a bit
more diplomatic and academic than I am.

"There is no reason in principle some faraway future version of Git
could" is _always_ true as a mental masturbation without taking
reality into account, aka "Sounds doable but a lot of trouble" means
"it is doable but it is dubious that it is worth doing".

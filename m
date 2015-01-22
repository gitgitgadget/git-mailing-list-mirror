From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] test: add git apply whitespace expansion tests
Date: Wed, 21 Jan 2015 22:55:05 -0800
Message-ID: <21FC5344-64BF-46B1-ADA9-DDE3B1FEC8C4@gmail.com>
References: <CAO2U3QjGUfnTRO_poS+=-MfE4aYGuWpVJTe20H-u=FgkVy-RYg@mail.gmail.com> <CAO2U3Qjn9o_eYayEMCC3S6DBr9kVH7mPL00QGrXAnV2iYRP-=A@mail.gmail.com> <CAO2U3Qj-Hg2tb72NgO6wb-aqAxFG7aga2ZDeZNDCPJzGtmHTAA@mail.gmail.com> <CAO2U3Qhd_DPP09BUyMr6NKUtOe4EQQ7G83BRg7MbtQXFPjKv8w@mail.gmail.com> <CAO2U3Qje-YwcV1d5BK_zZqrTki4AU=emdkUZzEEieRjmoQdmGg@mail.gmail.com> <CAO2U3Qi4TWZiNoOQVSW=Ycvp3bpBySZrCGmRLCbRJJes_n2Wkw@mail.gmail.com> <99579252-EF8A-4DAF-A49D-2AC5627ED9E3@gmail.com> <4157F6B0-DDF4-4F71-A09B-EE216537CA89@gmail.com> <xmqqbnly1oqo.fsf@gitster.dls.corp.google.com> <xmqqzj9iz3gu.fsf_-_@gitster.dls.corp.google.com> <102e322e68e78e39a7c227f3f3e102c@74d39fa044aa309eaea14b9f57fe79c> <CAPc5daXVk_ROUy7rmzS0aosWvE2wqw8tHZgomHHkay9CZjhbiw@mail.gmail.com> <AB9246EB-D720-4A4A-9AB7-4307613C19A3@gmail.
 com> <xmqq1tmnwypp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>,
	Michael Blume <blume.mike@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 07:55:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEBfe-0004BF-Nj
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 07:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbbAVGzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 01:55:11 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:41774 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbbAVGzI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 01:55:08 -0500
Received: by mail-pd0-f173.google.com with SMTP id fp1so29815882pdb.4
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 22:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=apx0rQxFsJVhCGNP9srugMkHrJq9AsZb/dNPzM0F2YQ=;
        b=Y/F5LQnNsQ0O9H6CrUrEjBCaEwHO9MFps8KmYLI81INj+t6OyjpTJLUUtF995f/BWI
         H9KqlVdlLUC71aH4CQAveCEd2o37+udgjm0kqLQmxKZTQc0sM+3VGGeClsmNxvh/PGE7
         j2lutKpxiEffKr40cgoZJxS4/kqOap7HYUzabsvMBETahnY/b0+z7q16U/XaKNb4g5c4
         cZ+671+msm9fQHztAVXmskDR8wmD/Q3pUV+kQe4HSw1XYX9/rxDl5NHTZK3T9Ht2t6Pp
         TuSF1cYM7b2ZYn83t7REFVWgkex5LavNE2Jsl1396fBhDjF15S2qFZ5hb/ngTJlS6XC9
         mHOw==
X-Received: by 10.66.156.229 with SMTP id wh5mr68694061pab.119.1421909708407;
        Wed, 21 Jan 2015 22:55:08 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ps9sm7867512pbb.21.2015.01.21.22.55.07
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 Jan 2015 22:55:07 -0800 (PST)
In-Reply-To: <xmqq1tmnwypp.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262799>

On Jan 21, 2015, at 14:33, Junio C Hamano wrote:

> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> So since I've not been able to get test 2 or 3 to core dump (even
>> before 250b3c6c) I tend to believe you are correct in that the code
>> thinks (incorrectly) that the result should fit within the buffer.
>
> Thanks; let me steal your tests when I reroll.

Awesome. :)

But please squash in this tiny change if using the tests verbatim:

On Jan 18, 2015, at 02:49, Kyle J. McKay wrote:

> +#
> +## create test-N, patchN.patch, expect-N files
> +#
> +
> +# test 1
> +printf '\t%s\n' 1 2 3 4 5 6 > before
> +printf '\t%s\n' 1 2 3 > after
> +printf '%64s\n' a b c $x >> after

This line ^ in test 1 should not have a '$x' in it.  It should just be:

> +printf '%64s\n' a b c >> after

The test runs fine currently, but if somehow x should get defined  
before running the tests, test 1 would fail.  All the other '$x' in  
the other tests are correct.

> +printf '\t%s\n' 4 5 6 >> after
> +git diff --no-index before after | \
> +sed -e 's/before/test-1/' -e 's/after/test-1/' > patch1.patch
> +printf '%64s\n' 1 2 3 4 5 6 > test-1
> +printf '%64s\n' 1 2 3 a b c 4 5 6 > expect-1
> +
> +# test 2

-Kyle

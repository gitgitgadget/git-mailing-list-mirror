From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: return non-zero error code if format-patch fails
Date: Mon, 06 Jul 2015 10:01:28 -0700
Message-ID: <xmqq1tgl2pav.fsf@gitster.dls.corp.google.com>
References: <20150702091133.GA13353@musxeris015.imu.intel.com>
	<xmqqpp493z8f.fsf@gitster.dls.corp.google.com>
	<20150706085326.GA30731@musxeris015.imu.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Andrew Wong <andrew.kw.w@gmail.com>,
	Jorge Nunes <jorge.nunes@intel.com>
To: Clemens Buchacher <clemens.buchacher@intel.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 19:01:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC9mD-0005xQ-6h
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628AbbGFRBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:01:48 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35530 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495AbbGFRBs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:01:48 -0400
Received: by igcqs7 with SMTP id qs7so14519929igc.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=CmIR2ZiM7gIjJACgCRPXjVPwTkR4aOyC5uVaueHLsUM=;
        b=sEcLuFFxISFCCSfKZoWCtFA6X4HEkvjZhh9nNH2+O8LJPwkWqrgXKhG1nnSLX1AIHu
         vN0xmtuAFEPbylPfsnLlGJybHzFhhp4y5ytup1lR4HF4dN9ZXWOW2/2q/1tC+RGz9fg2
         Gq5jISPYLPzBmRnl2Xuf6PRimph2v3PRl5Fy9pOPP5lpxjygzsuzySMhRyRnE5V7vqgL
         4IBqMSQW/sw/oxu1Bc6Tv4ONZCPc6GrzyMD0kb21vmH0wB66bQ9ItOlDKVytEFZ6LaWW
         e5PsUgqCXGl5aVv7Ofs2gpbI/V6tmibIjgO5aP/IAKHo1I+kxJ6oQvPUG0Y5sMvfP7xx
         t3HA==
X-Received: by 10.107.39.209 with SMTP id n200mr75629114ion.59.1436202090086;
        Mon, 06 Jul 2015 10:01:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by mx.google.com with ESMTPSA id x4sm12797695iod.26.2015.07.06.10.01.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 10:01:29 -0700 (PDT)
In-Reply-To: <20150706085326.GA30731@musxeris015.imu.intel.com> (Clemens
	Buchacher's message of "Mon, 6 Jul 2015 10:53:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273406>

Clemens Buchacher <clemens.buchacher@intel.com> writes:

> On Fri, Jul 03, 2015 at 10:52:32AM -0700, Junio C Hamano wrote:
>> >
>> > Cc: Andrew Wong <andrew.kw.w@gmail.com>
>> > Signed-off-by: Clemens Buchacher <clemens.buchacher@intel.com>
>> > Reviewed-by: Jorge Nunes <jorge.nunes@intel.com>
>> 
>> Where was this review made?  I may have missed a recent discussion,
>> and that is why I am asking, because Reviewed-by: lines that cannot
>> be validated by going back to the list archive does not add much
>> value.
>
> Jorge helped me by reviewing the patch before I submitted it to the
> list. My intention is to give credit for his contribution, and to
> involve him in any discussion regarding the patch. Maybe it makes more
> sense to say Helped-by:?

Thanks; I think that clarifies it, and I think that is how people
seem to use Helped-by around here.

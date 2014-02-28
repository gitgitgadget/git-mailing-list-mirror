From: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
Subject: Re: An idea for "git bisect" and a GSoC enquiry
Date: Fri, 28 Feb 2014 10:00:53 +0100
Message-ID: <CAL0uuq23E+2gX14yAyeGFPySV0qTF8=-642PHqmogTDwz7F8Sg@mail.gmail.com>
References: <CAL0uuq0=Zo0X8mYRD6q-Q+QAcZhfmxOwKiRegDrRm3O_i0Q+EA@mail.gmail.com>
	<xmqqzjld3ate.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 10:01:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJJJU-0006fC-Ei
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbaB1JAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:00:55 -0500
Received: from mail-vc0-f170.google.com ([209.85.220.170]:46981 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbaB1JAy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 04:00:54 -0500
Received: by mail-vc0-f170.google.com with SMTP id hu8so437708vcb.1
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 01:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IGrp2dKfq3Gdb/ocDygw0Hf1uKHJJDyZf/ISH5i3UpQ=;
        b=d154HKv+9eG0E0aqorindLGIpJyXm/sMbtiyZ/TNd19sdH9rTY6Br2TFimZTabk6gD
         GvSkgFtXblC0g3A77uwidXENwaOLZ16nwkHO0XZ8/MPwaqzMVmQ/0SuAc4vKDXpulJ86
         RSMWWcCuQRwEPDppKwfv/NxpMbcSFFBu7kwiyQ6wEzqYox66sNqvSVKsAuHA+G/aqJxw
         YI7+xWMPQSpWue7sHnjtBMgnR8Hk+yfPg9PLm8Jnfmbzx5eTvJIa9nd3wdusF3p9qOCQ
         kNWX5uNBoIWXmHSn8iV+Cq9fuf2FGqjz49GvgAnjG1j7YOvvBHfSPvCRQ/dyYoXNM+/S
         +vsA==
X-Received: by 10.58.4.138 with SMTP id k10mr1510749vek.8.1393578053848; Fri,
 28 Feb 2014 01:00:53 -0800 (PST)
Received: by 10.52.73.161 with HTTP; Fri, 28 Feb 2014 01:00:53 -0800 (PST)
In-Reply-To: <xmqqzjld3ate.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242908>

Mh. Haven't thought of that. I have no experience with TK, so I'm
having trouble digging up where the "good" and "bad" labels in the GUI
are generated.

I guess that a solution might involve writing a temporary file in
$GIT_DIR called something like BISECT_LABELS in which the chosen
labels are listed and reused across all tools that require them.

(Sorry for sending this email twice, I thought I had sent it to the
list as well!)

On Wed, Feb 26, 2014 at 8:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacopo Notarstefano <jacopo.notarstefano@gmail.com> writes:
>
>> Does this make sense? Did I overlook some details?
>
> How does this solve the labels shown in "git bisect visualize"?
>

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Flags and config to sign pushes by default
Date: Fri, 14 Aug 2015 13:45:40 -0700
Message-ID: <xmqqwpwxha4r.fsf@gitster.dls.corp.google.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
	<xmqqbne9ivry.fsf@gitster.dls.corp.google.com>
	<CAD0k6qSjZW-5eMw-OOHP0cGdj08PesdKVgE9OAFvESwCueyH6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:45:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQLrI-0003CQ-18
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 22:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbbHNUpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 16:45:43 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33300 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbbHNUpm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 16:45:42 -0400
Received: by pabyb7 with SMTP id yb7so66460117pab.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 13:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=a2TPTl4ZiroEWCKkSVfwk18UcPXoerIcChAUE4KOvbY=;
        b=caW+K7Bp+IOj/QjVK8lCSeLFTNJ6/se4IWNu19y1GEDbo7LzYaET3F4asajzsQCbnA
         89Yn2cvsaMAIIlACYlXElxtBWO9QgvNd8RQMXGVQ23QbXJ39Ex1FLoBhX53uDn3pQKie
         gJlCM+rrVZlvaDV0JQ/b8EasplwyzEuKEqR4Nj+8QDlfUe0GYoqxq7kwj15NNjIjXDr0
         e5jrcAFAXjc5vkSdjSA0fwt85VFaoqNC3udRZ/MUAou9WO0x1Bwou2sJPoF0KHgQ9V0U
         qwQLy+hrDBHA/DkF7U7odtKhc75qjRd04uNaxbCd2USpOc1cN/QyjplQiCmrvZqO/bZ8
         bhOA==
X-Received: by 10.68.184.197 with SMTP id ew5mr91685180pbc.145.1439585142124;
        Fri, 14 Aug 2015 13:45:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a820:aa0d:2b52:954f])
        by smtp.gmail.com with ESMTPSA id q7sm7012431pdj.31.2015.08.14.13.45.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Aug 2015 13:45:41 -0700 (PDT)
In-Reply-To: <CAD0k6qSjZW-5eMw-OOHP0cGdj08PesdKVgE9OAFvESwCueyH6w@mail.gmail.com>
	(Dave Borowitz's message of "Fri, 14 Aug 2015 16:31:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275942>

Dave Borowitz <dborowitz@google.com> writes:

> On Fri, Aug 14, 2015 at 2:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Yes, it looks somewhat strange.
> ... The straw-man
> strangeness is that two of them are the traditional boolean values
> "true/false" and the third is "file not found^W^W^Wif-possible" :)

It actually is not uncommon for a Git configuration variable to
start its life as a boolean and then later become tristate (or more)
as we gain experience with the system, so don't worry about it being
"strange".  A tristate, among whose choices two of them are true and
false, is not "strange" around here.

By "strange", I was referring to the possible perception issue on
having a choice other than yes/no for a configuration that allows
you to express your security preference.

Thanks.

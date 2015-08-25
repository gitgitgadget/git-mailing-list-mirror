From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v13 02/12] ref-filter: introduce ref_formatting_state and ref_formatting_stack
Date: Tue, 25 Aug 2015 15:56:56 +0530
Message-ID: <CAOLa=ZRvzM4xyZi09aDrepAZZ9ovKxz08mA9aHjUNpqddfW-8w@mail.gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
 <1440214788-1309-3-git-send-email-Karthik.188@gmail.com> <xmqqr3ms2vvh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 12:27:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUBRz-0003WJ-Up
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 12:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbbHYK11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 06:27:27 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36662 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbbHYK10 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 06:27:26 -0400
Received: by obkg7 with SMTP id g7so137878501obk.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 03:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7sXMRlTFn6MCaW+V61lCJSaKXjqsJw/yKYmVun3w82k=;
        b=Li204AbtZ6xpayuFlWdokkp27ByFdM+tclzk7ykNH1UX1whszNSqtE5v9an35pLBAI
         /zYXiVV7FLmIxz9oe2Lt4M3QEYyo3vviQio23M6Ix3Ssafealfet8TM2datRkmWUXP4R
         N1EvvlMpMt+xqf0suEHQ5IYmBcqvhgf1Lb79d7mYYjMExbRRMY/Xb8uAlImbmH2gnyN/
         Ev43FOyr0m/kH6IpRzrfgNDHA2kS/FWaBmTll8v8O77iu/796QwcDbq6rz2rKEODDBbW
         nM6mknuqd1zTKawT/uGxBi9OyC7/K7kumKmuEnJ9qRhS0ALsVzSep5pDzzjYzkkWvoOT
         jBrw==
X-Received: by 10.60.65.68 with SMTP id v4mr25349243oes.84.1440498446211; Tue,
 25 Aug 2015 03:27:26 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Tue, 25 Aug 2015 03:26:56 -0700 (PDT)
In-Reply-To: <xmqqr3ms2vvh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276514>

On Tue, Aug 25, 2015 at 3:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +static void push_new_stack_element(struct ref_formatting_stack **stack)
>> +{
>
> Micronit.  Perhaps s/_new//;, as you do not call the other function
> pop_old_stack_element().
>
> The remainder of this step looks pretty straight-forward and was a
> pleasant read.
>
> Thanks.

Will do, thanks for reviewing :)

-- 
Regards,
Karthik Nayak

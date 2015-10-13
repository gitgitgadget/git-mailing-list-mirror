From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 09/10] branch: use ref-filter printing APIs
Date: Tue, 13 Oct 2015 23:13:27 +0530
Message-ID: <CAOLa=ZQ5nC7bqz2gLYvO2LxBrMhkf+Ga42h3SkQOzvd78OVYxA@mail.gmail.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
 <1444295885-1657-10-git-send-email-Karthik.188@gmail.com> <xmqqr3kyafxa.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 19:44:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm3cI-0003Fa-Or
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 19:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbbJMRn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 13:43:58 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33880 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932403AbbJMRn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 13:43:57 -0400
Received: by vkat63 with SMTP id t63so14966520vka.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 10:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ek6U20+JN4dh0UcdMSumPzTl4beWpMrplXn1T9yvHIQ=;
        b=vEOBVGWrSukmsmbVGxxexhjnH+7FpfZNqSv/bHkx6zmtBTRCXQE6km7l3P2MKEkMRj
         YWqy2K2qk5uO3S+RjShwYR98hXbayclvtSf0WFIN1UAy5CsElRUz7D4Wt4NreagMagZX
         uhr00lEDCct3bK9F/gh/n5QI2IM0J09zt3GOKWvmdEQ1KErAoxupAl7FqpuyCfrRS3RP
         ZnVfR2ZduK2kh4HN1YOrQJmR97bh7nL5KF+2l+Unfvs7mCa1E+4gokgzvz41RHK4RuD2
         v2uuJsiXErKABHmQ8VUupvWIdWwpIxc+fMhMfPo9bC295MEZCqb042ZYNmRizn1MN9z7
         9hRw==
X-Received: by 10.31.178.198 with SMTP id b189mr19167375vkf.114.1444758236586;
 Tue, 13 Oct 2015 10:43:56 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Tue, 13 Oct 2015 10:43:27 -0700 (PDT)
In-Reply-To: <xmqqr3kyafxa.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279507>

On Tue, Oct 13, 2015 at 10:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Port branch.c to use ref-filter APIs for printing. This clears out
>> most of the code used in branch.c for printing and replaces them with
>> calls made to the ref-filter library.
>>
>> Introduce get_format() which gets the format required for printing of
>> refs. Make amendments to print_ref_list() to reflect these changes.
>
> Is it get_format() still?

Will change that, thanks :)

-- 
Regards,
Karthik Nayak

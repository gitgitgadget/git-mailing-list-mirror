From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [WIP/PATCH v4 6/8] for-each-ref: rename some functions and make them public
Date: Tue, 02 Jun 2015 00:58:47 +0530
Message-ID: <AD4CBEF2-90E7-4C75-89BF-A7C3E9F367B2@gmail.com>
References: <5569EF77.4010300@gmail.com> <1433008411-8550-6-git-send-email-karthik.188@gmail.com> <CAP8UFD080Yuv-CYcDzAG0u6OV7Sqry=0s1HKoJbt5wfKjTNO3Q@mail.gmail.com> <CAP8UFD1TTMfruCE-+GT-LzhK5C9LorStPbn64tZ-hhAkC=8Bdw@mail.gmail.com> <556AD1B2.3080502@gmail.com> <CAP8UFD117bJotFQSGjGnSub_0Xq=3wH2o3Du4c49xvmMxAyFDQ@mail.gmail.com> <vpqoal0hr0e.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 21:29:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzVOO-0005uw-Sq
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 21:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbbFAT2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 15:28:55 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34444 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbbFAT2y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 15:28:54 -0400
Received: by pdbki1 with SMTP id ki1so114703896pdb.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 12:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=T01sLeHDGhJuYtPRFI+NshMafhTtROZjKcUmx89laOc=;
        b=r/wlsUgF0GyuUOG3za4+5yT0jC7QoOr5fWailHP++DYzSZHA/DGX6/sbnNxhQ7hXQc
         pKJ//h4+c8FAD+NhqyuO7Z0dfhJsizyQ+3prZ8BlurK9+a4Jfx0pNrGrRPnuf1xeglFo
         TBehaCfPB4zH8R5PsuONteh2SFJqtG1qyj2HeBB1GZGIyCTUuMtTmynmm0Ez4S/QM9mW
         X+I7MKHYxIr2tbEujfVaUqtwSDy7kFtCzet7wbbbbjiP6Hc94b99LoFEqAYLSSny8jx9
         M24z7Js2v1TT3NS1VdGAmLC6YHum0Gu6nnyR6mrdNL42NTWfTR9UzTg3i4y0CsU2ig0E
         PEbA==
X-Received: by 10.68.245.67 with SMTP id xm3mr5642513pbc.45.1433186934268;
        Mon, 01 Jun 2015 12:28:54 -0700 (PDT)
Received: from [100.104.141.60] ([49.15.131.86])
        by mx.google.com with ESMTPSA id ng13sm15324212pdb.82.2015.06.01.12.28.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2015 12:28:53 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <vpqoal0hr0e.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270462>



On June 1, 2015 12:08:57 PM GMT+05:30, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>Christian Couder <christian.couder@gmail.com> writes:
>
>> sort_refs() -> ref_array_sort()
>> struct ref_sort -> struct ref_sort_criteria
>> default_sort() -> ref_default_sort_criteria()
>> opt_parse_sort() -> opt_parse_ref_sort_criteria()
>
>BTW, having such summary in the log message would help review: we could
>think and discuss the naming by looking just at the summary, and then
>check that you did it correctly (easy).

Yes agreed, will do that.

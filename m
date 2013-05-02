From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/9] t1508 (at-combinations): document @{N} versus HEAD@{N}
Date: Thu, 2 May 2013 23:08:56 +0530
Message-ID: <CALkWK0kTB+QMbrfpCi8=tJ_wePycSp7MvV6quUJxn0Sdj5jDEw@mail.gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
 <1367501974-6879-6-git-send-email-artagnon@gmail.com> <CAMP44s1Hkff1QU7undZvLfFOCeeiBrB4RRtVEOoNCsfoGZu7yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 19:39:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXxTp-00018A-N0
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 19:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759734Ab3EBRjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 13:39:37 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:58698 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757005Ab3EBRjg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 13:39:36 -0400
Received: by mail-ie0-f174.google.com with SMTP id 10so949250ied.5
        for <git@vger.kernel.org>; Thu, 02 May 2013 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=RzelHZ72P3OabvG9vmF6W+nf5i8RJC7E2X6EyweO1uc=;
        b=ajzg+ryhhrQdpXdbkwDv9RmAvDW0XorFPKpZjFtYJulhlcsVjYEq1CugeiKQFyCFcR
         9/nrhHLDMhzEPkKtxZl9vsGkACQ44wQh2YiPOelHxLcIXigrv5kZaBdbgIXRMGNcknTt
         smfBNrRDZlw635xqQl/LVN2t+Yb9V5T+59H+WH6L8JFu+h1Lhbbk6cdVSnoT7skZ1DUq
         gOf6JmeCRJFpdycoVufA37/EvNSmL+znCWgze7yR8JIAVYUwdDGX68bhF6k1ZqTgtU+0
         N3lXVUR3qGhYDvIrKPPg2SgfeSZRSdfGTWrAEbyI2Uirk5F5/r8AxbIgH+A5BCJoYBmt
         /RJw==
X-Received: by 10.50.57.200 with SMTP id k8mr15597191igq.44.1367516376523;
 Thu, 02 May 2013 10:39:36 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 2 May 2013 10:38:56 -0700 (PDT)
In-Reply-To: <CAMP44s1Hkff1QU7undZvLfFOCeeiBrB4RRtVEOoNCsfoGZu7yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223239>

Felipe Contreras wrote:
>> +# Document differences between @{N} and HEAD@{N}.
>
> That's enough explanation, except that we not documenting them, we are
> testing them.

The difference is subtle, and I couldn't find this documented clearly
anywhere else.  If someone comes asking what the difference is, just
point to this comment along with the tests.

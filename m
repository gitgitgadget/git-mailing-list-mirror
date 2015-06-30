From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 06/11] ref-filter: implement '--merged' and
 '--no-merged' options
Date: Tue, 30 Jun 2015 21:34:56 +0530
Message-ID: <CAOLa=ZRjHBEjiVQ55EXNsJjjRDJNnC7pBziNPYtGBht2fYU1wQ@mail.gmail.com>
References: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
 <1435222633-32007-1-git-send-email-karthik.188@gmail.com> <1435222633-32007-6-git-send-email-karthik.188@gmail.com>
 <xmqqegkubddy.fsf@gitster.dls.corp.google.com> <CAOLa=ZSqvtXioRzeekjCAL3HoFsQmaLKQF=9YmftjQasiHvpqg@mail.gmail.com>
 <xmqqfv5989yg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 18:05:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9y2O-0002iT-Ml
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 18:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284AbbF3QF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 12:05:27 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33914 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbbF3QF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 12:05:27 -0400
Received: by obbkm3 with SMTP id km3so9684181obb.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 09:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZxoERRNVKnBRYxzPWYsiDp9eKqeOR7sMXXOvOyiORvs=;
        b=Jb1AKZnWj/U3F2jrbNlIoQ+oJc3GHMTWyl8D/JB2q1eGNa2lnXAnRokAz7wd9F+jRA
         4h1ilXsmnkfcMfmTy5kAlyxoCTpbvPP7Ql5Pp9DWNNgYQAlTwZ0JmdsK0btf9X/ghTa/
         BAsfN9z8BED8cTfLSQSH5cDdy6ky0jDRCNBPRn1nSlspAF6/tF3oo2lrTSEod/toPC56
         bdLPiCdviPBlq4LlIJsEZ+v1dQUGb6iN0dJx961hw6KGqgXheHn0ZwtPdX3VEO7EHnfs
         7T27JdduN15VekmOY6AtoS+J+3n9qtUL1ATAoyGSFKiBc2SQXq3xyEcAjnERQ9qF7hxJ
         wNGg==
X-Received: by 10.202.200.11 with SMTP id y11mr19522253oif.111.1435680326233;
 Tue, 30 Jun 2015 09:05:26 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Tue, 30 Jun 2015 09:04:56 -0700 (PDT)
In-Reply-To: <xmqqfv5989yg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273076>

On Tue, Jun 30, 2015 at 9:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> I also have a feeling that compared to an implementation based on
>>> paint_down_to_common(), including is_descendant_of(), this may be
>>> less precise (e.g. it would be confused with clock skew that lasts
>>> more than SLOP commits).  If we are inventing a new helper (as
>>> opposed to moving an existing one), we'd probably be better off
>>> doing a thin wrapper around paint_down_to_common() than calling
>>> revision-walk machinery.
>>
>> I'll have a look and get back to you.
>
> Not as part of this series, now I know it is a straight-forward port
> of what we already have for "branch --merged".  This series is not
> yet about improving counting logic but first unifying the three.
>
> Thanks.
>

Sure, added this to my personal TODO :)

-- 
Regards,
Karthik Nayak

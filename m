From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2] Documentation/SubmittingPatches: Explain the rationale
 of git notes
Date: Mon, 29 Dec 2014 15:21:41 -0800
Message-ID: <CAGZ79kZxsWZRdaQ-0_9Ou3y0KOruD0WVrC0Drkjgu=TbgUjiSA@mail.gmail.com>
References: <xmqqwq5ja7s2.fsf@gitster.dls.corp.google.com>
	<1419874942-9901-1-git-send-email-sbeller@google.com>
	<CAPig+cQgG5Ua-k1D8yKF5K+tfXeSB_wTN9W3m08F+K7AtKWDaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 00:21:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5jdD-0003Hs-Mz
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 00:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbaL2XVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 18:21:43 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:48091 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbaL2XVm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 18:21:42 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so13012723igi.1
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 15:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=x2gM89pZxY3KpZmeM/0Fw4CRKUUlXJ04xDei0s76L/s=;
        b=Rpw60+yfyBRg+kuKvj4Cxk1m2H099+SmLOFaTPpmxnkU8HtuS5WsZiV6JP4QNR4C3O
         D9zi56t1QcQX/RYp8ySu/69BpwdOXymhvu2aSzvwoCKIAYNC7FdGMJlVh6JMzLB5kkd3
         vlLjhVSGEqWLt+M3HwvrxjJd/DOfJf/qoEVWnAHdgMP5Vmlx+oLy2jZo85oW6v7qSjbO
         GZuY1Y2TadngfocrLG0TITD8G58UW9V2jjf6uX4Op15NlUpQ8rGX6j+3Lfkh/qcU8btB
         36myCOtQ2W4LAx0lwamli1ck+8f5NJMKtEA/vvLn+d/+71bgg0jSKH9P3Gcv8y02447H
         CHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=x2gM89pZxY3KpZmeM/0Fw4CRKUUlXJ04xDei0s76L/s=;
        b=L9qp38n55ukWNvFxe6rE7xLxF+W2xIT2dvlrb5sCdC++Q/e5T8mAbWHnsMN0gsQrBV
         Rw0OYhRj0eOtIQhNuMkEbZJ2BuksAGVsdl28weljEFLj32WRrBaUkJBN8hdHo8fxnusQ
         zYPWX9bW8AGpb9UHDAhj46jXzA0CYI4BuroVptW3bsg+5PJJUYrc5ygIRIFsN7ZKJOex
         Fu6sGWAN4kjuAs6CrOrbHuFpQD5O+YQkn7Kq/lDE/vG+vFCPuBxNqrwFQeCkxs8C523w
         Jqy0htM5D8AsoIndR6F1O9C9U7ltMYOC33VsOD/+GLhUypsr726RFKP8ehr+o47EMPs/
         +fpA==
X-Gm-Message-State: ALoCoQliBGGcRY4wotRakWRhZOs/yTxpVyTdki/vFTPtOkDXinpF/6eh/5CIxh4SanZG6M8MHDN1
X-Received: by 10.107.25.74 with SMTP id 71mr52733876ioz.70.1419895301653;
 Mon, 29 Dec 2014 15:21:41 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Mon, 29 Dec 2014 15:21:41 -0800 (PST)
In-Reply-To: <CAPig+cQgG5Ua-k1D8yKF5K+tfXeSB_wTN9W3m08F+K7AtKWDaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261898>

On Mon, Dec 29, 2014 at 3:18 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Dec 29, 2014 at 12:42 PM, Stefan Beller <sbeller@google.com> wrote:
>> This adds more explanation of why you want to have the --notes option
>> given to git format-patch.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
>> index e3c942e..f42c607 100644
>> --- a/Documentation/SubmittingPatches
>> +++ b/Documentation/SubmittingPatches
>> @@ -177,7 +177,12 @@ message starts, you can put a "From: " line to name that person.
>>  You often want to add additional explanation about the patch,
>>  other than the commit message itself.  Place such "cover letter"
>>  material between the three dash lines and the diffstat. Git-notes
>> -can also be inserted using the `--notes` option.
>> +can also be inserted using the `--notes` option. If you are one
>> +of those developers who cannot write perfect code the first time
>> +and need multiple iterations of review and discussion, you may
>> +want to keep track of the changes between different versions of
>> +a patch using notes and then also use the `--notes` option when
>> +preparing the patch for submission.
>
> Perhaps this could be rephrased in a less derogatory fashion like this:

This wasn't meant to be derogatory at all. It was more of subtle humor.
Sorry for the confusion.

If this is offensive in any way I'd rather go with your suggestion indeed.

>
>     ...material between the three dash line and the diffstat.
>     For patches requiring multiple iterations of review and
>     discussion, an explanation of changes between each iteration can
>     be kept in Git-notes and inserted automatically following the
>     three dash line via `git format-patch --notes`.
>
>>  Do not attach the patch as a MIME attachment, compressed or not.
>>  Do not let your e-mail client send quoted-printable.  Do not let
>> --
>> 2.2.1.62.g3f15098

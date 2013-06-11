From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 45/45] tests: update topology tests
Date: Mon, 10 Jun 2013 23:41:47 -0500
Message-ID: <CAMP44s27ZRpUuEvt8DZyzqoB5AovEkM1HMPEi-kxpZg9STsU4g@mail.gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-46-git-send-email-felipe.contreras@gmail.com>
	<CANiSa6iFYgkgXJ9SdkiOJc-iwfCxfsoU+Nfs5hjhx45Am=kixw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 06:41:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmGP3-0004us-Sa
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 06:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535Ab3FKElu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 00:41:50 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:53538 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab3FKElt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 00:41:49 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so7054383lbh.35
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 21:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=q+PKpEoGoii3zgZcXz+pktieQcL4qoh8dQmVi8+AH7A=;
        b=Frc8XIli0jcUwcPJeRp75BwrcRQVU+RBL/uRIqh65+Nn0um6MCB3qVFrSCGWn14Igj
         6ojwuk94iQkTFTiQMGtoaHzvC0VLxw/7Ee+p2kegNkpo00Enxycrkhii4s2Tix+1Xpd2
         v0D39jXqw77lkHYChkleq998mLbletYC74JL1h3E2YiGRVZwFfFGTdX7WhMCXiz3KLnd
         R8bkZ+iDkc0owbiGf+EMK17260477+6fNsvpWon0h9X4MEilvSFuKq0L1HpqH+0b0k2K
         iQCYUlviIaC8cFtmrMecM7LmSX6UHy5eFoekAiEnHDKJloBDatZKvfmEm0d9z1FzQadO
         9idw==
X-Received: by 10.152.22.73 with SMTP id b9mr6471828laf.36.1370925707848; Mon,
 10 Jun 2013 21:41:47 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Mon, 10 Jun 2013 21:41:47 -0700 (PDT)
In-Reply-To: <CANiSa6iFYgkgXJ9SdkiOJc-iwfCxfsoU+Nfs5hjhx45Am=kixw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227416>

On Mon, Jun 10, 2013 at 11:37 PM, Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
> On Sun, Jun 9, 2013 at 9:40 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  t/t3425-rebase-topology-merges.sh | 15 ++++++---------
>>  1 file changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
>> index 5400a05..96cc479 100755
>> --- a/t/t3425-rebase-topology-merges.sh
>> +++ b/t/t3425-rebase-topology-merges.sh
>> @@ -70,9 +70,8 @@ test_run_rebase () {
>>                 test_linear_range "\'"$expected"\'" d..
>>         "
>>  }
>> -#TODO: make order consistent across all flavors of rebase
>> -test_run_rebase success 'e n o' ''
>> -test_run_rebase success 'e n o' -m
>> +test_run_rebase success 'n o e' ''
>> +test_run_rebase success 'n o e' -m
>>  test_run_rebase success 'n o e' -i
>
> If you do end up re-sending the series on top of my series, I'd prefer
> to see the end result having the first argument inlined, so these few
> lines become simply:

Somebody else would need to do that, there's no point in me sending
these patches, just to increase the number of my patches that get
completely ignored by Junio.

-- 
Felipe Contreras

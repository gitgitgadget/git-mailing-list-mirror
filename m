From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2] git-p4: add P4 jobs to git commit message
Date: Thu, 21 Apr 2016 08:34:49 +0100
Message-ID: <CAE5ih78r=14fPdk76H=VBYbvFj7eqKrdoEEbaX9+vo+G_HREVA@mail.gmail.com>
References: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
	<xmqqshyi2yb7.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7-2mefGwfXRhvQZJFPD4QYAzZ1jYG82s6cnDzWVCiDS8w@mail.gmail.com>
	<xmqqfuuh35v5.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxZkYTm7_m-Eeq-acN=Nse1vLGk8Gm44BihVGi27KaGiw@mail.gmail.com>
	<xmqq7fft32y9.fsf@gitster.mtv.corp.google.com>
	<CABEqOBwqW+BO4rtOx4ax35VacE4RZhpo_1pbqzTP_EGiSWasiQ@mail.gmail.com>
	<xmqqh9ex1lsy.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxkHstqRHFUYF7=eComB-HwUGwi0tpWbhvUuKiny-=Vyw@mail.gmail.com>
	<CABEqOBxY61yObr0FeUxPYxc6C+xvde1LOS7zS_dHpBqwemJ+dQ@mail.gmail.com>
	<xmqqd1plz4p5.fsf@gitster.mtv.corp.google.com>
	<CABEqOBx4vCUpYTGYM9VF6QHxGGgQSG5APSHymtbV7uVxAbU+ow@mail.gmail.com>
	<xmqqzispxoqt.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7_7TeJDekoubzJ=ZPT_JUwQVyGczDt5yORZES89Qo=VjA@mail.gmail.com>
	<xmqqtwiwwa5x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jan Durovec <jan.durovec@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Roberto Tyley <roberto.tyley@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 09:34:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1at98Z-0004kM-Sh
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 09:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbcDUHew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 03:34:52 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:36404 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbcDUHev (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 03:34:51 -0400
Received: by mail-oi0-f46.google.com with SMTP id x201so71786163oif.3
        for <git@vger.kernel.org>; Thu, 21 Apr 2016 00:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=XHR+x74cccTtvVu5vg+6OiZQH28F6AJlh1MAHBYOsBE=;
        b=ZzizBQ0RFDX0GOx+E55pAKPQhbh1F0z5vAvRy/C/9OqegoryW3mo0Kdr9LZeT7Vmae
         /q4AdME0eFBygXAZnkpwkoq0fYX2VFXbv0Dn+HEENvJFRTpB1cKOXCrkBaUl7sY5q0MY
         GR0zWFI2n8zzVMeS/DpNLJciNr0YLTsjgLnKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=XHR+x74cccTtvVu5vg+6OiZQH28F6AJlh1MAHBYOsBE=;
        b=NAWtMz09+2Ei09YvT2WfcL+W8lk0ZDW13b8lBjSCGYKcc8X/oRr3js4Q6cq1RJNsNu
         cRgwM3obBxOxn6BchLNIFUg52JFDI7RQIpX7nUpCzxndZWdKgT+sDSpm71UdMnOFWhWY
         BzUjft0nAk99DRByW//JZjKId4vNoxT2HLE/Wlkry03Nm98IHyU+R8J10JlYlD8Ajmfg
         OKchqlPmDD9YbjUEeAW5lei52B1PkIgzCgFPbcYhz3bc9gbDpIlSa+MxR+rQc7X8BQHf
         P8eH8QtHQmgsZ6544+O04wx2EtNtrnXlcgL6wwO1H8QCszTRRxZ5Gve5IXvlWLqkfj+H
         YCWw==
X-Gm-Message-State: AOPr4FVfmMVg7G/3xcxX+ce80tH3vEf5L2mx9sFOfyPE+j79C3ie/3GvZytXU3mhox7GMqRlxcd5st+WzUTMSQ==
X-Received: by 10.182.157.37 with SMTP id wj5mr5549884obb.71.1461224089667;
 Thu, 21 Apr 2016 00:34:49 -0700 (PDT)
Received: by 10.202.75.210 with HTTP; Thu, 21 Apr 2016 00:34:49 -0700 (PDT)
In-Reply-To: <xmqqtwiwwa5x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292099>

On 20 April 2016 at 16:51, Junio C Hamano <gitster@pobox.com> wrote:
> Luke Diamand <luke@diamand.org> writes:
>
>> One thing I wondered about is whether this should be enabled by
>> default or not. Long-time users of git-p4 might be a bit surprised to
>> find their git commits suddenly gaining an extra Job: field.
>
> Ahh, I didn't even wonder about but that is not because I didn't
> think it matters.
>
> Does this change affect reproducibility of importing the history
> from P4, doesn't it?  Would that be a problem?

It would change the history created, but I don't see why that would be
a problem.

>
> How common is it to have the "extra" Job: thing in the history on P4
> side?

Where I work currently we don't use jobs (at present). Where I worked
before, jobs were created automatically to track issues in JIRA, and
were (supposed to be) entered into commits. It's potentially quite
useful so I guess might be quite widespread.

> If the answer to this question is "on rare occasions and only
> when there is a very good reason to have 'jobs' associated with the
> changelist", then the 'might be a bit surprised' brought by this
> change can probably be explained away as "a fix to a (design) bug
> that used to discard crucial information" that (unfortunately) have
> to change the resulting Git object names.
>

Luke

From: ryenus <ryenus@gmail.com>
Subject: Re: [feature request] find git commit log before rebase
Date: Fri, 27 May 2016 10:57:37 +0800
Message-ID: <CAKkAvaxT16Xx9gKoyMx_a=QBGAfMgYYwMvdGmDXA-0_qGO17gA@mail.gmail.com>
References: <CAKkAvax5Yf2=qLhVkn8EgkNEgHL97Doxr3JWR10aqxksYVsYXA@mail.gmail.com>
 <CA+xP2SYXUCfLHcyfQu6SLhZ6jRptp3gK0myatKVUxyP-2B=dPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Sebastian Staudt <koraktor@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 27 04:58:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b67yM-0005aB-7d
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 04:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbcE0C56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 22:57:58 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37359 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932168AbcE0C55 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 22:57:57 -0400
Received: by mail-ig0-f177.google.com with SMTP id l10so58327377igk.0
        for <git@vger.kernel.org>; Thu, 26 May 2016 19:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v90VIEYwtTRggnYaj5dM0H4kWd7Z4ooBSCoeLsaGTv4=;
        b=PnndYgwygFOygyXihBpt0CjMWoJ/wyKw7Y4fSvywCqYgknxZLNqLK2wVzMXAB0Wz0i
         lPz60djJgpXEBLKQ60B0W+EkaKLz4+DnFdXDbb2GYlVG90ygDoVe/K8SxOb79uazrsxI
         trkUI/9LMorMlG3ySQD1BAtkQL1fSQ+tlCg0juddaY7WgdkZ4fg1DQdPHrBUDTBXkAHm
         PRQyjjF0Eut5MOilx2fix7Uyb/nBZmC0JNclRybOQ6tCZTxrF2HPVArbhw0eJRSuG6kg
         MO/zba2jgN05Z9SMdIkQK6gMsh5FBm0Dz9M5vpIa/+leGAKfGNYR2ABCQxn25WwWyrzq
         USWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v90VIEYwtTRggnYaj5dM0H4kWd7Z4ooBSCoeLsaGTv4=;
        b=bbxFKXxeSrwogf4g13BOrnWkOBJDk7hdS7KsP9hRKKARhzPd6jlbmRRjLqssCiVHoM
         1xVNuzaAVrwyg6r6g75+gUyBDsWKC0uSyV/KRMtgshID+ozv1m0/qRCvEGqEDpwhRqJF
         avDL0eRT94eVf/TYYHtVX70WLfadmPMUCzvHXM5Wz93NQeRyzxfKZ1OVfq+3STmgsblh
         N2GujcXtsP1WKmBvaF0lh0yYFr8+S1hszPzdRJGLUFsnR5uDBcva3xmMMSBpU62vNAF5
         4YhPzL6c5vgB6JujvwO7hOm1wEF/qFahK/P7LtJhOghzXon57BLxlfI26Zvfc20C8k3C
         ttzQ==
X-Gm-Message-State: ALyK8tKdRLtAcBBTqulfm5X360mkQ5UBhc7XzEco05kZCVNNgYLYnAEqqi6doz8kBG2clbvaXXHUTR45Kg6OYA==
X-Received: by 10.50.112.42 with SMTP id in10mr5812413igb.67.1464317876711;
 Thu, 26 May 2016 19:57:56 -0700 (PDT)
Received: by 10.64.28.47 with HTTP; Thu, 26 May 2016 19:57:37 -0700 (PDT)
In-Reply-To: <CA+xP2SYXUCfLHcyfQu6SLhZ6jRptp3gK0myatKVUxyP-2B=dPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295720>

Indeed, specifying the branch name does the trick
and this works with `git reflog` and/or `git log --walk-reflogs`

Thank you very much!

On 27 May 2016 at 01:58, Sebastian Staudt <koraktor@gmail.com> wrote:
> Hi.
>
> I think what you want is `git reflog` (http://git-scm.com/man/reflog).
>
> git reflog b
>
> Will tell you the commits b pointed to in the past.
>
> Best regards,
> Sebastian
> ryenus <ryenus@gmail.com> schrieb am Do., 26. Mai 2016 um 19:03:
>>
>> Assuming I have branches master (m), and a side branch (b), with a
>> history tree like below:
>>
>> m0 --- m1 -- m2 -- m3 -- m4 --- master (m)
>>         \          /      \
>>         b1 ------ b2       b3 -- b4 -- branch (b) (HEAD)
>>                   |
>>       (tag:POINT_BEFORE_REBASE)
>>
>> The history of branch b is can be described as:
>>
>> 1. branch b is forked at point of m1
>> 2. branch b is merged to master into m3,
>> 3. branch b then is rebased (fast-forward) from b2 to m4
>> 4. then branch b started its new life as b3 b4 after rebase
>>
>> With the following command: I can find b3 and b4 since last fork-point
>>
>>     git log --oneline $(git merge-base --fork-point master)..b
>>
>> But how to find out commits b1 b2, given the fact that b2 is the point
>> before rebase?
>>
>> I understand it can be achieved via:
>>
>>     git log --oneline m2..b2
>>
>> That's because I know b2 is the point before rebase,
>> and m2 is another child of the subsequent merge commit m3
>>
>> I wonder how to do this with an simple (enough) command without me
>> looking through the history and find b2 and m2 manually?
>>
>> Thanks!
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

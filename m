From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v16 0/7] config commit verbose
Date: Fri, 6 May 2016 21:47:42 +0200
Message-ID: <CACBZZX6XThQ9Ns4YMd_jC2jmNHhWg7QgXsn9_Ejy_8itToJQug@mail.gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
 <1462441802-4768-1-git-send-email-pranit.bauva@gmail.com> <CACBZZX5ssO2EiuxR7wotGowMaPhtioaJVSDpQDUwUkv1rLJJWw@mail.gmail.com>
 <CAFZEwPPkBcdupLktJ=ystnx_1y7Mv+U436Jn9JBUCrvkt+t8tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 21:48:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayljN-0002Gs-Ks
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 21:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758589AbcEFTsF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2016 15:48:05 -0400
Received: from mail-qg0-f67.google.com ([209.85.192.67]:33465 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758275AbcEFTsE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 15:48:04 -0400
Received: by mail-qg0-f67.google.com with SMTP id 90so7484668qgz.0
        for <git@vger.kernel.org>; Fri, 06 May 2016 12:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ojzp9osrqddiz2iRa0ze5att2ghFrg3ThX8/FuL+fuc=;
        b=oHCL7e/rITQexspaASWWhv4O1e0Wfns0+C3jsNEggd7hx6SeU4oD5psCe1wrSgiLoX
         ObllmHwDo+se4xgJkFLwT5JiWLKs/8HKpKc8QH3eaW8o5mpSw3U5zTdXep7v4ef2+u5o
         C7QixV3iYyTQ6+kcKqNdQDSb8aJoNVsHRgp7ZGda7csdRVlcI8mk7B2ATM/0o9t+2a5d
         N6DWyiIeJ4nfw/2KxGwu0OGS2BoNhCRptqSQsZFnF0BWp2fX4JCshBY+ZtGsyckL3ekM
         5cw4DwiZUUqzkIzRYm6t8A7pB89GKmzwsMjAySfhnMdWHJ3sz2b2Wh0p/jORYXSHJTXp
         IxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ojzp9osrqddiz2iRa0ze5att2ghFrg3ThX8/FuL+fuc=;
        b=NUG9bbhRHy4qy0lFxGoIJJe9fpTLOkq2mjWArP2ts82TaxK6iGpF+vYJ1HneSngNMd
         N37M0OAj4feLPOTjoTOTFxQXid17EY0xoo4VfBP1wsP2mWkSnTZFA6QC3ZUuLp/hooYf
         gfVm0aeKM2W6GcFTe8psGwMams80WBhOPuzp8+OFzT0ECC962AVatUUJtJwedfv1OeBy
         NeLw70jxEU9MKEJ4QjG3CQZEyNt0+zqY97R/6myIKQ4SXhbwvvslQXdPLmhe0w47Sn5K
         9sb2yN9b35S+f5OCX1TeVBobfQphV/ZJUTYsKtdY0r9rxamkFjf+wYSd2GkO77UxgQGJ
         fYNw==
X-Gm-Message-State: AOPr4FUO3uaQftSUizoF0xX3uycMTP/B6cuHritiHQ7Rhd2rCvA6d+SqIUJjxJ4+Ajt51ilyNHcF6asdQVu4ew==
X-Received: by 10.140.218.82 with SMTP id o79mr23138537qhb.33.1462564082341;
 Fri, 06 May 2016 12:48:02 -0700 (PDT)
Received: by 10.55.77.133 with HTTP; Fri, 6 May 2016 12:47:42 -0700 (PDT)
In-Reply-To: <CAFZEwPPkBcdupLktJ=ystnx_1y7Mv+U436Jn9JBUCrvkt+t8tQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293852>

On Fri, May 6, 2016 at 6:16 PM, Pranit Bauva <pranit.bauva@gmail.com> w=
rote:
> [+cc:git@vger.kernel.org] Because its an interesting fact to be share=
d
> which isn't covered elsewhere.
>
> On Fri, May 6, 2016 at 2:53 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
> <avarab@gmail.com> wrote:
>> Sending this privately since it's probably covered elsewhere. With
>> this, if I set the option will "reword" in git rebase -i show me the
>> patch?
>>
>> If so: awesome.
>
> Yes, git rebase -i will show the diff in 'reword' if commit.verbose i=
s
> set to true or a value greater than 0.
>
> I dug further in git-rebase--interactive.sh
> I could find appearances of "git commit --amend" but I was unable to
> find appearances of "COMMIT_EDITMSG". If COMMIT_EDITMSG was coming
> into picture, the commit.verbose could not affect it. And that is not
> the case.
>
> I guess this would be a desirable trait for most of the consumers of
> commit.verbose (like =C3=86var) so there would not be a need to suppr=
ess.

Yeah it's great, it's something I've wanted from interactive rebase
for a while now.

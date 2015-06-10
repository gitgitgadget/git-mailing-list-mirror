From: Luke Diamand <luke@diamand.org>
Subject: Re: format-patch and submodules
Date: Wed, 10 Jun 2015 22:14:20 +0100
Message-ID: <5578A8AC.2090704@diamand.org>
References: <CAD2z=MAu1qrr9=wwBnOJZZ3JCJOsmFWi=gDgKMQKU3_P-01e3g@mail.gmail.com>	<557735E6.8040906@web.de> <CAD2z=MBSAzENvj1-WUMzrXznvudjCc3vyvYQQ+wMnPC3G3Go2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christopher Dunn <cdunn2001@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 10 23:15:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2nL8-0000KU-Fl
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 23:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851AbbFJVPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 17:15:08 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:32839 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbbFJVPG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 17:15:06 -0400
Received: by wgez8 with SMTP id z8so44074843wge.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 14:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=RCCO9CvFUUMIHZLeSL3wwaXZB6YvFYYg8e3pFmPC9SM=;
        b=EkdmjBgKMv+JY1KlcAqJsyXwMlm1jBxNe/W5bAsWq5j0EFk13tOS+e4Jjs79BG1Ovu
         y5rMFKamdTfGsQHHwFzebVV+GwgK2MLABFYXHhnrKrrrJHqUDbz1khQxngRnQJL32XWo
         hPmmKoKg5TrGo9rblb0FbXVha/dGlDCifPahI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=RCCO9CvFUUMIHZLeSL3wwaXZB6YvFYYg8e3pFmPC9SM=;
        b=O+1Tc9yO140szNuplRj6hM0ZlnTSP4fdSKaBnqWw3dKOCzSkrOD18twaX/gjQRHA4o
         NNvmRPnviDpwv0V4hYS7JxCwyfdTZbw34dTUEIwqSoyd1uLfnfFlnhE7zNU6xjTAB8+F
         U8p58qMRLmVQYZpGdbqcZRxaGRkRjxVNAIrARO+1y5Zc7yVhNbMky8whcRpoY97jBvyl
         UsbU2SD8g20tCAFzqn/1rM3LofzZX4Ll6QIeJX2ba7rJlBzQGi8LbPhEzhKcvEDEHSqs
         T0ZBxGDa+PyXEMm1Er+61G1eWpEJ9lvAd1l/rxSIREZcqtHfh908ma49HcyiRP9we0z3
         wFgA==
X-Gm-Message-State: ALoCoQlHONnx8hak6xnNpL0O7keE1lsC2LhjVIjypxcgHgH4EbC7CJ6MwtxViMsOQhQT0XmlCLu5
X-Received: by 10.180.74.144 with SMTP id t16mr12179576wiv.33.1433970904661;
        Wed, 10 Jun 2015 14:15:04 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id a19sm9731797wiv.2.2015.06.10.14.15.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2015 14:15:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <CAD2z=MBSAzENvj1-WUMzrXznvudjCc3vyvYQQ+wMnPC3G3Go2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271356>

On 10/06/15 18:04, Christopher Dunn wrote:
> Sorry. I thought empty patches were made to work in other cases.
>
> 'git-p4' needs to skip these. Wrong mailing list then.

Possibly the right mailing list - can you explain what you mean here 
w.r.t git-p4 please?

Thanks!
Luke




>
> On Tue, Jun 9, 2015 at 1:52 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 05.06.2015 um 01:20 schrieb Christopher Dunn:
>>>
>>> (Seen in git versions: 2.1.0 and 1.9.3 et al.)
>>>
>>> $ git format-patch --stdout X^..X | git apply check -
>>> fatal: unrecognized input
>>>
>>> This fails when the commit consists of nothing but a submodule change
>>> (as in 'git add submodule foo'), but it passes when a file change is
>>> added to the same commit.
>>>
>>> There used to be a similar problem for empty commits, but that was
>>> fixed around git-1.8:
>>>
>>>
>>> http://stackoverflow.com/questions/20775132/cannot-apply-git-patch-replacing-a-file-with-a-link
>>>
>>> Now, 'git format-patch' outputs nothing for an empty commit. I suppose
>>> that needs to be the behavior also when only submodules are changed,
>>> since in that case there is no 'diff' section from 'format-patch'.
>>>
>>> Use-case: git-p4
>>>
>>> Of course, we do not plan to add the submodule into Perforce, but we
>>> would like this particular command to behave the same whether there
>>> are other diffs or not.
>>
>>
>> Hmm, I'm not sure that this is a bug. It looks to me like doing a
>>
>> $ git format-patch --stdout X^..X | git apply check -
>>
>> when nothing is changed except submodules and expecting it to work
>> is the cause of the problem.
>>
>> I get the same error when I do:
>>
>> $git format-patch --stdout master..master | git apply --check -
>> fatal: unrecognized input
>>
>> No submodules involved, just an empty patch.
>>
>> I assume you want to ignore all submodule changes, so you should
>> check if e.g. "git diff --ignore-submodules X^..X" returns anything
>> before applying that? (From the command you ran I assume you might
>> be able to drop the --ignore-submodules because you already did set
>> "diff.ignoreSubmodules" to "all"?)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

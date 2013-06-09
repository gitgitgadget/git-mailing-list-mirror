From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 42/45] add tests for rebasing merged history
Date: Sun, 9 Jun 2013 12:46:07 -0500
Message-ID: <CAMP44s1DKUqXgZLfkHT45ST3WtqkrWZD0KEwQwriVoN5GMT=SQ@mail.gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-43-git-send-email-felipe.contreras@gmail.com>
	<87wqq3ci1n.fsf@hexa.v.cablecom.net>
	<CAMP44s30YkE5i7B==pyB8zkNxu=YoGvP1=V_2LqOe_frXV+cfQ@mail.gmail.com>
	<87obbfchqb.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:46:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uljh0-0007Y7-SV
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991Ab3FIRqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:46:10 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:50914 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab3FIRqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:46:09 -0400
Received: by mail-la0-f41.google.com with SMTP id fn20so5108503lab.28
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cMtHR+kOLNroD6LATJ0OR8t993XA6UpFhBfPEet5akg=;
        b=owI/cMgLt1LRap8s8KarUxhG4gUCo/wlOQ9fjPkZDtWlJ+M8VGPtgGdVSbh90JGyJy
         mPdf3PTlViLbnshtDVu18hkwWcXpbZER9TYsmHx+G+KbucAa2322bra4m2/VETL/kZxo
         E2HvBPN4O9TNR/59gCM5cD8Oz1IakaW9L3xjtJZJig2UDxS86I8JSW+joNnLE+x5x3rp
         xDr1izcj/xQFmXBeikuKOm9/TvMhpYZdAZm7ab7H46/cJt88JGudE4DQutO4FbzM3L72
         k00A9qkODAzWykow7xlNkhAyl29U67Gx7YV4SUjOQML9nKjuirvdjydUZ2wpwkUIm1Ug
         g7vg==
X-Received: by 10.152.22.73 with SMTP id b9mr3361690laf.36.1370799967857; Sun,
 09 Jun 2013 10:46:07 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 10:46:07 -0700 (PDT)
In-Reply-To: <87obbfchqb.fsf@hexa.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227051>

On Sun, Jun 9, 2013 at 12:32 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Sun, Jun 9, 2013 at 12:25 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> +#TODO: make order consistent across all flavors of rebase
>>>> +test_run_rebase success 'd e n o' ''
>>>> +test_run_rebase success 'd e n o' -m
>>>> +test_run_rebase success 'd n o e' -i
>>>
>>> [45/45] would seem to imply that these tests fail as of this patch.  Is
>>> that correct?
>>>
>>> If so, please either squash that change or move the test further up
>>> marked as 'failure'.
>>
>> I won't. The whole purpose of the last patch is to show these tests are fixed.
>>
>> Martin von Zweigbergk's patch series is independent of this one, I
>> merely added it to show the above.
>
> So you would deliberately break a bisection on this test file?

No, this patch series won't be applied.

-- 
Felipe Contreras

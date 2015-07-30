From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 10/11] branch.c: use 'ref-filter' APIs
Date: Thu, 30 Jul 2015 12:07:58 +0530
Message-ID: <CAOLa=ZTHRLTbmB7iadc3z7=-pshjR0QS8R_StZb7xOyu_gJ=Sw@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438067468-6835-1-git-send-email-Karthik.188@gmail.com> <vpqh9oov017.fsf@anie.imag.fr>
 <CAOLa=ZR6Cu_AgB4sOBX3Tf_M0w8XN57ej8d_fZo+h7pwFDZs+A@mail.gmail.com> <vpq3807gdp0.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 30 08:38:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKhU9-0002gW-99
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 08:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbbG3Gi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 02:38:29 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:35831 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701AbbG3Gi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 02:38:28 -0400
Received: by obbop1 with SMTP id op1so24299070obb.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 23:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=p5sSUGDp3S8fcOyhlh3Y2WWCPWIGwSwUmDMR5AXXW3o=;
        b=Ipvw1dt5YdKuH+Y+RSE5EoAF6FfGDd4sb+bkRFZrjV1qJe3i5vr6jS0KQ4+gfTTzsL
         XmSIOpJLOtUoNKsy5yfdV0Kzpb+KTE5ref0dXipAtmbPh5tmKZfRfq3R1OztTaTfNVZa
         kvYaLiHI4Z67KVJUGyHHkf4rxLvax0Bo1AAg6NMwn+NGn7qi2YRvzD0zwFCPJPcOSZ+X
         bdy77Kuc8ON/nMfFhJ+CYkMtZPjwHQQxiNY9xuAi8mQKFUfZVonnpYaA8ykH3AsMBJgu
         P1kesD8RvOuin6Wfh1XkL0h8Ow5JjJdxto0OnLqFFYb8UL0agK83o9+2BEDHfsd38gLm
         nS2Q==
X-Received: by 10.182.204.38 with SMTP id kv6mr44330441obc.70.1438238308259;
 Wed, 29 Jul 2015 23:38:28 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Wed, 29 Jul 2015 23:37:58 -0700 (PDT)
In-Reply-To: <vpq3807gdp0.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274972>

On Wed, Jul 29, 2015 at 9:26 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Tue, Jul 28, 2015 at 7:47 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>>
>>> I'm not sure what's the convention, but I think the test description
>>> should give the expected behavior even with test_expect_failure.
>>>
>>> And please help the reviewers by saying what's the status wrt this test
>>> (any plan on how to fix it?).
>>>
>>
>> On the other hand I wonder if the test is even needed as, we don't
>> really need it
>> Cause we remove that ability of branch.c by using filter_refs().
>
> Please read d0f810f (refs.c: allow listing and deleting badly named
> refs, 2014-09-03). I think the reasoning makes sense, and we should keep
> this ability.
>

This makes sense, I didn't have a thorough look at this but it breaks
a little in
ref-filter.c while getting object attributes. So is it okay to mark
this as TODO?

-- 
Regards,
Karthik Nayak

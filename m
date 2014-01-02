From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: What's cooking in git.git (Dec 2013, #05; Thu, 26)
Date: Thu, 2 Jan 2014 16:37:15 -0500
Message-ID: <CAPig+cSdaD5krMDPGOWXJVoGFQZKY1Oee232mAj7PHTyoy=HRw@mail.gmail.com>
References: <xmqq1u0zcoci.fsf@gitster.dls.corp.google.com>
	<CAPig+cQXsdFocFeSR8YKh8crOwBFP0ZK0td2UbP-yypRYJhREQ@mail.gmail.com>
	<7vmwjmj628.fsf@alter.siamese.dyndns.org>
	<CAPig+cQ79qbEDai69T7pwvdTRk9rHBE5aSAKMZuOtwCw5qKPzQ@mail.gmail.com>
	<xmqqd2kaozqz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 22:37:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VypxN-0002Bs-DH
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 22:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbaABVhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 16:37:19 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:40797 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbaABVhR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 16:37:17 -0500
Received: by mail-lb0-f182.google.com with SMTP id l4so7756148lbv.13
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 13:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=kjAwPn3OVXeDBU5HYyLvMDgZlltFbUen2eWT8EF5Tis=;
        b=gCxL5+3yifIPzKJtbhAYDYo3QpaR5fmxsY5OtMLbK5toLZOBySdhj3hg4kXYERbibn
         NepZoZc18X80NkdNnmrm59AYXXhu0IaAu9Ib72elBnBMeBBty9v+/7znrGXBZXy9lpd3
         Z3IoytM82LXmmy4kEbBJUo54rBptFnFzuUlIFxBb1KDjy5iSL0QJi8hR19Ff7hxF0ZVo
         G6xwbjzaPHkYUAEYYX+L598KDLDNhDTxZVLuBj5UM3pmB+mJY4tgaSLfOLByfXJ/601d
         pSH48ZrlQ3xku1txAj88r0Pu66PDza+BEY1i5qWhMj+XS5Eau/7vn1hXljEkrVhaLjv4
         59GA==
X-Received: by 10.152.1.100 with SMTP id 4mr19838lal.90.1388698636032; Thu, 02
 Jan 2014 13:37:16 -0800 (PST)
Received: by 10.114.175.130 with HTTP; Thu, 2 Jan 2014 13:37:15 -0800 (PST)
In-Reply-To: <xmqqd2kaozqz.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: QsZVWZKJM8YO343IH7ER7b0H0Kc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239887>

On Thu, Jan 2, 2014 at 4:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Fri, Dec 27, 2013 at 5:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>>
>>>> On Thu, Dec 26, 2013 at 4:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>> [New Topics]
>>>>
>>>> Would $gmane/239575 [1] be of interest for "New Topics"?
>>>>
>>>> [1]: http://article.gmane.org/gmane.comp.version-control.git/239575/
>>>
>>> Actually I was planning to scoop it up directly to master but forgot
>>> to do so.
>>
>> Make sense.
>>
>>> Running "git diff maint pu -- name-hash.c" shows that we have added
>>> a comment that mentions index_name_exists---that needs to be
>>> adjusted, too, by the way.
>>
>> Oops, yes, I had noticed that too when testing atop 'pu' but then
>> forgot about it when preparing the patch for submission on 'master'.
>>
>> I'm not sure how to move forward with this now that kb/fast-hashmap,
>> with which it has a textual conflict, has graduated to 'next'. Should
>> this become a two-patch series with one for scooping directly to
>> 'master' and one for 'next' to sit atop kb/fast-hashmap? (But how will
>> the textual conflict be handled?)
>
> I have a feeling that a small unused helper function is not a huge
> breakage that needs to be immediately fixed, so a single patch as a
> clean-up on top of whatever is cooking on 'next' should be the best
> approach, I would think.

Sounds good. Thanks.

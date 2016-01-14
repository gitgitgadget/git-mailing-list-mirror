From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] Malicously tampering git metadata?
Date: Thu, 14 Jan 2016 09:21:28 -0800
Message-ID: <CAGZ79ka51e+-24RyMgUGAOUkBYXxnWZb8Pg7vrgjGHvvWU770Q@mail.gmail.com>
References: <20151216032639.GA1901@LykOS>
	<20151218231032.GA16904@thunk.org>
	<20151219173018.GA1178@LykOS>
	<20151220012835.GA3013@thunk.org>
	<20160112182137.GE27334@LykOS>
	<CAGZ79kadpy9N0qEpxK-USVxCmNfYJm1g5xr8ZiFxf7sOVKZnEw@mail.gmail.com>
	<20160114171639.GB25541@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Thu Jan 14 18:21:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJlaY-0002sv-5w
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 18:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469AbcANRVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 12:21:30 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34141 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641AbcANRV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 12:21:29 -0500
Received: by mail-ig0-f175.google.com with SMTP id ik10so201369714igb.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 09:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vU9G7YJfKnaHuE8i+T9kA8QsGQeLD3CLXkUeGhmbpqw=;
        b=LpuDzWprBUpIu1PDyjfUgWhIhLFt/9MBTIQXlFdN8Imng18Y0XNzxTQM8ztPgOJ4bh
         /bIJRHNBz5jvtZLgdzAY5eONENwmYdKYcAT0M8M3yFMUEm53sMS8UdvY9S1BVvM513bi
         7j3w1MRq1OcGxy/PjVcr0ydK1X50/kPLloHID0sQA3OUKMlbhs7HanQpiAVrcqh+jpfW
         OW6wtO/gClsFuWduszuYi45AwkfKel1ojUBFWgBuD2rwEryUP5jj+WDtdxhwsACk4OpL
         7Uy3GgbCn4oSDN6ASefCCqmCOH1b8lTe8yJqVNGUSHQ3+nijM1M7oN31gnEQH9HwImCD
         eX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vU9G7YJfKnaHuE8i+T9kA8QsGQeLD3CLXkUeGhmbpqw=;
        b=Ng9FqC8+mCDtatN/iTIL8mFq+TWGHJNxwC4eINb3g025dkbzPIc0yk+0VAouNsL6Jy
         UQfxuw6i16ne6iJnRrgtT4ox9COUPukOuRZeMqU9ib4FtKZPmMMKJqwrt4SsR4niOyEm
         X3BskGa9+yc4byhluhckLjc+Zxj8Z2SdiY8ICeb6fV5Jk3NkwowNE5ZQlQe6cB0gKQgK
         REW/EtwroO0VuRL9+pyby7unqR+UtZl3vsFdIvtbUelUmQswg20DhVdiBPkE0OzYK68P
         4u3oKm7q+aPvZmrG7v22DO9+3S29ZDEYjBrZgR4McnQdhLLM7Uea+vzs3cplpXa2Rrsj
         Z2EQ==
X-Gm-Message-State: ALoCoQnLW7sbyxx6CntWywyl8PGq10DwWUn60jRM0V1Ky1jAHOmOEUryKRD3nhHgjdzGTcEvBH/QumAiNfkQ0W24lvH0mP630RisPEoNOmeM36neczdzUb0=
X-Received: by 10.50.66.179 with SMTP id g19mr6358349igt.94.1452792089024;
 Thu, 14 Jan 2016 09:21:29 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Thu, 14 Jan 2016 09:21:28 -0800 (PST)
In-Reply-To: <20160114171639.GB25541@LykOS>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284070>

On Thu, Jan 14, 2016 at 9:16 AM, Santiago Torres <santiago@nyu.edu> wrote:
> Hello Stefan, thanks for your feedback again.
>
>> This is what push certs ought to solve already?
>
> Yes, they aim to solve the same issue. Unfortunately, push certificates
> don't solve all posible scenarios of metadata manipulation (e.g., a
> malicious server changing branch pointers to trick a user into merging
> unwanted changes).
>
>> AFAIU the main issue with untrustworthy servers is holding back the latest push.
>> As Ted said, usually there is problem in the code and then the fix is pushed,
>> but the malicious server would not advertise the update, but deliver the old
>> unfixed version.
>>
>> This attack cannot be mitigated by having either a side channel (email
>> announcements)
>> or time outs (state is only good if push cert is newer than <amount of
>> time>, but this may
>> require empty pushes)
>>
>
> I'm sorry, did you mean to say "can"?

Yes, formulating that sentence took a while and I did not proofread it.

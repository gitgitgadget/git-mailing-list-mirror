From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v17 00/14] port tag.c to use ref-filter APIs
Date: Sun, 13 Sep 2015 10:24:24 +0530
Message-ID: <CAOLa=ZRKuuBo9v7qB3i4Y5dV18mg9OUJtTLXTMiBHEtk-vdTmg@mail.gmail.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
 <vpqr3m6nrf9.fsf@scolette.imag.fr> <CAOLa=ZQppSg0-kc5nCfRYfHMoD5ehTTOigKz48G01vn1Mn=FTw@mail.gmail.com>
 <vpq7fnwvw2c.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Sep 13 06:55:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZazK9-0000n5-LI
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 06:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbbIMEyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 00:54:55 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36792 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbbIMEyy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 00:54:54 -0400
Received: by vkfp126 with SMTP id p126so43331522vkf.3
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 21:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Rj7L1mKudzk/JTYzYpO4grvKB390QPXp15Eq2gnLso0=;
        b=I44PCQOXITmxu5VY+m2C4cIm8KU1W40g1MiYmwUzoLy6EFhsNuoWV44kl1YcNOuCbO
         4lvOyhXuyY6SA6yCCEszPaJhIYk5ZTKAuCRXl6VLFM1c/LoJxAzOjTLvUqQDa1RWxb5n
         sLCIyW0+rFcS0SECwC3g3wjmZNsBhtQQY1KurV7IpvmAPkOZ7OvKD6XaGdW/eR+61UZ/
         D86IgCZo44TlJt22i359rPp/9z+n1Jz24W9YyFzUP3farOxyGoozxbdU+OAZ/xRjq1jJ
         yI+jJ5dHJ7HAJfm98VorZONYHLTGAyI/QAT7E6mEGV91LxLi4DD3+wqDltP7O8cEbkkR
         CK7g==
X-Received: by 10.31.194.73 with SMTP id s70mr6902015vkf.77.1442120093865;
 Sat, 12 Sep 2015 21:54:53 -0700 (PDT)
Received: by 10.103.23.66 with HTTP; Sat, 12 Sep 2015 21:54:24 -0700 (PDT)
In-Reply-To: <vpq7fnwvw2c.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277758>

On Sat, Sep 12, 2015 at 2:44 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Thu, Sep 10, 2015 at 10:27 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> This is part of the series of unifying the code used by
>>>> "git tag -l, git branch -l, git for-each-ref".
>>>>
>>>> The previous version can be found here (version 16):
>>>> article.gmane.org/gmane.comp.version-control.git/277394
>>>>
>>>> Changes in this version:
>>>> * The arguments of the %(align) atom are interchangeable.
>>>> * Small grammatical changes.
>>>> * Small changes in the tests to reflect changes in the align
>>>> atom code.
>>>
>>> Clearly, we're almost there. I did a few minor remarks. I suggest
>>> (admitedly, Eric suggested of-list to suggest ;-) ) that you reply to
>>> them by re-sending only individual patches that changed (replying to the
>>> original patch) so that we can check the new patches individually. I
>>> think we can do the finishing touches for each patch in a subthread of
>>> this patch.
>>>
>>
>> I replied with suggested changes by you and Junio.
>> Let me know if any other changes to be made :)
>
> I went through the patches you resent, it all looks good to me.
>
> If I read correctly, Junio already applied it to pu.

I'll push the next set of patches then.

-- 
Regards,
Karthik Nayak

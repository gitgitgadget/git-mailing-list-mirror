From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/7] test-bzr.sh, test-hg.sh: prepare for change to push.default=simple
Date: Mon, 11 Nov 2013 15:19:59 -0600
Message-ID: <CAMP44s1fc2UMZE4Y5sdTuKuU_p1sLo02jiBppabywSjxFfR6Eg@mail.gmail.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
	<1384142712-2936-4-git-send-email-rhansen@bbn.com>
	<CAMP44s1phHVjiETB3fK3FwjOcJ4+6YYCYt5pvOWJL+RM37QLfw@mail.gmail.com>
	<5281491A.4050806@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 22:20:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfyty-0004eb-KU
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 22:20:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591Ab3KKVUC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 16:20:02 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33728 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab3KKVUA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 16:20:00 -0500
Received: by mail-lb0-f180.google.com with SMTP id y6so3905031lbh.11
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 13:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qQGRY4MDduza9tcD3e6GPA4CzMkik5h5UYB+kefdKOc=;
        b=XnkZLa3E4faMIkke69nyuxKzuVrZZY7xGyfel/L7q7vUAo4+JEp4LoCGH8H7JrSaIL
         vY66fZwcq282PsZV0IwijW21KWxMjfgO6Khr7ePyR8GunhM1G+yZeS62FoftOqtvFCz7
         x0kqH99cbTkiygrzzvzTwhu50BPccOj31uGe/lXsHExzatLD3VWtPepu44tEa4CwO8h7
         sv3/TGzTaOKcwSye1AtNSu/3Jr1f0f7pevCXyg66oXDtFxMR+c1Mx+Ni8n9raJPL20EL
         R+xbv5hCx3aHqb/KtvLBt7n+05mBgZ8JBYcZxTGzFv4JR4J6+7Vl6f7+jAdxmzlgETqg
         CbOQ==
X-Received: by 10.152.5.228 with SMTP id v4mr23785693lav.7.1384204799420; Mon,
 11 Nov 2013 13:19:59 -0800 (PST)
Received: by 10.114.201.69 with HTTP; Mon, 11 Nov 2013 13:19:59 -0800 (PST)
In-Reply-To: <5281491A.4050806@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237656>

On Mon, Nov 11, 2013 at 3:16 PM, Richard Hansen <rhansen@bbn.com> wrote:
> On 2013-11-11 14:31, Felipe Contreras wrote:
>> On Sun, Nov 10, 2013 at 10:05 PM, Richard Hansen <rhansen@bbn.com> wrote:
>>
>>> @@ -379,7 +382,7 @@ test_expect_success 'export utf-8 authors' '
>>>         git add content &&
>>>         git commit -m one &&
>>>         git remote add bzr "bzr::../bzrrepo" &&
>>> -       git push bzr
>>> +       git push -u bzr master
>>>         ) &&
>>
>> Actually, why -u? Isn't 'git push bzr master' enough?
>
> It's defensive in case that test is ever updated to do more pushing.  I
> can leave it out in the reroll.

Please do. If there's any need for that we can add it later, but even
then I would prefer that the push explicit again, like this one. And
suspect we will not need to update this in that direction.

-- 
Felipe Contreras

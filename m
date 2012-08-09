From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Add Code Compare v2.80.4 as a merge / diff tool for Windows
Date: Thu, 9 Aug 2012 18:22:17 +0200
Message-ID: <CAHGBnuPT+ULpPtO_QxqUY8qxfbRT==fACQdM+TG2CyhbcKM-_w@mail.gmail.com>
References: <5022CC90.3060108@gmail.com>
	<7v1ujhrs7e.fsf@alter.siamese.dyndns.org>
	<CAHGBnuOaze=opbK+hH2s92enHuN2NUuKOVsTY4ZKgc3aWsX2-g@mail.gmail.com>
	<7vipcsoxwa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 18:22:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzVV9-0001HY-WA
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 18:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757477Ab2HIQWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 12:22:19 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:38195 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757391Ab2HIQWS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 12:22:18 -0400
Received: by vbbff1 with SMTP id ff1so124626vbb.19
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 09:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nretBlOK/me7wy8/1YfIWojMHqg/NldG5qyajn+rIao=;
        b=yYEw0J6rtsma9qx1m3QlkA3ft40f8PcL6GmBjrlxVhW95VxwFyWQ4KRVhyuLVzaMMZ
         udob4wKaScYUuHftCT4/5KYfRsjAwQIg9c3FboD1a+Tdw89krz7ZhoI8i7CNxq2O0hED
         XxGPEZN12Uh7nRucQhd5JMtt4mkU254jYtHRpfLSkgo+7FurGelula+FrP0zZZ6GP38U
         jjHV6ee67W49TFM4ju2QaYIb2njmFJ29N9H8LfZEkMRtryPKa++pWm5yohI6n8L64vxY
         oDJOjxJ/e6lThEZVR5Meu5t+fcKtaMSG77uSSPl6VmJ8cVfcgIc3sG/uMB0x/sX+KLe9
         T2Yg==
Received: by 10.52.16.239 with SMTP id j15mr9794444vdd.7.1344529337311; Thu,
 09 Aug 2012 09:22:17 -0700 (PDT)
Received: by 10.58.68.167 with HTTP; Thu, 9 Aug 2012 09:22:17 -0700 (PDT)
In-Reply-To: <7vipcsoxwa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203164>

On Thu, Aug 9, 2012 at 6:03 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> I still agree that not listing all mergetools in multiple places is a
>> good thing. But doing the whole stuff of extending --tool-help for
>> git-mergetool and git-difftool to return a simple list that can be
>> used in git-completion.bash etc. IMHO is a separate topic and out of
>> scope of this patch.
>
> Exactly.  If you know that is the long term direction, I would have
> preferred you _not_ to touch any existing descriptions of the tools
> (not even changing them to refer to "--tool-help") in this patch, in
> order to avoid unnecessary conflicts with the topic of unifying the
> list of tool backends, which can be written and cooked separately.

To the the best of my knowledge there currently no such topic
underway, and even if it was, it would be unclear how long it would
take for integration. If I was not touching the existing descriptions
of the tools, and a Git version was to be released after accepting my
patch but before the --tool-help topic is merged, that would leave the
documentation in a wrong state. I was just trying to be consistent by
also touching the descriptions, which IMHO is the correct thing to do
in the short term, as you yourself say the topic to make use of
--tool-help is a long term goal.

-- 
Sebastian Schuberth

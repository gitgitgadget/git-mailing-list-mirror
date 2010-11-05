From: Christian Couder <christian.couder@gmail.com>
Subject: Re: cherry-pick fail when a symbolic link has been changed into a
 file or directory
Date: Fri, 5 Nov 2010 09:33:28 +0100
Message-ID: <AANLkTi=b4tV-PGwW9D+zBLpRtnJY6FZTH6S-Ee1J4gYq@mail.gmail.com>
References: <20101104125641.2ef90853@cortex>
	<AANLkTimq8SP-gxZQiXW3Pxg3-1Z98zyPAoNA8JDn0=6A@mail.gmail.com>
	<20101104151637.076ac021@cortex>
	<AANLkTi=cydcB2yRpWbSH7qZGHdjXEPjNvfBCJny7JcwJ@mail.gmail.com>
	<20101104181537.5f866d42@cortex>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Elijah Newren <newren@gmail.com>,
	Nick <oinksocket@letterboxes.org>, git <git@vger.kernel.org>
To: Camille Moncelier <moncelier@devlife.org>
X-From: git-owner@vger.kernel.org Fri Nov 05 09:33:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEHjt-00027R-1L
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 09:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278Ab0KEIdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 04:33:32 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39280 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab0KEIdb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 04:33:31 -0400
Received: by wyb36 with SMTP id 36so826693wyb.19
        for <git@vger.kernel.org>; Fri, 05 Nov 2010 01:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=1R/VFlyPYfu8tlxVTCA+M7pSA1VlKOopDPZsAs+j8h8=;
        b=Lg+xMJE1Ptftna62dbZo/FXKspohqidD6AxcpV2nAZfpFpOSy039WrpCfmUULypVJo
         R6BnDn4upSHZpjBP1SGAjHs40CzY3AmoM/CSuDkdmcPhNN8uxZhrfHkUf5AW0knjWEZw
         aE98lfXc2L6s0l1Xp3IjDsbJyAY8ffdam4DL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fm8JV/5tkHkCU506IAaDQHyYujjXARNEadNmwlEJl1QRbKOkh2UOuOk/gMEjN4sAAG
         w7HtLFVUo3CRKAWT5lR8d+kS7N+0s3DukcFvq9Pi3Rh2Yrab4EhI+Npu+OFd2AiPvTnJ
         7ahCrbsIoRyPZhJrHfDXjH0p+gIg/dQ4LZGK4=
Received: by 10.216.184.11 with SMTP id r11mr1812272wem.8.1288946008500; Fri,
 05 Nov 2010 01:33:28 -0700 (PDT)
Received: by 10.216.26.208 with HTTP; Fri, 5 Nov 2010 01:33:28 -0700 (PDT)
In-Reply-To: <20101104181537.5f866d42@cortex>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160803>

On Thu, Nov 4, 2010 at 6:15 PM, Camille Moncelier <moncelier@devlife.org> wrote:
> On Thu, 4 Nov 2010 18:03:39 +0100
> Christian Couder <christian.couder@gmail.com> wrote:
>
>> Please reply not only to me but also to the list and add relevant
>> people in Cc: like I did.
> It replied to the list[1] and CC'ed you. I use claws mail + gmane NNTP
> gateway. Maybe I did something wrong but it seems that the message has
> been successfully delivered to the list.
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/160722

Yeah, sorry, I use gmail and I don't know why but it doesn't show the
list in "To:" or "Cc:".

Regards,
Christian.

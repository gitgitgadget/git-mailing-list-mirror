From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/2] Convert the users for of for_each_string_list to 
	string_list_for_each
Date: Sat, 3 Jul 2010 08:49:15 +0200
Message-ID: <AANLkTin_a1FUIeFUIs5hR8XRsMYvNtd6xPQi7Zt85sqB@mail.gmail.com>
References: <AANLkTimYyHtjCfRtrTgVh3LJeJQeBpdXMRsf3khKatFx@mail.gmail.com>
	<AANLkTin6vHhkT7Q4h5A1g3OOQYzEPdVIOCWVyzxPacnS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jrnieder@gmail.com, srabbelier@gmail.com
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 03 08:55:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUwdm-0001vo-Uy
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 08:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539Ab0GCGzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jul 2010 02:55:48 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44711 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326Ab0GCGzs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 02:55:48 -0400
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Jul 2010 02:55:47 EDT
Received: by eya25 with SMTP id 25so27125eya.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 23:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=4kdoK/tAMzhkL3HVzkAPAIgSmQgZ/+TZHTKQDIuTWfI=;
        b=dUXP/Tnjd3CzN4ijBsFNNc4NAyVPC/ndKPAMCNxIbBy04N0RlOMw7Q+/8DyvoLsx3r
         AtaQqZ/1CWI4ZJsYM10WO7TzKRjP81RTq4baYY4RfMHJ4hrAl/ShPdAl9jI+cOjB3TeH
         mohEHsQkihtR/wfBuCExPXeb+mq3+lHiVhnao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=FqI1+EgqKcm5L4zX968flaAMn9bMLlKWg/61TuE1xOPXQbJQ7+gDP7pXvT9n6fHCDL
         UixqgGT49D6pcSAi8vsToomE9QvjFAe+QewyZu3pTZ8C2LmGjZ0BzNs8E+k4YJ4UAdGn
         PSrwW6lw37ecBG2VTBckofLPqBAJ7RsrmtfnA=
Received: by 10.213.29.65 with SMTP id p1mr116037ebc.76.1278139755412; Fri, 02 
	Jul 2010 23:49:15 -0700 (PDT)
Received: by 10.213.112.208 with HTTP; Fri, 2 Jul 2010 23:49:15 -0700 (PDT)
In-Reply-To: <AANLkTin6vHhkT7Q4h5A1g3OOQYzEPdVIOCWVyzxPacnS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150177>

On Fri, Jul 2, 2010 at 23:08, Thiago Farina <tfransosi@gmail.com> wrote:
> On Tue, Jun 29, 2010 at 5:37 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
>> The macro is suitable for all these cases
>
> "all these cases" is too vague. Which cases?
>

All the cases of call to for_each_string_list I found and converted.
But you're right, I'll improve.

> Also, you didn't convert all the cases. There are usages of
> for_each_string_list under builtin/ directory too (I assume it was
> intentional).

Er, no. I just failed to use git grep (used the Vim's builtin).
I'll check them out, too.

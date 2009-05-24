From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-ls-files --added?
Date: Sun, 24 May 2009 19:12:00 +1000
Message-ID: <2cfc40320905240212jc111b1xfeb39b1851c606d3@mail.gmail.com>
References: <2cfc40320905240054j2c08da8bt4df95c6f1bc9e254@mail.gmail.com>
	 <m3fxeudhho.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 11:22:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M89uj-0003Hy-Vk
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 11:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbZEXJMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 05:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbZEXJL7
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 05:11:59 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:2693 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbZEXJL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 05:11:59 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1528955ywb.1
        for <git@vger.kernel.org>; Sun, 24 May 2009 02:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KSXSCLJ/QzFrnrcvXvv4SFE+s/MKmI7rreuJDVV3fbM=;
        b=lqixmGDpbHB7S5CpPGU4qEkvNJq5qy+RM2IDGJcxjArSqtAv+LUYwhhSZuGoy81tMz
         DqOpX2QH9nNtDXCEwn5EAYlWq8GOBae1BexNN39UOtBgpeO3WDQELYu56Kbx2gNlFL6z
         eAd8645H8lL+UFEAOuCKuszkbxRS9L0y81J3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KZeJPZcI3qmkrqMGYcZNQCLd7Om6ebthc3xBYTBhx0FokS+DA5iw35sJSFYrZeWaHf
         uV9OrUmq13/lw5u1+dV3zOxcX5XbVoqkvLR0FRt5t7/93vXMsga2ty+tQ9K911Rcd0vr
         DSHaFdYWU8lTlurdd0TeHAW2rP2y7hqMIuvp0=
Received: by 10.150.151.20 with SMTP id y20mr11554901ybd.17.1243156320079; 
	Sun, 24 May 2009 02:12:00 -0700 (PDT)
In-Reply-To: <m3fxeudhho.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119816>

Jakub,

Thanks - yes, I wasn't happy about parsing git status.

I am still interested in the rationale for git-ls-files not supporting
such an option directly, since git-diff still seems a little indirect.

Regards,

jon.

On Sun, May 24, 2009 at 6:37 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> Is there a reason why git-ls-files does not have an --added option?
>>
>> I'd like to get a list of new files, due to be committed. Currently, I
>> have to parse the output of git status to get that, but it seems like
>> a reasonable function for git-ls-files.
>
> You can use git-diff-* with --name-only and --diff-filter=A for
> that; you shouldn't parse result of porcelain git-status.
>
> And there is also contrib/examples/git-commit.sh as a guideline...
>
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>

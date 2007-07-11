From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: --ignore-invalid flag to git log et al.?
Date: Wed, 11 Jul 2007 09:46:59 +0200
Message-ID: <81b0412b0707110046n5ec27328pab0ff33c183f79e@mail.gmail.com>
References: <18068.34542.502048.222112@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jul 11 09:47:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8Wui-0003ql-BI
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 09:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758842AbXGKHrE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 03:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758498AbXGKHrE
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 03:47:04 -0400
Received: from ik-out-1112.google.com ([66.249.90.177]:39652 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757947AbXGKHrC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 03:47:02 -0400
Received: by ik-out-1112.google.com with SMTP id b32so1100449ika
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 00:47:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kksB+DT3Z65tLiIHmO0iGe1eup2Hfpzpfns5ptXuANj5fJ8Gc2EVLQCuN1ciFVXG6VOjMe5ZafHxHj24W8bVfL8RQ2c+igtTXqni4lVb+VFWRVhhJ9uwSRrqHaaKzXb69yCG/aDz2Lc75X7N/umm9eH/ZmLX7ffOQL2vzUf4f9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O3bpFKVc/OlS8PcrVahGxTmNcfPdup2GU0u13lNjh83MFsbbEktf3mwkwaI/f8z0CbE9kN0z6QoB0hapy+DyReY5yR2K1QqZZqVJJT+WNikNjH37B06dVGZlkoAUtAVXdmlfYpNRa05lKzDb/Zm8Q+npj0zaLNU9OfghjdIbpHI=
Received: by 10.78.156.6 with SMTP id d6mr2333463hue.1184140020587;
        Wed, 11 Jul 2007 00:47:00 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Wed, 11 Jul 2007 00:46:59 -0700 (PDT)
In-Reply-To: <18068.34542.502048.222112@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52137>

On 7/11/07, Paul Mackerras <paulus@samba.org> wrote:
> An alternative would be to have some way to validate refs.  I don't
> know how to do that efficiently.  I think I would not want to have to
> do a fork/exec for every ref that I wanted to check.

git rev-parse --revs-only ref1 ref2 ref3 ...?

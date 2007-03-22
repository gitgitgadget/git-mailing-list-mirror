From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: git-check-ref-format returns 1 for valid branch names
Date: Thu, 22 Mar 2007 21:42:59 +0100
Message-ID: <dbfc82860703221342h4e1ade1am2961a0a996d7d20c@mail.gmail.com>
References: <dbfc82860703221324k48690833g6731ef75562839d6@mail.gmail.com>
	 <7vejnht3x2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 21:43:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUU7q-00005x-H0
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 21:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934233AbXCVUnE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 16:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934235AbXCVUnE
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 16:43:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:19084 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934233AbXCVUnB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 16:43:01 -0400
Received: by ug-out-1314.google.com with SMTP id 44so813011uga
        for <git@vger.kernel.org>; Thu, 22 Mar 2007 13:43:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=fgn9iyRk1ZSIuc+HuwZHtkt9Y8i15G3ngh8Nc9Z4Crhg/N+DgKdxb3MFhllrPKhDhBpotfFyjYPtWl47yHWjkDnFIoeWnyEY5CgkQnL1nQgetJ3TtASibFmp6BR+ILRYxfvcsuXpWIEyHyB5SAOUXl4goyViKa1gJE3PCm0/0Po=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Dbm2dmaYL/wN20qrqsB0ytQC93/PDZYSX1PyBxH6EajjmXk96ECargjqlBp2MT5H3MCOoETehPXFGDzV+I8AYx0vLAl3dJsEcioLFE2hJa4o0JeaTa3AacA6gxaa0Sqqvw9WMNqzWuTLXhrci0v/8OL1u9QIjXbs/RK79Q02HSk=
Received: by 10.114.152.17 with SMTP id z17mr770482wad.1174596179276;
        Thu, 22 Mar 2007 13:42:59 -0700 (PDT)
Received: by 10.114.193.4 with HTTP; Thu, 22 Mar 2007 13:42:59 -0700 (PDT)
In-Reply-To: <7vejnht3x2.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Google-Sender-Auth: c5d64c15e7bb896b
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42879>

On 3/22/07, Junio C Hamano <junkio@cox.net> wrote:
> "Nikolai Weibull" <now@bitwi.se> writes:
>
> > I'm obviously doing something wrong, but in git 1.5.0.4
> >
> > % git check-ref-format abc
> > % echo $?
> > 1
> >
> > What am I missing here?
>
> If you are trying to see if abc is a valid branch name, try refs/heads/abc.

Thanks.  I just saw an example in git-checkout (where it's testing
"heads/$newbranch").

  nikolai

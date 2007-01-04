From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 4 Jan 2007 19:22:32 +0100
Message-ID: <81b0412b0701041022h30cd4fcxd62dbf3ecb504ea9@mail.gmail.com>
References: <7vwt4647g0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 04 19:22:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2XEc-0000Ti-Tk
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 19:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030179AbXADSWe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 13:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbXADSWe
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 13:22:34 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:47515 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965059AbXADSWd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 13:22:33 -0500
Received: by an-out-0708.google.com with SMTP id b33so250317ana
        for <git@vger.kernel.org>; Thu, 04 Jan 2007 10:22:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UnltnUOYb/KbB9ICim/C01lZDADnaDdNKF4Q36vhQEkRgZ//enIWu8XXoIG28pQnF0pCB9tnD4hI8SbhSIWo3sGR8cKY8dXcuQmygWVs2blGbWWTykbPwrwSVFYJkVkA+e5m+RSu+Wt1CNxow8d/TocDdsts7NoiZ2YhNpzRog4=
Received: by 10.78.171.13 with SMTP id t13mr2677356hue.1167934952321;
        Thu, 04 Jan 2007 10:22:32 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 4 Jan 2007 10:22:32 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vwt4647g0.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35943>

On 1/2/07, Junio C Hamano <junkio@cox.net> wrote:
> Here are the topics that have been cooking.  Commits prefixed
> with '-' are only in 'pu' while commits prefixed with '+' are
> in 'next'.  The topics list the commits in reverse chronological
> order.
>
> * sp/mmap (Sat Dec 30 22:13:43 2006 -0500) 25 commits

Running this and the merge-recursive speedup I sent today locally.
sp/mmap needs relatively recent cygwin library (otherwise pread
is broken). No other ill effects noticed. Perfomance is bearable.

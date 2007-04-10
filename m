From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-branch and git-remotes confusion
Date: Wed, 11 Apr 2007 00:33:43 +1200
Message-ID: <46a038f90704100533l7d795e79vd6245445c7e74c67@mail.gmail.com>
References: <46a038f90704100505i7bdd88a8q52186f7ce7ff0cdf@mail.gmail.com>
	 <20070410122516.GA27388@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 10 19:13:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbFY2-0004qs-45
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 14:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386AbXDJMdp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 08:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753730AbXDJMdp
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 08:33:45 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:64809 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbXDJMdo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 08:33:44 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1863806wxd
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 05:33:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=um1Ht8BVgdiNDeuFzzyWSgfi9nyP5txgsuHTOsY1Ms9oF63LeronePG351CGxiKw16SJG0hhOiblRTBQ79NHHZvgCjwogILyi2om+Y9mCGO9rk1XuEKRiKK2JIlF4VHvibPitx9+3OwLI3sAz9ulaibdPf6fUXjMgVfw89vI6CI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WOXlddLzpdsD7AJEgFtZfc3sxDcYZrF86ZtDL/nEWl9UjHbfhlh4mlGMXI4fewdLNHplpcx/8jbHfnEtkDkQYtMyBJDUINUfSJvHsgBncM8V60oSRzVbutg6KPgnTX9jdTOm/yK7Hcx0T2ChF2vQMzNLs5nixzrm+KYvZrSqWtA=
Received: by 10.90.100.2 with SMTP id x2mr5092566agb.1176208423541;
        Tue, 10 Apr 2007 05:33:43 -0700 (PDT)
Received: by 10.90.120.11 with HTTP; Tue, 10 Apr 2007 05:33:43 -0700 (PDT)
In-Reply-To: <20070410122516.GA27388@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44133>

On 4/11/07, Jeff King <peff@peff.net> wrote:
> Your arguments to git-branch are backwards. It should be:
>
>   git-branch --track my18-olpc origin/mdl18-olpc
>
> Also note that --track didn't show up until 1.5.1.  Other than that, it
> should do what you expect (check out your .git/config before and after
> to see the impact of --track).

thanks. And I'm reading the doco for 1.5.latest and it turns out I'm
using 1.5.0.5 so that won't work either.

hmmm. actually, I'm having another problem that is a bit more serious:
cloning via http doesn't create a remotes/origin and doesn't perform
the initial checkout.

will post separately about this...



martin

From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/5] diff --quiet
Date: Thu, 15 Mar 2007 09:22:13 +0100
Message-ID: <81b0412b0703150122k5a0f1d7u2d2c86e32ff8bbbd@mail.gmail.com>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net>
	 <7vodmv7bza.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0703141533q4e71e67aqaa83de45fa9e3988@mail.gmail.com>
	 <81b0412b0703141554r524346d0kf73a5d43b49ed99a@mail.gmail.com>
	 <7vlkhz5rd6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 15 09:22:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRlE3-0005jQ-0C
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 09:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933429AbXCOIWQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 04:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933154AbXCOIWQ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 04:22:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:18831 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933429AbXCOIWP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 04:22:15 -0400
Received: by ug-out-1314.google.com with SMTP id 44so230545uga
        for <git@vger.kernel.org>; Thu, 15 Mar 2007 01:22:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mw5FT13jEW5cLuwd/lZDJVjIl6bJtJKWblLK947Pm3o4putgLUZdK2UJpkOnh0EK0RrT7AZM9F/4kxVyi+kZ6KoToYwRVLwj51WD446hYMqZxkMseA/wr5aByhTsl/6ck6H2f8dZu6cGhpYjh6nw//PjEIDmUcI/bQis7OX69s4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NND2/p+HgJG3QhPjTkREuEim3ecsAJb3uJXlYbM8+ENYk6xrVStu9vbYutLofPcP8fEPj4Orm7BOw7JIepJ2TXNo1BIqNDSTP6wYDKq7hNlH9/IG330fK4l8ma2+EWNXLcxjSckRS2OmhDuO8ANC+deEMbam9y/xInRnqGgfw/c=
Received: by 10.78.195.9 with SMTP id s9mr205733huf.1173946933706;
        Thu, 15 Mar 2007 01:22:13 -0700 (PDT)
Received: by 10.78.138.5 with HTTP; Thu, 15 Mar 2007 01:22:13 -0700 (PDT)
In-Reply-To: <7vlkhz5rd6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42273>

On 3/15/07, Junio C Hamano <junkio@cox.net> wrote:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
>
> > Actually, I find it a bit strange to leave the output silent,
> > if --quiet is turned off. For all the user sees, it is still quiet
> > and exit-coded
>
> For that exact reason, for all the user cares, it is better to
> leave the output turned off and result given back with exit
> status.  --quiet is really for scripted use, in other words.

Of course! That's also were the performance matters.
Can diff quit early if -Ssomething given?

> I wonder if we should perhaps turn off the PAGER when --exit-code
> or --quiet is given.
>

Second that.Even is just to be on safe side. But again, it is not obvious
in case of --exit-code.

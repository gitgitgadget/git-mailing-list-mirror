From: "Robert Anderson" <rwa000@gmail.com>
Subject: Re: [PATCH] improve doc heading for git-bisect
Date: Sat, 7 Jun 2008 09:06:19 -0700
Message-ID: <9af502e50806070906u63e52de4wa0bc4dced0c4d984@mail.gmail.com>
References: <20080607070637.79B17C7C0E@rwavmlap>
	 <m37id1y4zj.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Jakub Narebski" <jnareb@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 07 18:07:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K50wl-0006iR-AL
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 18:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758990AbYFGQGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 12:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758765AbYFGQGW
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 12:06:22 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:7918 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbYFGQGV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 12:06:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so994506fgg.17
        for <git@vger.kernel.org>; Sat, 07 Jun 2008 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2CelUP/ZRkq9ZEH+McCILOM8BvOmiX0++BOPE9JHoCE=;
        b=nEN2x5FqrrMQQqFzj4A9IHUjd+mDuJaVr1KOE0B1IH3JZKF7Somby30TXQMfK4LdLZ
         OMod8sKw7C9Z80z/jNQAvfOX+A5GncT1aNW5sUjPyAXp+bgNsKspLjqFuLQiCFEgMtKa
         8m/tOs2DMpCLWvMULaywbo4dIWnbjYzt0lo4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kjXGI3tV0/l/tGrdV+V/EAtkomb4YHD3y6TqO+JpMjwSrZQ4+tLoiTfDlaeaecXDUS
         iHC76/0cNAB3nWjFWkH3mBlZBCRHV/q0yKK4geSnn5o9TY6lLH318QFvN7c629G5QuFX
         IJlnVSR0DaQXhnP708/jeUmbFZIPUd5k38Atw=
Received: by 10.86.93.17 with SMTP id q17mr2012953fgb.25.1212854779746;
        Sat, 07 Jun 2008 09:06:19 -0700 (PDT)
Received: by 10.86.95.16 with HTTP; Sat, 7 Jun 2008 09:06:19 -0700 (PDT)
In-Reply-To: <m37id1y4zj.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84210>

On Sat, Jun 7, 2008 at 2:22 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> rwa000@gmail.com (Robert Anderson) writes:
>
>> From 7af03a835b7311c501f2147e25f428642fc3acb7 Mon Sep 17 00:00:00 2001
>
> FYI this line is not necessary, and should be removed from
> git-format-patch output when pasting it to your MUA.

Err, then shouldn't it be removed from format-patch, rather than
deleted manually every time format-patch is used?

>> From: Robert W. Anderson <rwa000@gmail.com>
>> Date: Fri, 6 Jun 2008 23:53:37 -0700
>> Subject: [PATCH] improve doc heading for git-bisect
>
> FYI the above isn't strictly necessary: if you have 'From:' header set
> correctly you can simply set subject of email, and put in body the
> rest of commit message and patch only, without extra mail-like
> headers.

Then remove them from format-patch, IMO.

>> Improve awkward heading in git-bisect documentation.
> [...]
>> -Avoiding to test a commit
>> -~~~~~~~~~~~~~~~~~~~~~~~~~
>> +Changing the revision to test
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>>  If in a middle of bisect session, you know what the bisect suggested
>>  to try next is not a good one to test (e.g. the change the commit
>
> It is, I guess, better, but is it the best heading?  What we want to
> describe here is how to deal when bisect stops on commit which cannot
> be tested (e.g. project does not compile).

I disagree. The situation you want to use this is more general than
that.  Maybe you could test it, but doing so would be a waste of time
because the commit is a trivial comment change.  In general, this
simply what you need to know when you want to change the revision
under test.

Bob

From: "Chris Larson" <clarson@kergoth.com>
Subject: Re: merge-recursive: do not rudely die on binary merge
Date: Tue, 14 Aug 2007 17:18:10 -0700
Message-ID: <b6ebd0a50708141718w15ad2bbbrfa1d3c97ca7d4397@mail.gmail.com>
References: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net>
	 <20070814231422.GA10662@pe.Belkin>
	 <7vlkcdacbi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 15 02:18:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL6ai-000206-Vo
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 02:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbXHOASN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 20:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752624AbXHOASN
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 20:18:13 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:31226 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbXHOASM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 20:18:12 -0400
Received: by nz-out-0506.google.com with SMTP id s18so738244nze
        for <git@vger.kernel.org>; Tue, 14 Aug 2007 17:18:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=jv6bepdw+sT0BMsmuc99NlOa0KGv7p7p6/hIT3jwjkUyr3N/ge92JDYiboD0MciW4GkBt6FxnkQAEUWXRnceWU+OtUoKtIH870le5wie4n3OIjA+spFxz49y/ocipCQ5eWk5AZRO1+4HKM+C7xJ0SngWJS89mHPswRq5r3wBMRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=PwYdoIWQy3LCrvp1hi8YlhEJgfXfzAg5buw0Tqnn6WPfw0iqO3+0GMAhQ6pjRm7RWpDz1J/LkWTGCbvkBIy6byDcnVPHNwCYyVSrhCwXb2G44gJJNywIgvQmR9iDSDKwVpJtAz/YlfhIIenXzrK6PNzC0uEpK3HeVqkP3dpvTn8=
Received: by 10.142.102.5 with SMTP id z5mr354748wfb.1187137090857;
        Tue, 14 Aug 2007 17:18:10 -0700 (PDT)
Received: by 10.142.81.6 with HTTP; Tue, 14 Aug 2007 17:18:10 -0700 (PDT)
In-Reply-To: <7vlkcdacbi.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Google-Sender-Auth: 265acc1b72f81f65
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55868>

On 8/14/07, Junio C Hamano <gitster@pobox.com> wrote:
> Chris Shoemaker <c.shoemaker@cox.net> writes:
>
> >> This changes merge-recursive to still warn but do the "binary"
> >> merge for such a path; leave the "our" version in the working
> >> tree, but still keep the path unmerged so that the user can sort
> >> it out.
> >
> > Very nice.
>
> Forgot to ask.  I did this because you had trouble on #git
> yesterday and then at around the same time today somebody else
> had the same issue.  Did this patch solve your problem?  I do
> not think this has big risk of regression, but if it does not
> help anything there is no reason to put it in 1.5.3, so I am
> asking for a success report.

I got bit by this one earlier, and the patch fixed it here.
-- 
Chris Larson - clarson at kergoth dot com
Dedicated Engineer - MontaVista - clarson at mvista dot com
Core Developer/Architect - TSLib, BitBake, OpenEmbedded, OpenZaurus

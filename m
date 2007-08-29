From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: git-svn tags and branches
Date: Wed, 29 Aug 2007 12:53:15 +0200
Message-ID: <cb7bb73a0708290353iba0bdefl81a4a4e158be2fbf@mail.gmail.com>
References: <faulrb$483$1@sea.gmane.org> <85absc6we7.fsf@lola.goethe.zz>
	 <cb7bb73a0708280209r36136128x7bce310bf4fd4f66@mail.gmail.com>
	 <86sl64nhc1.fsf@lola.quinscape.zz>
	 <cb7bb73a0708280237v6f248517h183174bc41296df3@mail.gmail.com>
	 <46D4A664.4070007@vilain.net>
	 <cb7bb73a0708281620v41383ed8w728af0112d2a6360@mail.gmail.com>
	 <46D4ECE2.9020806@vilain.net>
	 <cb7bb73a0708290141y159d6bbfj2bac23af5e86bb15@mail.gmail.com>
	 <7v4piisolb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Sam Vilain" <sam@vilain.net>, "David Kastrup" <dak@gnu.org>,
	git@vger.kernel.org, "Eric Wong" <normalperson@yhbt.net>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 12:53:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQLAt-0008C8-JN
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 12:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756497AbXH2KxT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 06:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbXH2KxS
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 06:53:18 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:30855 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756404AbXH2KxR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 06:53:17 -0400
Received: by wr-out-0506.google.com with SMTP id 36so175291wra
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 03:53:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iV6ZfnYNygB5sWYQw/KhNyhqVRYRTKOZy1riDahMnYnkF5KEhCL6x90wHI4mfgasPSyIeodDil9l2GkoKGoVGvip9Qx6LJOK/v/wrFJjbgoYH4VaP8dQBDhuC1aBsJcNvsPhFOzkx0EMYYTbWRLGELYMf7JTP727mhgDbrROcJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=abSKWWyBOK5koO6MOM29XQCdYWADhkRt2we4afQ43WAwbm70zJruVda10k2ja6bsQ1WtsSRmBONSbmT2ErOWjmSiD/o8zET0XNVCAnXZQ4RLVlEqmqBnimWGQmoX0zFSQx5jab3CSdf0d3v7YwFGdpUsaTl95dRMe/4RNOLJKJI=
Received: by 10.114.209.1 with SMTP id h1mr966wag.1188384795639;
        Wed, 29 Aug 2007 03:53:15 -0700 (PDT)
Received: by 10.114.58.14 with HTTP; Wed, 29 Aug 2007 03:53:15 -0700 (PDT)
In-Reply-To: <7v4piisolb.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56934>

On 8/29/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:
>
> > BTW can git have a tag and a branch with the same name? If
> > not,...
>
> This is "Yes but".
>
> You can have a tag foo and branch foo.

[snip]

>  You can clarify yourself to avoid ambiguity like so:
>
>   . git branch newbranch heads/foo ;# I mean "branch from foo branch"
>   . git log tags/foo ;# "show history starting at that tag"

Ok. So assuming we import a svn repo which has a tag and a branch
called 'name', and that there are post-tag commits in tags/name, how
do we call the stuff?

We could call 'name' both the (annotated) tag and the branch, but what
name would we use for the branch created by post-tag commits?


-- 
Giuseppe "Oblomov" Bilotta

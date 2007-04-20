From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Fri, 20 Apr 2007 13:32:04 +0200
Message-ID: <dbfc82860704200432x5db9f1car7fe0a5e6e5c1f994@mail.gmail.com>
References: <200704171041.46176.andyparkins@gmail.com>
	 <200704172012.31280.andyparkins@gmail.com>
	 <Pine.LNX.4.64.0704171229360.5473@woody.linux-foundation.org>
	 <200704172146.33665.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Junio C Hamano" <junkio@cox.net>
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 13:32:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HerLz-0001h6-BV
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 13:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993003AbXDTLc1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 07:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993004AbXDTLc1
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 07:32:27 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:52584 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992954AbXDTLcF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 07:32:05 -0400
Received: by nz-out-0506.google.com with SMTP id s1so716851nze
        for <git@vger.kernel.org>; Fri, 20 Apr 2007 04:32:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=XF8hpILwwn/OgCHJfACayGRjGglqirQ9PGKBg7lor6I2aVAuLwtTf70oyTz2rO9Et/u/0u5zkCxGuVSDI0JNL1xeaILrqTBJ0qbkFXgWxCHLcOGm1Nt0olpAolkjvSN3bxXDFE8Mj+l4x8263a3vsYBUXqTDGyTQ15et4zDufQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=FCJGxrAIp9OOn8fVbM+R/icPZZUNUXQCPy19OtUT+A1/Qme7JO6AjemxO2CacAG0JqUVlQn50Qakv4JZViUv/CqhisG10gAHqlmpkcFN90UWBNwR6K/el+0PcabYGOD4/JtBKrKb/i+OcT8u15DJwwEvr7voPg0yBLnHF/Wdkos=
Received: by 10.115.46.9 with SMTP id y9mr1202668waj.1177068724546;
        Fri, 20 Apr 2007 04:32:04 -0700 (PDT)
Received: by 10.114.193.4 with HTTP; Fri, 20 Apr 2007 04:32:04 -0700 (PDT)
In-Reply-To: <200704172146.33665.andyparkins@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: b7399a0ae17b6599
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45091>

On 4/17/07, Andy Parkins <andyparkins@gmail.com> wrote:
> On Tuesday 2007, April 17, Linus Torvalds wrote:
>
> > No, you haven't. You've "addressed" them by stating they don't
> > matter. It doesn't "matter" that a diff won't actually apply to a
> > checked-out tree, because you fix it up in another tool.
>
> Okay.  I think this is a matter of perspective - my perspective is that
> if it supplies what svn/cvs supply then that would please the people
> who want it (of whom I am one); yours is obviously that if it isn't
> perfect, it's not worth doing.  That's a reasonable thing to demand,
> and I'm not going to try and argue you out of it.

Loads of people would be pleased if marijuana was legalized.  For some
reason, few governments seem willing to cater to their needs.

  nikolai

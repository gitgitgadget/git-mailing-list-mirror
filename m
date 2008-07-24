From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Thu, 24 Jul 2008 22:08:50 +0400
Message-ID: <20080724180849.GA2925@dpotapov.dyndns.org>
References: <200807230325.04184.jnareb@gmail.com> <20080723143810.GR2925@dpotapov.dyndns.org> <200807232349.42244.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 20:10:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM5GF-0005If-Mw
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 20:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbYGXSI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 14:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbYGXSI4
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 14:08:56 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:45916 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbYGXSIz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 14:08:55 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2168157mue.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 11:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=H6XWs+dqXA5bPbbBZ3sWvcoFxH84PeeIJ+KEnYZoETQ=;
        b=FYVxwibW9bCUWLDXfxl1dv7ANs/0Yf4gAFT3LwfWCnV0gu8PPRJE79GRZr7av1+a32
         NlMS9jLoMA78cLlvcPJrg5RNGWy6GAwcZyXQwvf3KOHNcbxYYslR9LwviNveTNOoB0cE
         JsqMyLOZJRoANZnhJPuh5lBKuIxD+cHnC3zyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VYLpvbpSsfFXpqmC/TX1tuIFMOKMDSu60BQMiXOvmogIUXyZWqXiWulBXLrgdTx0jX
         jH3DXYCJ8rrGuy8hd2rXDM5UK2zmftwS8E8fK3y9JcWXO/vZYHCd7W+RzQXT088NCJcA
         OBjzl6WRQVDxoekFfUwrvXPA3DR803Ei8CqW0=
Received: by 10.103.207.18 with SMTP id j18mr297259muq.21.1216922934031;
        Thu, 24 Jul 2008 11:08:54 -0700 (PDT)
Received: from localhost ( [85.140.170.251])
        by mx.google.com with ESMTPS id j10sm23811767mue.6.2008.07.24.11.08.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 11:08:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200807232349.42244.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89928>

On Wed, Jul 23, 2008 at 11:49:41PM +0200, Jakub Narebski wrote:
> On Wed, 23 Jul 2008, Dmitry Potapov wrote:
> > On Wed, Jul 23, 2008 at 03:25:03AM +0200, Jakub Narebski wrote:
> > >
> > >    02. What is your preferred non-programming language?
> > >   (or) What is the language you want computer communicate with you?
> > 
> > IMHO, the later wording of the question is much better.
> 
> First just satisfies demographic curiosity.  Second is more question
> about internationalization (i18n).

I think demographic is largely covered by the first question about
country. As to i18n, I don't think it is fully covered just by the
question about one's language preference to communicate with computer
(which is probably is more correctly to call localization). Possible
questions related to i18n are:
- Do you use file names with non-ASCII characters?
- Do you use text files with non-ASCII characters?
- Do you (or members of your team) use computers with different
  character sets and have to deal with non-ASCII characters?

But I guess we do not want to have so many questions. So, maybe
something simple instead:
- Are you satisfied with support for non-ASCII characters in Git?

> Should "What version do you use now?" be multiple choice (using git
> on more than one machine / operating system)?

I think we already have another question about what OS one uses.
So I believe it should be only version number here.

> What should be possible
> choices for "How long do you use git?"?  Perhaps.
> 
>       10. How long do you use git?
>           (single choice)
>        -  never/few days/few weeks/month/few months/year/few years/
>           from beginning/I wrote it(*)
>        +  (*) just kidding ;-)

I would rather use numbers like that:

never
less than month
1-3 months
3-6 months
6-12 months
1-2 year
more than 2 years
from the beginning

Dmitry

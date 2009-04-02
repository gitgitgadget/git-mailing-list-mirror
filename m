From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Broken t9001 tests
Date: Thu, 2 Apr 2009 10:14:43 -0400
Message-ID: <76718490904020714x3f00d5fu6f13587be383be1b@mail.gmail.com>
References: <alpine.DEB.1.00.0904021520200.7464@intel-tinevez-2-302>
	 <20090402134019.GA26699@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 02 16:17:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpNj2-0007r8-0N
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 16:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756449AbZDBOOq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Apr 2009 10:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756209AbZDBOOq
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 10:14:46 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:60502 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377AbZDBOOp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2009 10:14:45 -0400
Received: by gxk4 with SMTP id 4so1247533gxk.13
        for <git@vger.kernel.org>; Thu, 02 Apr 2009 07:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0Qu9T6uDrSJiqI2DX4eXH2vGjitTs8noP3EXia0KMx0=;
        b=G8fK2OGBT2qrFLi4uVPu8dn6nhx40Ys0bPrVHDUiO2R0KPyZdO9fnGNNf8X1b2R00m
         7tLTe1fFWg7s0UCgZmQ9rIM09MMNvuIlulDKXJirw9QJV6Q9PctN13CEenEsGOZqN5M0
         sdEVLBKKwe7wN/HSKN93kIMORBZzDUrUVyuPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vOFrycwE9gJ829SMUwAvTIYS2yElB7jQ2QpNGZsuYEqJrxxevtLUR0Mlfigc9J8kIm
         y6Qks5aibbHeOh17xQAxDo3PdWgUZFqO67gso1PE6vMS10WJz+L1wDNfHvNMk6UTo1gP
         S6exgKe13C+nDxdjE7h2uKTjg1fs6+X3rsamw=
Received: by 10.150.219.16 with SMTP id r16mr178381ybg.186.1238681683456; Thu, 
	02 Apr 2009 07:14:43 -0700 (PDT)
In-Reply-To: <20090402134019.GA26699@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115467>

On Thu, Apr 2, 2009 at 9:40 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 02, 2009 at 03:22:33PM +0200, Johannes Schindelin wrote:
>
>> only when I revert both dc1460a(send-email: ask_default should apply=
 to
>> all emails, not just the first) and c18f75a(send-email: add tests fo=
r
>> refactored prompting) does my test suite pass without asking me
>> _interactively_ (twice, even) if I want to
>>
>> =C2=A0 =C2=A0 =C2=A0 Send this email? ([y]es|[n]o|[q]uit|[a]ll):
>>
>> Please fix.

Sorry, as Jeff mentions:

> Try
>
> =C2=A0http://article.gmane.org/gmane.comp.version-control.git/115280

And BTW, it's not as if I didn't test. The "going interactive" issue
is hidden by bash. But don't worry, I've since downloaded and
installed dash just for running git tests, so it won't happen again.

> Junio seems to have picked up the first part of the series, but not t=
his
> fix. I'm not sure why.

Junio, may I please draw you attention to 3/4 and 4/4 at the link
above. Please amend the commit message for 3/4 though. It says it
corrects commit 67f1fe5 which is wrong. Please sed
's/67f1fe5/c18f75a/' in that message.

Thanks,

j.

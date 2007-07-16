From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Mon, 16 Jul 2007 20:02:39 +0200
Message-ID: <e5bfff550707161102n3b6da174i7bbff64e1739a1b2@mail.gmail.com>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	 <7vodiehko7.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550707160504p52770227l9af66aa750d9efd6@mail.gmail.com>
	 <81b0412b0707160531mad35ed4x4c89b2d6c6f5f707@mail.gmail.com>
	 <7v4pk444rd.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550707161055i2f12b858n7be155765fb664@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 20:04:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAUwF-0003XY-28
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 20:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761026AbXGPSDi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 14:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759830AbXGPSCq
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 14:02:46 -0400
Received: from nz-out-0506.google.com ([64.233.162.237]:59400 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760274AbXGPSCl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 14:02:41 -0400
Received: by nz-out-0506.google.com with SMTP id s18so906941nze
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 11:02:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qqb0iCMFFFSKMwbVBC9s8CiF13SM8zpSGWGyLoqHlWazNE82fZEvRR4VWUNHSdP4R4i+tZJYXO82dtnAX+nliskhU7oySRG/bYAsZGQX9dCwAUohiRIptCoKdtQI5atVZwGsodMEfq8LDE8A4QKSUo9Oe68+/zSxuKN4Nu+iP2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f7ISHI/RUMxERDsF6xVpeBFLsrHIzK+2rvhhm9yUdhxIocpwB0AFIa1VUF3MlXabJ8dEEPi0yymEHqHf2oJdlzIUu6Os0EcS4RL+EbihEh82vXIqpWlfgvJIQlzRA/U7SoLRwzS9WyFT0O7NUvzc6ElseYUrxiPOHwEazTpvT/E=
Received: by 10.115.54.1 with SMTP id g1mr4337502wak.1184608959987;
        Mon, 16 Jul 2007 11:02:39 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Mon, 16 Jul 2007 11:02:39 -0700 (PDT)
In-Reply-To: <e5bfff550707161055i2f12b858n7be155765fb664@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52703>

On 7/16/07, Marco Costalba <mcostalba@gmail.com> wrote:
> On 7/16/07, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > I'd say making --show-message-size option incompatible with diff output
> > would be good enough futureproofing for now.
> >
> Oooops, I didn't see your post.
>
> I agree 100%, please tell me if doc it's clear enough or it would be
> better to clarify that "message log" it means only message and no diff
> content.
>

Sorry to bother you again, but my English is very bad and I would like
to be clear.

When i say no diff content I mean that git log --log-size -p it's a
perfect valid command but --log-size will make git print the size of
_only_ the log part, it means from the line after "log size xxx\n"
until the end of log message that can be '\0' (if no diff) or the
beginning of diff part.

Sorry to be pedantic.

Marco

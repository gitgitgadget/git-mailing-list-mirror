From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] git log -g: Complain, but do not fail, when no reflogs are there
Date: Tue, 24 Jul 2007 12:17:23 +0200
Message-ID: <81b0412b0707240317q56e42a9bs44eb3e5ef9e796c6@mail.gmail.com>
References: <Pine.LNX.4.64.0707240039300.14781@racer.site>
	 <81b0412b0707240026v4321a709wcbbbd7b67a4c506b@mail.gmail.com>
	 <Pine.LNX.4.64.0707241014500.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 12:17:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDHSK-0001D9-Ti
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 12:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbXGXKR0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 06:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbXGXKR0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 06:17:26 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:18444 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765998AbXGXKRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 06:17:25 -0400
Received: by wr-out-0506.google.com with SMTP id 37so1123613wra
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 03:17:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fzzeIfqldROMxfH8SxX5+0V9C7sxSsMCCqhHr0lHO3okuRF8LsHcsun2PILbaLRmfQD9zl812gHIckfew56k/fN15zzpT2TTpvDPNy+GILM0xk6p68IqyNwOkSJDTvvZoGxlJIsdL1jWD8+ZQ0XevbXXJIj1lxlBQZw2Fe86JJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e9+v45Eh/xppaNep7IzVFl97JmvxHD/tBywJUFA67L5yqY1Q02elHdy5KaKZraj7iu196wLIquPLG8327VQ0ncqcqbRujVaOnVykScM2EmFRCNjxQVlsRMe8+62IcSfLjBvQUGKeIgdVuN/gAA8rXnWQ5p8ud3PTW9YDwjzdBCc=
Received: by 10.78.56.19 with SMTP id e19mr1033057hua.1185272243805;
        Tue, 24 Jul 2007 03:17:23 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Tue, 24 Jul 2007 03:17:23 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707241014500.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53555>

On 7/24/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 24 Jul 2007, Alex Riesen wrote:
> > On 7/24/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > When asking "git log -g --all", clearly you want to see only those refs
> > > that do have reflogs, but you do not want it to fail, either.
> > >
> > > So instead of die()ing, complain about it, but move on to the other refs.
> > >
> >
> > I believe you wont even see these complaints: the pager will start shortly
> > afterwards and fill the screen with commits, completely hiding the errors.
>
> You can see it briefly, but it is hidden by default.  Which is a good
> thing.  If you set the pager to "cat" (which is happily not the default!)
> you can see them clearly.  Until you are swamped by the rest of the
> output.
>
> Maybe this is a feature?
>

Maybe. I can't see it at all. Should I downgrade something or propose
a patch to put some delay after this error? I think not.

I think second Junios suggestion, but this is of course no
difference to me.

From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: ks/precompute-completion
Date: Fri, 23 Oct 2009 15:39:04 -0700
Message-ID: <fabb9a1e0910231539n543ba908k3d57bcd01e5e233c@mail.gmail.com>
References: <7veiovly35.fsf@alter.siamese.dyndns.org> <fabb9a1e0910221556s694a344ag8e5ae07c35351ee4@mail.gmail.com> 
	<4AE0E542.8010501@gmail.com> <fabb9a1e0910231127i3ab469qebdc17168a58f22a@mail.gmail.com> 
	<7vd44eaqc5.fsf@alter.siamese.dyndns.org> <fabb9a1e0910231216j2a024ac5mf5b5ccb5322722f8@mail.gmail.com> 
	<7v1vktc1uk.fsf@alter.siamese.dyndns.org> <m3d44deu93.fsf@localhost.localdomain> 
	<fabb9a1e0910231322y1355ca8ck209bcd64bd29dec6@mail.gmail.com> 
	<4AE22E48.9050408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Stephen Boyd <bebarino@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Sat Oct 24 00:39:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1SnD-0007h3-74
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 00:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbZJWWjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 18:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbZJWWjV
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 18:39:21 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:50032 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbZJWWjU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 18:39:20 -0400
Received: by ewy4 with SMTP id 4so2082294ewy.37
        for <git@vger.kernel.org>; Fri, 23 Oct 2009 15:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=SAOKWiUGJTo5KtmxQv+URSm1f4x45ZkV1RzBYX+5UzA=;
        b=N/vyoSuvJ8/uV8cri2bCCIMTQWd02w2budSWoDL5LAmnFI/UutbUcHxO/+gt/5v/+r
         +Nn6gK4eVibWr4qPDDbzDlaB4mq/4D3a2+QkeGO5OEqHVz0i9rFRbs4LRtSlVy+bYbfg
         NdTYDN8yAcZvbu1OSOSO8s1dRpL48RAdj2plE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=pS13KzDdSlI4BX7KxQTYLLHGY/V4IOsOX0hEElkF00mTlGImR0BlP3tw7KVvb8ldS8
         MYwQJaJdQPbr99yNlVkM0EqKm/lXYX9U3wQfrbft7l8Axajt63dj4C2sn3Z58Q+sP3pV
         Kv+3nwFXD0wrPUmFy0sMa+W5qEpDB3KLQJvqo=
Received: by 10.216.86.212 with SMTP id w62mr4146035wee.131.1256337564151; 
	Fri, 23 Oct 2009 15:39:24 -0700 (PDT)
In-Reply-To: <4AE22E48.9050408@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131138>

Heya,

On Fri, Oct 23, 2009 at 15:29, A Large Angry SCM <gitzilla@gmail.com> wrote:
> It seems that you want the completion script promoted out of contrib.
> Otherwise, you're asking for it to be treated special with respect to
> everything else in contrib and have the top level Makefile be aware of it
> and add it to the main targets.

That would seem like a sensible solution ;).

> The promotion I have no problem with as long as the install location is not
> somewhere where any shell will find it without a config setting in the
> user's shell. Leaving it in contrib and and adding it to top level Makefile,
> I do have a problem

Something like this then?

http://repo.or.cz/w/git/dscho.git?a=commit;h=eb966204d17dcab7abf61621219312a813c87405

-- 
Cheers,

Sverre Rabbelier

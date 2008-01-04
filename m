From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH] git stash: one bug and one feature request
Date: Fri, 4 Jan 2008 11:36:30 -0800
Organization: Google, Inc.
Message-ID: <20080104193630.GA26843@bulgaria.corp.google.com>
References: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com> <Pine.LNX.4.64.0801041030420.31161@torch.nrlssc.navy.mil> <477E6D26.9020809@obry.net> <m3abnlo4xv.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pascal Obry <pascal@obry.net>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 20:38:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAsNG-0005Mm-7E
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 20:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021AbYADTiG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jan 2008 14:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbYADTiF
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 14:38:05 -0500
Received: from smtp-out.google.com ([216.239.45.13]:1822 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbYADTiE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 14:38:04 -0500
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id m04JajwK018939;
	Fri, 4 Jan 2008 11:36:45 -0800
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:cc:subject:message-id:references:
	mime-version:content-type:content-disposition:
	content-transfer-encoding:in-reply-to:organization:user-agent;
	b=HqqKyIucTCE1/9YUcPO7f8uZnEGJ30EoEXlJ/HLlooyGScizOakBgIUzn2878Fdxu
	PV1Z8Xm1utqih2XhECwHg==
Received: from bulgaria (bulgaria.corp.google.com [172.18.102.38])
	by zps37.corp.google.com with ESMTP id m04Jag6h024068;
	Fri, 4 Jan 2008 11:36:42 -0800
Received: by bulgaria (Postfix, from userid 1000)
	id BB2D11224A3; Fri,  4 Jan 2008 11:36:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m3abnlo4xv.fsf@roke.D-201>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69597>

[Jakub Narebski <jnareb@gmail.com>]
> Pascal Obry <pascal@obry.net> writes:
> > Brandon Casey a =E9crit :
> > >
> > > Not sure how often such a command would be used though, so
> > > it may not be worth it.
> >=20
> > I've missed it many times. Especially in some scripts when I want t=
o use
> > the stash-stack to store current working tree and clear it before
> > exiting. This is not possible today as all the stash-stack would be=
 cleared.
> >=20
> > I agree that drop seems better.
>=20
> or "git stash delete"

Something like drop or delete would be nice.

I tried to "clear" a single stash once. Oops!

Is there a reason that git stash apply couldn't take a small integer
as the argument (at least as an alternative) instead of stash@{0}, etc?

Brian

From: Nico Williams <nico@cryptonector.com>
Subject: Re: Is there a way to mark a branch as published?
Date: Fri, 1 Aug 2014 14:17:34 -0500
Message-ID: <CAK3OfOgxngLhh7FjrBT9NcK=LhEH9TAz+18LAvXJtt_bV=96wA@mail.gmail.com>
References: <CAK3OfOjPQ1fcoA7O6EDcQ3iW_AdsjitK4WKSdLwpRRXm8xfrVA@mail.gmail.com>
	<1406919490.3253.3.camel@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git discussion list <git@vger.kernel.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Fri Aug 01 21:17:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDIKi-0007Fs-Ju
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 21:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822AbaHATRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 15:17:36 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:42798 "EHLO
	homiemail-a64.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750851AbaHATRg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 15:17:36 -0400
Received: from homiemail-a64.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a64.g.dreamhost.com (Postfix) with ESMTP id CED3E43807F
	for <git@vger.kernel.org>; Fri,  1 Aug 2014 12:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type; s=cryptonector.com; bh=NExQtqwsVv7q8RKFO9XC
	E9KYOnc=; b=MRpIv0/+MHrWWrahoL1tb4zAejein34rF99KmI4e29CYRtgO4TZ3
	G/afDuyMGgs5jtOqSCxnvSnt4kb1WoDJJS7eqlMGKkqJAqkjPvOR+tcVI9heVJv5
	ax4REt8oqpEaQoxLBFFHHjnutQxYKkM4LARb/+nwLTOqW+Ttvv532Sw=
Received: from mail-we0-f172.google.com (mail-we0-f172.google.com [74.125.82.172])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a64.g.dreamhost.com (Postfix) with ESMTPSA id 82C0143807C
	for <git@vger.kernel.org>; Fri,  1 Aug 2014 12:17:35 -0700 (PDT)
Received: by mail-we0-f172.google.com with SMTP id x48so4819078wes.31
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 12:17:34 -0700 (PDT)
X-Received: by 10.194.103.38 with SMTP id ft6mr10735308wjb.18.1406920654285;
 Fri, 01 Aug 2014 12:17:34 -0700 (PDT)
Received: by 10.217.98.6 with HTTP; Fri, 1 Aug 2014 12:17:34 -0700 (PDT)
In-Reply-To: <1406919490.3253.3.camel@spirit>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254651>

On Friday, August 1, 2014, Dennis Kaarsemaker <dennis@kaarsemaker.net> wrote:
>
> On di, 2014-07-29 at 17:40 -0500, Nico Williams wrote:
> > (or all of a repo's branches)
> >
> > Teamware recorded whether it had any "children" and warned about
> > rebasing published contents.  Perhaps git could do the same.
>
> Git doesn't record this directly, but you can see which known remote
> branches contain the tip of a branch:

Yes, but that says nothing about whether they accept non-ff merge
pushes, or should reject them, and it says nothing about whether they
are intended to be seen as "published" in the sense of having stable
history.  (Teamware would mark repos as published when cloned, but
that often meant needing to reset that flag [it wasn't a flag, but i'm
eliding irrelevant details].)

Yes, non-fast-forward pushes can be rejected with a hook, but a flag
that could be set with a git command would be more convenient.

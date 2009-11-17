From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: git multisite setup
Date: Tue, 17 Nov 2009 01:50:40 +0100
Message-ID: <20091117005005.GC13074@vidovic>
References: <13f0168a0911161018r6fc67d29n781cca670a66815b@mail.gmail.com> <20091117001320.GA13074@vidovic> <13f0168a0911161617o56757488n45328714fb1d3bea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Matt Di Pasquale <liveloveprosper@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 01:51:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NACHx-0005LY-Pm
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 01:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933AbZKQAuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 19:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754571AbZKQAuv
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 19:50:51 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:18173 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517AbZKQAuu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 19:50:50 -0500
Received: by ey-out-2122.google.com with SMTP id 9so2115149eyd.19
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 16:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=tdp8s7Kvq8Iq/cth1mc3h4b6GMTvPMfU1cf/suCgHwo=;
        b=LtWcGEwtdQAMJPMCJmwwSCgUcHpru3JncNEEMtW9BsHXqj4bILW4LucXcVqHUuOWi+
         77wBjcDJIW2KC+lPsZK1hVDzH+q1PzMJEXAkEDwbKABKom7pyvU/zk9oh1G3aO/g18GZ
         zwk0547xDna/Wh8UYBMhKKU+y401X19P3gaKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rZl8+KWZzfIZxZXRGyUC5xFVbvQgYqPnSyhwy3Zdz+UiNHgJWBf8qB5MVlf+/Vrdpn
         UdqK0Dj8GzP56VZyOy6tnR5VeNdm3ohA/JY0vcn6LzluWT3xTWLFYqkeudUOna7tJPoR
         5N+V54GI5tsPvEsGlXQEmm1iE/4ekOl440pRM=
Received: by 10.213.0.135 with SMTP id 7mr1365021ebb.65.1258419055290;
        Mon, 16 Nov 2009 16:50:55 -0800 (PST)
Received: from @ (91-164-137-149.rev.libertysurf.net [91.164.137.149])
        by mx.google.com with ESMTPS id 28sm331041eye.1.2009.11.16.16.50.52
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Nov 2009 16:50:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <13f0168a0911161617o56757488n45328714fb1d3bea@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133047>

[ Please, don't top-post nor whole quote. ]

The 16/11/09, Matt Di Pasquale wrote:

>                                       the specific git repos aren't
> coordinated to the generic one. but that's fine so far since i haven't
> had to jump around to different commits and the generic has stayed
> pretty much the same.

I'm not sure to understand exactly what kind of coordination you expect
exactly (because you don't describe what you'd like that much), but
submodule could be what you need, yes.

FMHO, the best way to check if you need it is to try it. For a good
start, I guess you'll need to change your approach on "what depends of
what". I think you should consider the _common_ part to be the
_dependency_; as a consequence, it should be the submodule used in the
other repositories. AFAIR, submodule was originaly designed to make our
life easier with libraries. It may fit to your needs too but again, the
best thing to do is to try.

-- 
Nicolas Sebrecht

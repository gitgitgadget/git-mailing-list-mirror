From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: most annoying thing in git-push
Date: Tue, 23 Jun 2009 01:12:56 -0700 (PDT)
Message-ID: <m3fxdrxt16.fsf@localhost.localdomain>
References: <20090622192147.GE5743@altlinux.org>
	<7vd48va3dd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Alexey I. Froloff" <raorn@altlinux.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 10:13:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJ17q-0002Zg-3g
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 10:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbZFWIM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 04:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbZFWIM5
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 04:12:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:39962 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbZFWIMz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 04:12:55 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1261780fgg.17
        for <git@vger.kernel.org>; Tue, 23 Jun 2009 01:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=eXFJuywc6uyo+72qoUw1jnYf38Dw51Ky0KO1/+pbfek=;
        b=PSpQ80gKlILVT6R2jPJGr5pcPlj1QuUcPsRp464UCAF7iBFuStEPF2+ZXK+hUJJONf
         ACuHjv5/7anmRIUFyKh7QtvHw2AVDumaBiTGsUXpJ/COHb5PzlXfuaFp38OPWHkQ9j3u
         cx5EIOkTfs4KCRvba//jx6Oat2c3kc8zF57jY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=VMGAfLabJhE4nzWyKkaJ4e8V735rdkiBhBHFEjBl4SXfZkT7o2MQCGKWv/0wlahGXq
         EwqAoJQVdKSn83RQN5dElXg48tAWcL2+xJdb1XXk+BhYL7MUperLp/CsVtkcty8NRNeH
         caJRpbGUFw89GLw6ojZLDGHY51ONnQLnyHPSo=
Received: by 10.86.91.13 with SMTP id o13mr7857540fgb.23.1245744776910;
        Tue, 23 Jun 2009 01:12:56 -0700 (PDT)
Received: from localhost.localdomain (abvx197.neoplus.adsl.tpnet.pl [83.8.221.197])
        by mx.google.com with ESMTPS id e11sm10157856fga.6.2009.06.23.01.12.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Jun 2009 01:12:56 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n5N8IENo031960;
	Tue, 23 Jun 2009 10:18:15 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n5N8IDnX031956;
	Tue, 23 Jun 2009 10:18:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vd48va3dd.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122079>

Junio C Hamano <gitster@pobox.com> writes:
> "Alexey I. Froloff" <raorn@altlinux.org> writes:
> 
> > Is is possible to add such functionality to git-push, so it will
> > push tags that point at objects that were uploaded to the remote
> > repository?
[...]

> It however is entirely a different matter if it is a sensible thing to do.
> 
> Often, a fetch is made from a public distribution point, which by
> definition has only branches and tags that are meant for public
> consumption.  It makes sense to auto-follow tags by default.
> 
> On the other hand, a push is almost always made from a private working
> repository to a public distribution point, in order to update the latter
> with only refs and objects meant for public consumption.  A developer
> working in such a private working repository will use tags that are not
> meant for public consumption while developing, and pushing all tags that
> are reachable from the commits that are being pushed out to the public
> distribution point is not necessarily desirable, as it will push out many
> tags that are only private to the working repository.
> 
> It certainly is not a sensible default behaviour, even though it might be
> handy as an option for special cases.

Perhaps if "autofollowing" of tags was enabled only for 
annotated/signed tags?

-- 
Jakub Narebski
ShadeHawk on #git

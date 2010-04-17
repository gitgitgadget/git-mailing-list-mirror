From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git documentation writing guidelines (was: Re: ghost refs)
Date: Sat, 17 Apr 2010 09:57:40 -0700 (PDT)
Message-ID: <m3mxx2dnlu.fsf_-_@localhost.localdomain>
References: <20100407210010.GB27012@coredump.intra.peff.net>
	<89030B4A18ECCD45978A3A6B639D1F24032A0750BE@FL01EXMB01.trad.tradestation.com>
	<k2p32541b131004071503g4ce66e5bjac8270b10790a2af@mail.gmail.com>
	<89030B4A18ECCD45978A3A6B639D1F24032A0750CC@FL01EXMB01.trad.tradestation.com>
	<k2x32541b131004071511i9bbe883az504547d6133aef@mail.gmail.com>
	<20100408043059.GA28768@coredump.intra.peff.net>
	<89030B4A18ECCD45978A3A6B639D1F24032A075390@FL01EXMB01.trad.tradestation.com>
	<7vwrwh6fz8.fsf@alter.siamese.dyndns.org>
	<20100408194908.GB4222@sigill.intra.peff.net>
	<7vbpdt65ie.fsf@alter.siamese.dyndns.org>
	<20100417115111.GB28623@coredump.intra.peff.net>
	<7v8w8m3uqj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 18:57:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3BL2-0005dj-D6
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 18:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794Ab0DQQ5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 12:57:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:30609 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab0DQQ5m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 12:57:42 -0400
Received: by fg-out-1718.google.com with SMTP id d23so958585fga.1
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 09:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=+n8YegXSo+RurU1xtV9jnXHnaJPlyPgvwT91+cZqrxU=;
        b=nWJAjP7L6jE3eWlM7dCuzx7Azm6ZcJaU4i3N4ubQMTTCh8VaB0Criu3sDn1blL/Vr1
         f9RHHj751rBgUqH7ssLhuUmd545GtrxWRXcYiBvbBCdlGCMBp0IYo1+ZeKwX9HeJV7oL
         LJwKfiFhWj4l7rDU8oIhGLOwFeYaCM/m7m1qo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Ly4pIEAnlUd6j+vKsrh4kHLS05JHsgZ93e9AWUn/ERd6M/j4vHN2THjpvk9Dxg/2fH
         PfAUixtNgSNFK5YM7zIXOYs3KnkzjEltSrgSrEtDLnhzcyfQaf6Yo2ml5jmNfomryowW
         VZ6gfvb0ZXB2FGy1dJDnwq51gkSbJzJAb83M0=
Received: by 10.87.66.15 with SMTP id t15mr2454625fgk.37.1271523461197;
        Sat, 17 Apr 2010 09:57:41 -0700 (PDT)
Received: from localhost.localdomain (abvc197.neoplus.adsl.tpnet.pl [83.8.200.197])
        by mx.google.com with ESMTPS id e11sm2201083fga.18.2010.04.17.09.57.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 09:57:40 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3HGuvbG001477;
	Sat, 17 Apr 2010 18:57:08 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3HGuUS3001466;
	Sat, 17 Apr 2010 18:56:30 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v8w8m3uqj.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145157>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:

> > git-config (or perhaps even gitconfig(7)) should have a list of all
> > variables and where they are described, like:
> >
> >   apply.ignorewhitespace        git-apply(1)
> >   apply.whitespace              git-apply(1)
> >   branch.autosetupmerge         git-branch(1)
> >   [etc]
> >
> > There is not much point in having full descriptions in one giant list.
> > Instead, you can peruse the whole list, and then go to the configuration
> > section of the relevant manpage to see a bunch of related options. Such
> > a list should be pretty easy to generate automatically from the other
> > documentation.
> 
> Yes, I like it.

Well, there are some variables, like advice.*, or core.*, or alias.*, or
color.*, or browser.<tool>.path, or i18n.*, or interactive.singlekey,
or notes.*, or user.* that do not really belong to single git command
(well, perhaps they could be put in git(1) manpage), or belong to more
than one command.

-- 
Jakub Narebski
Poland
ShadeHawk on #git

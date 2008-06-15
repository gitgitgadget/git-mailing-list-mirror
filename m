From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] The "curl" executable is no longer required
Date: Sun, 15 Jun 2008 04:42:06 -0700 (PDT)
Message-ID: <m3fxreq60t.fsf@localhost.localdomain>
References: <200806120920.31161.johan@herland.net>
	<200806151216.01886.johan@herland.net>
	<ee77f5c20806150352n6ccf00e9w8083a17d8c5c2326@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johan Herland" <johan@herland.net>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 13:43:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7qdX-00026U-4Q
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 13:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757277AbYFOLmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 07:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757270AbYFOLmL
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 07:42:11 -0400
Received: from hu-out-0506.google.com ([72.14.214.231]:2964 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757247AbYFOLmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 07:42:09 -0400
Received: by hu-out-0506.google.com with SMTP id 28so5916822hub.21
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 04:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=RCscSzXLxLjenrI1d+/OkP6mE6U9N7i5VxbXBGDfpD4=;
        b=ih7m98HQQAYc6JJkX0O2Nf1YSHADGCI1fXeeenDgC8uvhoLTDy0gzY+d/hzmymWu7F
         x7c0kNPG8sl+agVZdNc12ibXOMg8nkR7DmyNu1ZnIYwa7wlAVFhnQ7uQZCrppls3l/7m
         Fx0mGlEFj9XYwrmvXgudiQZ8ILf+b+ZjIH1J4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=ncArJ9/IM6t8SXckwoJ/oKhaYxSb0C/2Qhv/rbY2lAnM3gOh05gaEUSTShy5vFSfLV
         289EceWsZV9PSexkKKfCsgSwaEoVGhMRgnTnjstzT9CaAQ4GORqcX5+dXZhQdUk6iD3C
         dHeGMiLPSUcdkbfNhQk5mpIuLDQD9uTPeE2pM=
Received: by 10.66.233.10 with SMTP id f10mr4373741ugh.17.1213530127489;
        Sun, 15 Jun 2008 04:42:07 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.239.84])
        by mx.google.com with ESMTPS id q40sm6149673ugc.6.2008.06.15.04.42.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 04:42:06 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5FBg2vu031873;
	Sun, 15 Jun 2008 13:42:03 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5FBfsWI031870;
	Sun, 15 Jun 2008 13:41:54 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <ee77f5c20806150352n6ccf00e9w8083a17d8c5c2326@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85082>

"David Symonds" <dsymonds@gmail.com> writes:

> On Sun, Jun 15, 2008 at 8:16 PM, Johan Herland <johan@herland.net> wrote:
> 
> > diff --git a/git.spec.in b/git.spec.in
> > index 97a26be..d946bb1 100644
> > --- a/git.spec.in
> > +++ b/git.spec.in
> > @@ -12,7 +12,7 @@ BuildRequires:        zlib-devel >= 1.2, openssl-devel,
> > curl-devel, expat-devel, gettex
> >  BuildRoot:     %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
> >
> >  Requires:      perl-Git = %{version}-%{release}
> > -Requires:      zlib >= 1.2, rsync, curl, less, openssh-clients, expat
> > +Requires:      zlib >= 1.2, rsync, less, openssh-clients, expat
> >  Provides:      git-core = %{version}-%{release}
> >  Obsoletes:     git-core <= 1.5.4.2
> >  Obsoletes:     git-p4
> 
> Shouldn't libcurl still be listed as a requirement? Or is it
> statically linked?

It is not necessary to enumerate simple library dependencies, as
rpmbuild _detects_ those dependencies during building binary RPMS.
Only unusual requirements (on programs (tools) or on specific version
of library) are needed to be added in Requires header.

This has nothing to do with BuildRequires.  Besides it worked without
libcurl in Requires, so it should continue to work without it,
isn't it?

-- 
Jakub Narebski
Poland
ShadeHawk on #git

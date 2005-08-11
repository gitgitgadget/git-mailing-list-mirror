From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Thu, 11 Aug 2005 16:44:57 +1200
Message-ID: <46a038f90508102144358a4bcf@mail.gmail.com>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net>
	 <7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net>
	 <7vacjsdcbj.fsf@assigned-by-dhcp.cox.net>
	 <7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net>
	 <pan.2005.08.10.21.15.41.143251@smurf.noris.de>
	 <pan.2005.08.10.22.11.25.242201@smurf.noris.de>
	 <46a038f9050810155642bb5580@mail.gmail.com>
	 <20050810233953.GV28270@kiste.smurf.noris.de>
	 <E1E33Zb-0004dT-Bx@highlab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 06:46:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E34xL-00035w-S7
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 06:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVHKEo7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 00:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbVHKEo7
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 00:44:59 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:52033 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932250AbVHKEo6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 00:44:58 -0400
Received: by rproxy.gmail.com with SMTP id i8so212282rne
        for <git@vger.kernel.org>; Wed, 10 Aug 2005 21:44:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=giV274S8s/342JH10WAPowlI676V3QHWBliHohGuj7vXL4Waf3ob/z3gl24K/Sxp9JQO3pY25S6msfaI0qBm7VlWp0m9RPml7m49ArVTSCkOmw+sU38slI0wRS3Kpxk5CwsZG7GEmIyUMKrRGiZ2uERlq0/fQDcNeas/do2Urds=
Received: by 10.38.75.11 with SMTP id x11mr313075rna;
        Wed, 10 Aug 2005 21:44:57 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Wed, 10 Aug 2005 21:44:57 -0700 (PDT)
To: Sebastian Kuzminsky <seb@highlab.com>
In-Reply-To: <E1E33Zb-0004dT-Bx@highlab.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 8/11/05, Sebastian Kuzminsky <seb@highlab.com> wrote:
> I agree completely - it's super bogus to rename the two central programs.
> It makes Debian essentially incompatible with the rest of the world.

Well, I doubt this problem lies with Debian. GNU Interactive Tools is
packaged for most (all?) distributions, and has been there for ages. A
quick google search shows a page tracking a few of its distributed
versions: http://linux.maruhn.com/sec/git.html

So it is fair to assume all distros are going to rename it, and wreak
havoc with the calls to the binaries from cogito, qgit, etc. Perhaps
it'd be better to rename the binaries within the git project. Better
Junio at it than a bunch of package maintainers... It'll also nullify
the risk of different packagers choosing different renaming
strategies.

cheers,


martin

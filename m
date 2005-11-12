From: Chris Wright <chrisw@osdl.org>
Subject: Re: git-core-arch: Missing dependency
Date: Fri, 11 Nov 2005 17:26:12 -0800
Message-ID: <20051112012612.GD5856@shell0.pdx.osdl.net>
References: <200511111446.jABEk6QM023362@pincoya.inf.utfsm.cl> <7vy83vnl7r.fsf@assigned-by-dhcp.cox.net> <4374E0EF.2020801@op5.se> <7vu0ejm30l.fsf@assigned-by-dhcp.cox.net> <43754083.4090501@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, Chris Wright <chrisw@osdl.org>
X-From: git-owner@vger.kernel.org Sat Nov 12 02:26:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EakA1-0005KN-Qr
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 02:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbVKLB0Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 20:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbVKLB0Y
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 20:26:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44772 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750821AbVKLB0X (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 20:26:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAC1QCnO005397
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 11 Nov 2005 17:26:12 -0800
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAC1QCRX007644;
	Fri, 11 Nov 2005 17:26:12 -0800
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id jAC1QC88007643;
	Fri, 11 Nov 2005 17:26:12 -0800
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <43754083.4090501@zytor.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11657>

* H. Peter Anvin (hpa@zytor.com) wrote:
> Junio C Hamano wrote:
> >Andreas Ericsson <ae@op5.se> writes:
> >>Just to be anal;
> >>Requires doesn't usually include the %release,...
> >
> >Obviously both you and Chris (who did the part you are quoting
> >for us) know RPM spec a lot better than I do, and I see two
> >experts contradicting with each other.  It could have been just
> >an oversight, or it might have done deliberately --- I cannot
> >judge myself, so I punt here.  I'll remove "-%{release}" when I
> >hear Chris says he agrees with you.
> 
> You can do it either way.  It's a matter of the strictness of the 
> binding.  If you put %{version} there, then it has to come from the same 
> upstream release; for %{version}-%{release} it has to come from the same 
> SRPM, i.e. usually from the same build.
> 
> In this case I think %{version}-%{release} is appropriate.

Yeah, I was being conservative.  In reality, the release is rarely
bumped, so it's probably not critical either way.

thanks,
-chris

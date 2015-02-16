From: Dave Olszewski <cxreg@pobox.com>
Subject: Re: Re: [PATCH] push: allow --follow-tags' to be set by config
 push.followTags
Date: Sun, 15 Feb 2015 19:01:16 -0800 (PST)
Message-ID: <alpine.DEB.2.11.1502151859230.16979@narbuckle.genericorp.net>
References: <1424043588-15994-1-git-send-email-cxreg@pobox.com> <CAPc5daXkf3Vc-kGsqQ4zo6qSMrh93GZbXeFK9oLwajyNahmx1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 04:13:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNC7t-0003fR-FF
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 04:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbbBPDNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2015 22:13:32 -0500
Received: from 63.f9.1243.static.theplanet.com ([67.18.249.99]:33976 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751677AbbBPDNc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Feb 2015 22:13:32 -0500
X-Greylist: delayed 734 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Feb 2015 22:13:32 EST
X-Envelope-From: cxreg@pobox.com
Received: from localhost (count@narbuckle [127.0.0.1])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.14.4/8.14.4/Debian-8) with ESMTP id t1G31Gb3012122
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 15 Feb 2015 21:01:16 -0600
X-X-Sender: count@narbuckle.genericorp.net
In-Reply-To: <CAPc5daXkf3Vc-kGsqQ4zo6qSMrh93GZbXeFK9oLwajyNahmx1Q@mail.gmail.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263867>

On Sun, 15 Feb 2015, Junio C Hamano wrote:

> On Sun, Feb 15, 2015 at 3:39 PM, Dave Olszewski <cxreg@pobox.com> wrote:
> > Signed-off-by: Dave Olszewski <cxreg@pobox.com>
> >
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index ae6791d..cdb8a99 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -2079,6 +2079,9 @@ new default).
> >
> >  --
> >
> > +push.followTags::
> > +       If set to true enable '--follow-tags' option by default.
> > +
> 
> After setting this in your repository, does "git push --no-follow-tags" let
> you override it if you want to do so for a single invocation?
> 
> If it does, the code is good but it should be documented here; if it
> does not, it should be corrected and it should be documented here.
> 
> Thanks.

Thanks for the feedback.  I was able to get this behavior by setting the
config value into the flags variable before parsing command line
options.  Hopefully this is acceptable practice.  Updated patch coming
shortly

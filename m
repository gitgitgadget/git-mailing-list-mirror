From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Better document the original repository layout.
Date: Fri, 4 Dec 2009 17:51:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912041751150.21557@intel-tinevez-2-302>
References: <cover.1259934977.git.mhagger@alum.mit.edu> <91462ec5e4409e558ec5158b7dea33ebf0081d3e.1259934977.git.mhagger@alum.mit.edu> <4B192210.908@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	gitster@pobox.com
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Dec 04 17:51:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGbNi-0004Ty-UB
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 17:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbZLDQvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 11:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756731AbZLDQvd
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 11:51:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:57872 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756648AbZLDQvc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 11:51:32 -0500
Received: (qmail invoked by alias); 04 Dec 2009 16:51:38 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp072) with SMTP; 04 Dec 2009 17:51:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18qGHRMQSgqnMQPPLFMbzkwq3Wdq/Pp09mFcElroV
	Y+0AxaGIqc6k5b
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4B192210.908@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134535>

Hi,

On Fri, 4 Dec 2009, Michael J Gruber wrote:

> Michael Haggerty venit, vidit, dixit 04.12.2009 15:36:
> > Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> > ---
> >  t/t3404-rebase-interactive.sh |    9 +++++----
> >  1 files changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> > index 3a37793..073674f 100755
> > --- a/t/t3404-rebase-interactive.sh
> > +++ b/t/t3404-rebase-interactive.sh
> > @@ -16,13 +16,14 @@ set_fake_editor
> >  
> >  # set up two branches like this:
> >  #
> > -# A - B - C - D - E
> > +# A - B - C - D - E     (master)
> >  #   \
> > -#     F - G - H
> > +#     F - G - H         (branch1)
> >  #       \
> > -#         I
> > +#         I             (branch2)
> >  #
> > -# where B, D and G touch the same file.
> > +# where B, D and G touch the same file.  In addition, set tags at
> > +# points A, F, and I.
> >  
> >  test_expect_success 'setup' '
> >  	: > file1 &&
> 
> My first reaction to the subject was "Huh? What repository?". So I
> suggest something like
> 
> t3404: Better document the original repository layout
> 
> as a more descriptive subject.

That would be good, the patch itself is already good.

ACK

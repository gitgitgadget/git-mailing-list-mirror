From: Al Boldi <a1426z@gawab.com>
Subject: Re: git guidance
Date: Wed, 28 Nov 2007 20:14:27 +0300
Message-ID: <200711282014.27299.a1426z@gawab.com>
References: <20071127235237.GF15227@1wt.eu> <474D70DD.4020601@dawes.za.net> <Pine.LNX.4.64.0711281545170.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 18:36:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxQqH-0001TX-EF
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 18:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759573AbXK1Rf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 12:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755000AbXK1Rf7
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 12:35:59 -0500
Received: from [212.12.190.45] ([212.12.190.45]:36063 "EHLO raad.intranet"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751586AbXK1Rf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 12:35:58 -0500
X-Greylist: delayed 17116 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Nov 2007 12:35:56 EST
Received: from localhost ([10.0.0.111])
	by raad.intranet (8.8.7/8.8.7) with ESMTP id UAA29903;
	Wed, 28 Nov 2007 20:35:33 +0300
User-Agent: KMail/1.5
In-Reply-To: <Pine.LNX.4.64.0711281545170.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66393>

Johannes Schindelin wrote:
> Hi,

Hi!

git@vger sometimes bounces, so let's leave lkml as backup.

> On Wed, 28 Nov 2007, Rogan Dawes wrote:
> > Al Boldi wrote:
> > > Willy Tarreau wrote:
> > > > It should not turn into an endless thread led by people who want to
> > > > redefine GIT's roadmap, but experience sharing helps a lot with GIT.
> > >
> > > Well, now that you mentioned it, if there is one thing I dislike, it's
> > > for version control to start mutilating your sources.  Version Control
> > > should be completely transparent.  GIT isn't.
> >
> > Care to explain? Git is quite happy handling arbitrary binary content,
> > so I find it difficult to believe that it is changing your source code
> > in strange ways.
>
> It is nice of you to ask him to explain: Unless this handwaving claim is
> substantiated, it is quite hard to argue with.

Sure, the problem with GIT is that it stores the sources inside a backend 
container that is only accessible via GIT; iow, you can't retrieve your 
sources directly / transparently.

One way to achieve transparency could be to allow mounting GIT on a dir-mount 
point.  And just use that dir normally, while GIT manages all the rest in 
the background.


Thanks!

--
Al

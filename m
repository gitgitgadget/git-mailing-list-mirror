From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/2] git-svn: don't append extra newlines at the end of commit messages.
Date: Sat, 14 Jun 2008 10:43:56 +0200
Message-ID: <20080614084356.GA14282@diana.vm.bytemark.co.uk>
References: <1213312251-8081-1-git-send-email-apenwarr@gmail.com> <48522055.6060006@op5.se> <20080613080949.GA26817@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Jun 14 10:45:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7RNl-0004PI-Bv
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 10:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbYFNIoQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jun 2008 04:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754145AbYFNIoP
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 04:44:15 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1771 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095AbYFNIoP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 04:44:15 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K7RMa-0003kA-00; Sat, 14 Jun 2008 09:43:56 +0100
Content-Disposition: inline
In-Reply-To: <20080613080949.GA26817@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84990>

On 2008-06-13 10:09:49 +0200, Karl Hasselstr=F6m wrote:

> On 2008-06-13 09:23:01 +0200, Andreas Ericsson wrote:
>
> > Are you proposing to remove extra whitespace from git commits when
> > they are sent back to svn via dcommit? If so, wouldn't it be
> > better to always strip extra newlines when importing from svn so
> > they're never there in the first place?
>
> That's what the patch does, unless I'm misreading it.

As has been realized elsewhere in this thread, I was misreading it.
:-P

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

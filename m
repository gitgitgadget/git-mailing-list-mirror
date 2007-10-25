From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Thu, 25 Oct 2007 16:51:32 +0200
Message-ID: <20071025145132.GA31196@diana.vm.bytemark.co.uk>
References: <20071024203335.GJ29830@fieldses.org> <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx> <471FBF29.8030802@op5.se> <Pine.LNX.4.64.0710242315310.25221@racer.site> <47204ECA.7040309@op5.se> <Pine.LNX.4.64.0710251108330.25221@racer.site> <47206EC3.5000002@op5.se> <Pine.LNX.4.64.0710251232370.25221@racer.site> <4720903E.1070103@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Baumann <waste.manager@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 25 16:52:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il44j-00041F-CA
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 16:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758251AbXJYOwb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Oct 2007 10:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754298AbXJYOwb
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 10:52:31 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3067 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758069AbXJYOwb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 10:52:31 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Il43a-00088j-00; Thu, 25 Oct 2007 15:51:34 +0100
Content-Disposition: inline
In-Reply-To: <4720903E.1070103@op5.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62322>

On 2007-10-25 14:46:54 +0200, Andreas Ericsson wrote:

> error: The branch 'next' is not a strict subset of your current
> HEAD. If you are sure you want to delete it, run 'git branch -D
> next'.
>
> So you want me to tell all the developers they should use "git
> branch -D maint" instead, so they can bypass the built-in security
> checks? No thanks.

Maybe the solution here is to let "git branch -d" succeed if the
branch is a subset of HEAD or the branch it is tracking? That way,
deleting would succeed if upstream has all your commits.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

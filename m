From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/4] Allow e-mails to be sent with the Unix sendmail tool
Date: Tue, 15 Jul 2008 14:34:32 +0200
Message-ID: <20080715123432.GB17008@diana.vm.bytemark.co.uk>
References: <20080713113853.18845.37686.stgit@localhost.localdomain> <20080713114026.18845.77979.stgit@localhost.localdomain> <20080715122203.GN25448@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
X-From: git-owner@vger.kernel.org Tue Jul 15 14:36:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIjkx-0002Xj-US
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 14:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756316AbYGOMet convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jul 2008 08:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756078AbYGOMet
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 08:34:49 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4220 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509AbYGOMes (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 08:34:48 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KIjjk-0004Tv-00; Tue, 15 Jul 2008 13:34:32 +0100
Content-Disposition: inline
In-Reply-To: <20080715122203.GN25448@sirena.org.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88554>

On 2008-07-15 13:22:20 +0100, Mark Brown wrote:

> On Sun, Jul 13, 2008 at 12:40:26PM +0100, Catalin Marinas wrote:
>
> > If the stgit.smtpserver configuration option does not have a
> > host:port format, it is assumed to be an external tool. For
> > example, to use sendmail just set this variable to
> > "/usr/sbin/sendmail -t -i" (see the examples/gitconfig file).
>
> I'd really expect to be able to just specify the hostname alone if
> using the standard SMTP port. Perhaps checking for a / in the server
> might be less surprising?

This is actually what the code does, and what the documentation claims
it should do. It's just the commit message that's confused. Catalin?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

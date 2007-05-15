From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT RFC PATCH] Activate rename detection by default.
Date: Tue, 15 May 2007 20:47:59 +0200
Message-ID: <20070515184759.GC17851@diana.vm.bytemark.co.uk>
References: <20070504235413.29479.13640.stgit@gandelf.nowhere.earth> <b0943d9e0705150841l6fe05baajab67a16eb78e411d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 20:54:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho2AA-0004LV-88
	for gcvg-git@gmane.org; Tue, 15 May 2007 20:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756146AbXEOSxv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 14:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756019AbXEOSxv
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 14:53:51 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4873 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553AbXEOSxv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 14:53:51 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Ho240-0004kl-00; Tue, 15 May 2007 19:48:00 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0705150841l6fe05baajab67a16eb78e411d@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47365>

On 2007-05-15 16:41:47 +0100, Catalin Marinas wrote:

> On 05/05/07, Yann Dirson <ydirson@altern.org> wrote:
>
> > This patch uses -M when generating diffs, which then looks fine,
> > just like any other git-generated diff.
>
> I think we should only use -M for "files", "status", "show", "diff"
> but not for "export" and "mail", maybe by adding an extra parameter
> to git.diff() (or we could have this configurable or with an cmd
> line option). The reason is that I send patches that might not be
> applied with GIT.

Seems like a good idea to me: default to -M whenever the consumer is
guaranteed to understand it, and have it as an option defaulting to
off when we export data.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/2] Break Python 2.3 compatibility
Date: Mon, 03 Sep 2007 23:48:38 +0200
Message-ID: <20070903214545.18057.79301.stgit@yoghurt>
References: <b0943d9e0709030136y4f1f241cge28fb9607ec559c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 23:48:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISJms-0007vV-3s
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 23:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805AbXICVsp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 3 Sep 2007 17:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753878AbXICVsp
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 17:48:45 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2696 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbXICVso (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 17:48:44 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1ISJmh-0004Jh-00; Mon, 03 Sep 2007 22:48:39 +0100
In-Reply-To: <b0943d9e0709030136y4f1f241cge28fb9607ec559c1@mail.gmail.com>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57506>

On 2007-09-03 09:36:26 +0100, Catalin Marinas wrote:

> On 29/08/07, Karl Hasselstr=C3=B6m <kha@treskal.com> wrote:
>
> > Any chance we can drop Python 2.3 support any time soon, by the
> > way? I've confined all the ickyness to one place, but it would
> > still be good to get rid of it (not to mention being able to use
> > sets and generator expressions).
>=20
> Unless there is no objection, I'm actually OK with this. Feel free
> to break the 2.3 support from now on. I'll add a note stating the
> minimum versions for Python and GIT in the 0.14 release.

And here it is. We actually used sets in much fewer places than I
thought -- but then again, there are a number of places where we ought
to be using them but aren't.

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle

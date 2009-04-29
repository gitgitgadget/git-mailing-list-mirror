From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 7/9] Reinstate the --annotate option for refresh
Date: Wed, 29 Apr 2009 08:33:09 +0200
Message-ID: <20090429063309.GG18483@diana.vm.bytemark.co.uk>
References: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com> <20090428151014.27261.18502.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 08:33:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz3MA-0004f1-AD
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 08:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbZD2GdN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 02:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbZD2GdN
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 02:33:13 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:47034 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbZD2GdN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 02:33:13 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Lz3Lx-0004xH-00; Wed, 29 Apr 2009 07:33:09 +0100
Content-Disposition: inline
In-Reply-To: <20090428151014.27261.18502.stgit@pc1117.cambridge.arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117854>

On 2009-04-28 16:10:14 +0100, Catalin Marinas wrote:

> It is sometimes useful to add some notes to the log entry when a
> patch was refreshed. This option was dropped when the command was
> updated to the new infrastructure as there was no logging support at
> that time.

It looks like if you get a conflict during the refresh (such as when
doing refresh -p, and we can't reorder the patches) the annotation
will be dropped. That could presumably be fixed by tacking it on to
the log message for the creation of the temp patch as well.

But I don't know if it's that important. I've never felt the need for
this feature myself.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

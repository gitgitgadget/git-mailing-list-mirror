From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 8/9] Add the log --clear option
Date: Wed, 29 Apr 2009 08:35:39 +0200
Message-ID: <20090429063539.GH18483@diana.vm.bytemark.co.uk>
References: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com> <20090428151020.27261.27456.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 08:35:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz3OW-0005VR-73
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 08:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbZD2Gfk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 02:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbZD2Gfk
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 02:35:40 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:47036 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbZD2Gfj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 02:35:39 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Lz3ON-0004yH-00; Wed, 29 Apr 2009 07:35:39 +0100
Content-Disposition: inline
In-Reply-To: <20090428151020.27261.27456.stgit@pc1117.cambridge.arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117856>

On 2009-04-28 16:10:20 +0100, Catalin Marinas wrote:

> This option allows the clearing of the log history which sometimes
> may get too large.

Wow, I didn't realize we already had all the pieces for doing this.

Of course, what we'd _really_ want is to delete the log except for the
last N days, or the last N entries. :-) That's gonna be a bit more
work, though, and this is an excellent step in the right direction.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

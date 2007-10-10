From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 09/13] Clear up the semantics of Series.new_patch
Date: Wed, 10 Oct 2007 10:15:58 +0200
Message-ID: <20071010081558.GD12970@diana.vm.bytemark.co.uk>
References: <20070914222819.7001.55921.stgit@morpheus.local> <20070914223154.7001.12254.stgit@morpheus.local> <b0943d9e0710080616r36142946m3e24d2f6893287c9@mail.gmail.com> <20071008132524.GA11253@diana.vm.bytemark.co.uk> <b0943d9e0710091401s280b3a12md9e700fb3ae007bf@mail.gmail.com> <20071010074517.GC12970@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 10:16:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfWjr-0007Co-BW
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 10:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbXJJIQG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2007 04:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752416AbXJJIQF
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 04:16:05 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3656 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbXJJIQE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 04:16:04 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IfWjW-0003YE-00; Wed, 10 Oct 2007 09:15:58 +0100
Content-Disposition: inline
In-Reply-To: <20071010074517.GC12970@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60480>

On 2007-10-10 09:45:17 +0200, Karl Hasselstr=F6m wrote:

> On 2007-10-09 22:01:44 +0100, Catalin Marinas wrote:
>
> > Series.new_patch already creates a commit, why should we move the
> > functionality to 'pick'?
>
> I didn't say that. :-) You could accomplish the commit creation by
> calling Series.new_patch if you like.

Ummm ... which was presumably the case already, and broke because of
the new assertion. Just ignore me. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

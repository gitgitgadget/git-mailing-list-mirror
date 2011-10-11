From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] commit: teach --gpg-sign option
Date: Tue, 11 Oct 2011 00:38:53 +0000
Message-ID: <robbat2-20111011T003728-410722439Z@orbis-terrarum.net>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org>
 <robbat2-20111006T221637-481195848Z@orbis-terrarum.net>
 <4E8EBAFE.8020805@drmicha.warpmail.net>
 <robbat2-20111009T225253-591026811Z@orbis-terrarum.net>
 <7vmxd9pxd2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "	Robin H. Johnson" <robbat2@gentoo.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 11 02:39:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDQN2-0006hD-J2
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 02:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974Ab1JKAiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 20:38:55 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:56787 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753952Ab1JKAiz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 20:38:55 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id B1E681B400E
	for <git@vger.kernel.org>; Tue, 11 Oct 2011 00:38:54 +0000 (UTC)
Received: (qmail 11305 invoked by uid 10000); 11 Oct 2011 00:38:53 -0000
Content-Disposition: inline
In-Reply-To: <7vmxd9pxd2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183278>

On Sun, Oct 09, 2011 at 04:18:49PM -0700,  Junio C Hamano wrote:
> "Robin H. Johnson" <robbat2@gentoo.org> writes:
> > Workflow example:
> > 1. Dev1 creates a commit, signs it, pushes to central repo.
> > 2. Dev2 pulls, signs the tip commit, pushes it back.
> 
> I personally am not sympathetic to such a "sign every and all commits by
> multiple people" workflow. If you really want to do such a thing, you can
> have the second and subsequent one to create a new commit on top whose
> sole purpose is to hold such a signature (commit --allow-empty --gpg-sig),
> or use signed tags.
For this case, I think having the push certificates works much better.

No easy solution to all of this, just lots of yak-shaving :-(.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

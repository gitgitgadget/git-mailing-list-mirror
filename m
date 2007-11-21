From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Added test case for stg refresh
Date: Thu, 22 Nov 2007 00:55:34 +0100
Message-ID: <20071121235534.GA21008@diana.vm.bytemark.co.uk>
References: <87tznfvqb4.fsf@lysator.liu.se> <87oddnvpzf.fsf@virtutech.se> <20071121231553.GA19422@diana.vm.bytemark.co.uk> <b0943d9e0711211531v2f7b9c0bl99033c0bd58971c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <david@virtutech.se>,
	Git Mailing List <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 00:55:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuzQD-00026H-V0
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 00:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbXKUXzk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Nov 2007 18:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752993AbXKUXzk
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 18:55:40 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1288 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846AbXKUXzk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 18:55:40 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IuzPq-0005VM-00; Wed, 21 Nov 2007 23:55:34 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0711211531v2f7b9c0bl99033c0bd58971c7@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65715>

On 2007-11-21 23:31:45 +0000, Catalin Marinas wrote:

> I noticed the weirdness few days ago and fixed it in
> e8813959aa3a7c41ffef61d06068b10519bd4830 (though no test caught it).
> Do you still see problems after this commit?

Confirmed: the test fails before e8813959, and succeeds afterwards.

(You can pull the test from

  git://repo.or.cz/stgit/kha.git safe

if you like.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 2/4] Add automatic git-mergetool invocation to the new infrastructure
Date: Tue, 17 Mar 2009 16:30:52 +0100
Message-ID: <20090317153052.GC10001@diana.vm.bytemark.co.uk>
References: <20090317110721.27748.10295.stgit@pc1117.cambridge.arm.com> <20090317110858.27748.21534.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 16:33:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjbHk-0001pV-HB
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 16:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756272AbZCQPa4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2009 11:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756162AbZCQPaz
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 11:30:55 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:46253 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755940AbZCQPay (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 11:30:54 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LjbFk-0003JF-00; Tue, 17 Mar 2009 15:30:52 +0000
Content-Disposition: inline
In-Reply-To: <20090317110858.27748.21534.stgit@pc1117.cambridge.arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113482>

On 2009-03-17 11:08:58 +0000, Catalin Marinas wrote:

> This patch adds the IndexAndWorktree.mergetool() function
> responsible for calling 'git mergetool' to interactively solve
> conflicts. The function may also be called from
> IndexAndWorktree.merge() if the standard 'git merge-recursive' fails
> and 'interactive =3D=3D True'. The 'allow_interactive' parameter is
> passed to Transaction.push_patch() from the functions allowing
> interactive merging.

Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

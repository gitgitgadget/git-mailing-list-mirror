From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Check for local changes with "goto"
Date: Thu, 15 Jan 2009 09:37:00 +0100
Message-ID: <20090115083700.GB24890@diana.vm.bytemark.co.uk>
References: <20090114225945.11098.88671.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 09:38:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNNkE-0008MA-Qb
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 09:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883AbZAOIhG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 03:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754021AbZAOIhG
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 03:37:06 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2281 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583AbZAOIhE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 03:37:04 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LNNim-0006aM-00; Thu, 15 Jan 2009 08:37:00 +0000
Content-Disposition: inline
In-Reply-To: <20090114225945.11098.88671.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105774>

I'm not opposed to the change as such (even if I personally think it's
very convenient to allow operations like goto if the local changes
don't touch the same files), but ...

On 2009-01-14 22:59:45 +0000, Catalin Marinas wrote:

>  stgit/commands/common.py  |    7 +++++++
>  stgit/commands/goto.py    |    8 +++++++-

=2E.. are you sure it wouldn't be better to build the check into
transaction.py, so that all new-infrastructure command would share it?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Minor bug in 'stg edit' ?
Date: Thu, 28 Feb 2008 10:41:07 +0100
Message-ID: <20080228094107.GB28085@diana.vm.bytemark.co.uk>
References: <20080227224756.GK2222@TopQuark.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: Paul Donohue <stgit-bug@TopQuark.net>
X-From: git-owner@vger.kernel.org Thu Feb 28 10:42:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUfH6-0000N3-Sa
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 10:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754428AbYB1JlY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Feb 2008 04:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753853AbYB1JlY
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 04:41:24 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4292 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781AbYB1JlX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 04:41:23 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JUfGF-0007lw-00; Thu, 28 Feb 2008 09:41:07 +0000
Content-Disposition: inline
In-Reply-To: <20080227224756.GK2222@TopQuark.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75373>

On 2008-02-27 17:47:57 -0500, Paul Donohue wrote:

> After running 'stg edit', the file '.stgit-edit.txt' is always left
> behind. Is this supposed to happen? I would have assumed the file
> would be automatically removed after the changes were committed.

Yes, I'd say that's a bug.

> I'm running StGIT 0.14.1.

The bug is gone in the master branch (at least as far as I can tell);
it probably disappeared when stg edit was switched to the new
infrastructure.

> Thanks!

Thanks for the bug report.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

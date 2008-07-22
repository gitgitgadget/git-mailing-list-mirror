From: Petr Baudis <pasky@suse.cz>
Subject: Re: Q: how to remove or move submodules?
Date: Wed, 23 Jul 2008 01:22:40 +0200
Message-ID: <20080722232240.GL32184@machine.or.cz>
References: <fc113d400807122338o637cc159n5e19fea5a15dc866@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rob Sanheim <rsanheim@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 01:24:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLRD5-0008SF-6D
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 01:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758048AbYGVXWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 19:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758047AbYGVXWn
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 19:22:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36695 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758036AbYGVXWm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 19:22:42 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 36476393B489; Wed, 23 Jul 2008 01:22:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fc113d400807122338o637cc159n5e19fea5a15dc866@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89562>

  Hi,

On Sun, Jul 13, 2008 at 02:38:51AM -0400, Rob Sanheim wrote:
> I don't see any info on what the 'right' way is to delete or move
> submodules around in any of the docs.  Normally I end up just hacking
> my way through it and hand modifying the .gitmodules file, but this
> seems wrong.  Is there a recommended way?

  currently, you have to hand-modify the .gitmodules file, then remove
the directory from the working tree and then from the index. In part
inspired by your question, I have submitted patches to add git mv and
git rm support for submodules some time ago, but they probably won't
make it to 1.6.0.

				Petr "Pasky" Baudis

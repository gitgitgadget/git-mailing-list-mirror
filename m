From: Petr Baudis <pasky@suse.cz>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 21 Jul 2008 00:40:40 +0200
Message-ID: <20080720224040.GG32184@machine.or.cz>
References: <7vod5kd3im.fsf@gitster.siamese.dyndns.org> <7v3amv1e8n.fsf@gitster.siamese.dyndns.org> <7vprpwhp7t.fsf@gitster.siamese.dyndns.org> <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org> <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org> <7vabgqsc37.fsf@gitster.siamese.dyndns.org> <7vtzetjbif.fsf@gitster.siamese.dyndns.org> <7vfxqawlja.fsf@gitster.siamese.dyndns.org> <7vlk01hqzz.fsf@gitster.siamese.dyndns.org> <7v3am5iae8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 00:41:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKhbA-0007Ib-En
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 00:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbYGTWkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 18:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752197AbYGTWkn
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 18:40:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40681 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbYGTWkl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 18:40:41 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4ACA9393B31D; Mon, 21 Jul 2008 00:40:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v3am5iae8.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89252>

On Sat, Jul 19, 2008 at 06:58:55PM -0700, Junio C Hamano wrote:
> * pb/submodule (Wed Jul 16 21:11:40 2008 +0200) 7 commits
>  . t7403: Submodule git mv, git rm testsuite
>  . git rm: Support for removing submodules
>  . git mv: Support moving submodules
>  . submodule.*: Introduce simple C interface for submodule lookup by
>    path
>  . git submodule add: Fix naming clash handling
>  . t7400: Add short "git submodule add" testsuite
>  . git-mv: Remove dead code branch
> 
> Long overdue usability improvement series for submodule.  Very much
> welcomed.  It would be nice to have some submodule improvements in 1.6.0,
> but it would take us a few more rounds to hit 'next' with this, and it
> will not be in 'master' when 1.6.0 ships.

Do you think this would create serious problems?

One thing this patch series depends on now is changing the git mv
semantics in a rather non-trivial way, which is something we might want
to do in a major release instead of within the 1.6 series.

				Petr "Pasky" Baudis

From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Documentation/gitignore.txt: Clarify gitignore vs
	tracked files
Date: Thu, 17 Jul 2008 20:26:19 +0200
Message-ID: <20080717182619.GG10151@machine.or.cz>
References: <20080717163622.12592.29919.stgit@localhost> <7vabgggyuc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 20:27:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJYCM-00085y-NC
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 20:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760195AbYGQS0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 14:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756566AbYGQS0V
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 14:26:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42402 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758248AbYGQS0U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 14:26:20 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 653B02C4C026; Thu, 17 Jul 2008 20:26:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vabgggyuc.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88898>

  Hi,

On Thu, Jul 17, 2008 at 11:16:59AM -0700, Junio C Hamano wrote:
> I'd suggest dropping everything after ';'.

  I think the part after ';' is the main benefit of this patch,
actually. Without suggesting an alternative, the users are left puzzled
"so how do I do that?"

>  - If you want to keep local changes without ever checking in, you can do
>    so by making partial commits.

  Yes, that's a rather obvious solution but the user probably wants
something nicer than that if he starts looking already.

>  - You could mark these paths "assume unchanged".

  I really think this is worth mentioning in the gitignore manpage;
it is not _directly_ on-topic, but there is no other obvious place where
to teach users about it and all the interested people will check the
gitignore manpage first. Perhaps a small section at the end might be
acceptable? ;-)

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce

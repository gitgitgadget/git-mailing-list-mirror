From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Git.pm: Fix internal git_command_bidi_pipe() users
Date: Mon, 4 Aug 2008 10:21:17 +0200
Message-ID: <20080804082117.GI10151@machine.or.cz>
References: <be6fef0d0808032149p651309a8o773dca5f16923ee1@mail.gmail.com> <20080804075313.21325.28396.stgit@localhost> <7vtze12oij.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, ams@toroid.org
X-From: git-owner@vger.kernel.org Mon Aug 04 10:23:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPvLz-0003Gh-Ga
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 10:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbYHDIVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 04:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbYHDIVT
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 04:21:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51672 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054AbYHDIVT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 04:21:19 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 76264393B31F; Mon,  4 Aug 2008 10:21:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vtze12oij.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91327>

On Mon, Aug 04, 2008 at 01:05:56AM -0700, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > The hash_and_insert_object() and cat_blob() helpers were using
> > an incorrect slice-from-ref Perl syntax. This patch fixes that up
> > in the _close_*() helpers and make the _open_*() helpers use the
> > same syntax for consistnecy.
> >
> > Signed-off-by: Petr Baudis <pasky@suse.cz>
> > ---
> >
> >   Wow, the command_bidi_pipe API really is dirty. Of course, it is
> > my fault as anyone's since I didn't get around to review the patches
> > introducing it.
> 
> Sorry, delete is still broken with your patch, isn't it?

Oh, right - I forgot that one and it didn't occur to me to test this
part.

> The earlier patch from Abhijit Menon-Sen does this properly for
> close_hash_and_insert and close_cat_blob, which I've queued already.

Abhijit, can you please tag your Git.pm patches so that I actually have
a chance to see and review it?

Thanks,

				Petr "Pasky" Baudis

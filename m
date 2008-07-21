From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Add a notice to the doc of git-ls-tree.
Date: Mon, 21 Jul 2008 09:47:28 +0200
Message-ID: <20080721074728.GM10151@machine.or.cz>
References: <1216592735-23789-1-git-send-email-code@istique.net> <20080720230846.GH32184@machine.or.cz> <7vy73w16nj.fsf@gitster.siamese.dyndns.org> <7vtzek15b5.fsf@gitster.siamese.dyndns.org> <20080721000824.GI10151@machine.or.cz> <7vljzw14br.fsf@gitster.siamese.dyndns.org> <20080721002248.GJ10151@machine.or.cz> <7vljzvyi5w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steve =?iso-8859-2?Q?Fr=E9cinaux?= <code@istique.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 09:48:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKq8E-0007yo-Ap
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 09:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbYGUHrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 03:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbYGUHrb
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 03:47:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51998 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753321AbYGUHra (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 03:47:30 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 9598C393B300; Mon, 21 Jul 2008 09:47:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vljzvyi5w.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89316>

On Sun, Jul 20, 2008 at 09:28:59PM -0700, Junio C Hamano wrote:
> Sorry, I may have been unclear.  I meant "showing relative to tree-root,
> unlike showing relative to cwd like we have done forever".
> 
> Changing the behaviour would affect usage like this:
> 
> 	$ cd some/where
>         $ git ls-files
>         $ git ls-tree --name-only -r HEAD^
> 
>     cf. http://thread.gmane.org/gmane.comp.version-control.git/13028/focus=13080

  Yes, as I said, by now I agree that this is not acceptable, and thus
opted for just documenting the behaviour. :-)

				Petr "Pasky" Baudis

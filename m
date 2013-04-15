From: John Keeping <john@keeping.me.uk>
Subject: Re: Ensimag students projects, version 2013
Date: Mon, 15 Apr 2013 10:41:13 +0100
Message-ID: <20130415094113.GC2278@serenity.lan>
References: <vpqobdg515m.fsf@grenoble-inp.fr>
 <87r4iccgdw.fsf@linux-k42r.v.cablecom.net>
 <vpqvc7oqh8a.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 15 11:41:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URfuo-00016C-Ax
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 11:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463Ab3DOJla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 05:41:30 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:56806 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168Ab3DOJl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 05:41:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id DD74C60656E;
	Mon, 15 Apr 2013 10:41:28 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id de6Ycbl9N4z3; Mon, 15 Apr 2013 10:41:27 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id D96C960656D;
	Mon, 15 Apr 2013 10:41:26 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 7890B161E1B6;
	Mon, 15 Apr 2013 10:41:24 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rem06IE37SEO; Mon, 15 Apr 2013 10:41:22 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 2DF37161E42F;
	Mon, 15 Apr 2013 10:41:15 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <vpqvc7oqh8a.fsf@grenoble-inp.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221211>

On Mon, Apr 15, 2013 at 11:24:21AM +0200, Matthieu Moy wrote:
> Thomas Rast <trast@inf.ethz.ch> writes:
> > * Allow git send-email --cc 'foo@example.com, bar@example.com' instead
> >   of git send-email --cc foo@example.com --cc bar@example.com
> >
> >   That would be really nice.  Bonus points if it handles continuation
> >   lines etc. correctly, so that it's even easier to paste.
> 
> Added to the wiki too.

As an extension to this, it would be really nice if I could say "git
send-email --reply-to <file>", feeding it an existing message.  This
would set "To" and "Cc" appropriately but also quote the existing
message for me to reply to, either into the cover letter or after the
"---" in the patch (it's probably an error if there's no cover letter
and more than one patch in this mode).

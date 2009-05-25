From: Johan Herland <johan@herland.net>
Subject: Re: git submodule update --merge
Date: Tue, 26 May 2009 00:10:37 +0200
Message-ID: <200905260010.37454.johan@herland.net>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org>
 <200905251359.37619.johan@herland.net>
 <7vmy91vxqc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	markus.heidelberg@web.de, Peter Hutterer <peter.hutterer@who-t.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 26 00:11:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8iNx-0004fh-7T
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 00:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbZEYWKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 18:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbZEYWKm
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 18:10:42 -0400
Received: from mx.getmail.no ([84.208.15.66]:41776 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751519AbZEYWKm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 18:10:42 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KK800EFV09TKMD0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 26 May 2009 00:10:41 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KK800KNB09PPS90@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 26 May 2009 00:10:41 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.5.25.214352
User-Agent: KMail/1.11.3 (Linux/2.6.29-ARCH; KDE/4.2.3; x86_64; ; )
In-reply-to: <7vmy91vxqc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119970>

On Monday 25 May 2009, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > I haven't received any replies to my attempt to describe the context in
> > which "git submodule update --merge" is useful. A hint as to whether my
> > argument is valid, or just crap, would be nice.
>
> FWIW, I didn't find "rebase makes sense but merge doesn't" argument very
> convincing to begin with.  Because the configuration variable is about
> "update" action, I agree it makes sense to do
>
> >   submodule.<name>.update = checkout/rebase (checkout if unset)
>
> from the UI standpoint.
>
> I do not know what the sensible repertoire of options nor what the
> default should be, though.  That's up to the submodule using people to
> sort out.

I suggest the default should be whatever "git submodule update" does today, 
which is what I've called 'checkout' above (i.e. it simply checks out the 
submodule commit, which naturally detaches the head).

If you prefer, I can split my previous patch in two; one that fixes the 
config variable, and one that adds "submodule update --merge", so that they 
can be evaluated separately. Hmm?


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

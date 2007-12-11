From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Brown paper bag fix to previous send-email change
Date: Tue, 11 Dec 2007 08:44:28 +0100
Organization: glandium.org
Message-ID: <20071211074427.GA12959@glandium.org>
References: <1197356116-12176-1-git-send-email-mh@glandium.org> <7v3au9hfuj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 08:44:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1znR-00073n-Sr
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 08:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbXLKHoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 02:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbXLKHoa
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 02:44:30 -0500
Received: from smtp28.orange.fr ([80.12.242.100]:2158 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbXLKHo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 02:44:29 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2807.orange.fr (SMTP Server) with ESMTP id B9D788000046
	for <git@vger.kernel.org>; Tue, 11 Dec 2007 08:44:28 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf2807.orange.fr (SMTP Server) with ESMTP id 9BA4080000BD;
	Tue, 11 Dec 2007 08:44:28 +0100 (CET)
X-ME-UUID: 20071211074428637.9BA4080000BD@mwinf2807.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J1zn2-0003RV-66; Tue, 11 Dec 2007 08:44:28 +0100
Content-Disposition: inline
In-Reply-To: <7v3au9hfuj.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67819>

On Mon, Dec 10, 2007 at 11:04:36PM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > My previous change led to the In-Reply-To header being <> when the given
> > value was empty. This fixes it.
> >
> > Signed-off-by: Mike Hommey <mh@glandium.org>
> > ---
> >
> >  I think I have an antispam problem somewhere with this patch, because even
> >  keeping sending it, it never reached the list. And Junio didn't answer to my
> >  private message about it, so I guess that was some server being smart with
> >  the subject line. *sigh*
> >
> >  PS: sorry Junio if you get this patch multiple time.
> 
> No, I happened to have noticed the same and have an almost identical fix
> (I said "defined $initial_reply_to") already queued in my tree.

Testing "defined $initial_reply_to" might not be enough, because $initial_reply_to
can be defined and empty.

Mike

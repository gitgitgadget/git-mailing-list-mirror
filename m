From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 1/2] push: avoid suggesting "merging" remote changes
Date: Mon, 8 Jul 2013 19:47:16 +0100
Message-ID: <20130708184715.GW9161@serenity.lan>
References: <cover.1373223663.git.john@keeping.me.uk>
 <cover.1373223663.git.john@keeping.me.uk>
 <2a6f4a3c31e667aa03b06ce63ae5319a25beaca0.1373223663.git.john@keeping.me.uk>
 <vpqd2qtkvtk.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>,
	Philip Oakley <philipoakley@iee.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 08 20:47:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwGTF-0000vJ-Az
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 20:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880Ab3GHSr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 14:47:29 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:54486 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab3GHSr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 14:47:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 22723CDA48A;
	Mon,  8 Jul 2013 19:47:28 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OQWX73+nYTGk; Mon,  8 Jul 2013 19:47:26 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 3A769CDA5CC;
	Mon,  8 Jul 2013 19:47:17 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <vpqd2qtkvtk.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229885>

On Mon, Jul 08, 2013 at 03:47:19PM +0200, Matthieu Moy wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> >  static const char message_advice_pull_before_push[] =
> >  	N_("Updates were rejected because the tip of your current branch is behind\n"
> > -	   "its remote counterpart. Merge the remote changes (e.g. 'git pull')\n"
> > -	   "before pushing again.\n"
> > +	   "its remote counterpart. Integrate the remote changes (e.g.\n"
> > +	   "'git pull ...') before pushing again.\n"
> 
> To me, "merge" includes "rebase", so I'd say the merge -> integrate
> change is not needed, but I have nothing against it either.

Yes, I agree that in some sense "merge" does include "rebase" but I
suspect some people read it to mean "git merge" and saying "integrate"
removes that potential source of confusion.

> The "..." added are a bit weird with the quotes around. Quotes may
> suggest that the content is to be taken literally, which is not the case
> anymore. Not a real objection anyway, just thinking aloud.

I hadn't thought of it that way, but I wonder how else we can delimit
the command.

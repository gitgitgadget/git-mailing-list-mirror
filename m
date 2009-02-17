From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Google has renamed the imap folder
Date: Tue, 17 Feb 2009 10:54:23 -0800
Message-ID: <20090217185423.GK18525@spearce.org>
References: <200902171012.15755.johnflux@gmail.com> <7vprhg52ne.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 19:56:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZV7P-0007kN-No
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 19:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136AbZBQSyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 13:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbZBQSyZ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 13:54:25 -0500
Received: from george.spearce.org ([209.20.77.23]:51987 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086AbZBQSyY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 13:54:24 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id B5C6F381FF; Tue, 17 Feb 2009 18:54:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vprhg52ne.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110437>

Junio C Hamano <gitster@pobox.com> wrote:
> John Tapsell <johnflux@gmail.com> writes:
> >  
> >  [imap]
> > -	folder = "[Gmail]/Drafts"
> > +	folder = "[Google Mail]/Drafts"
> >  	host = imaps://imap.gmail.com
> >  	user = user@gmail.com
> >  	pass = p4ssw0rd
> > @@ -513,3 +519,5 @@ command to send the patch emails to your Gmail Drafts folder.
> >  
> >  Go to your Gmail account, open the Drafts folder, find the patch email, fill
> >  in the To: and CC: fields and send away!
> > +If you get an error that the "Folder doesn't exist" try with folder = "[Gmail]/Drafts".
> > +
> 
> Are there any Gmail insiders who can comment on this alleged change?  Is
> it for everybody?  Is it only for new accounts?  If I ask google about
> "gmail imap draft folder", I seem to be getting '[Gmail]/Drafts' version,
> and not the '[Google Mail]/Drafts' version, e.g.
> 
>     http://mail.google.com/support/bin/answer.py?hl=en&answer=78892
>     http://mail.google.com/support/bin/answer.py?hl=en&answer=82367


<add item="hat" type="googler">

Yea, the official public docs you link to say [Gmail]/Drafts.

I can't find any proof either way that we're using one or the
other format going forward.  Yes, I did look at stuff that is
only on our internal network.  I can't draw any conclusions
from what I was able to find and read.

</add>

So there's your "Gmail insider", at least from my perspective,
I really can't confirm either way any better than you can.

-- 
Shawn.

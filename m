From: sean <seanlkml@sympatico.ca>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Fri, 13 Jan 2006 12:54:04 -0500
Message-ID: <BAYC1-PASMTP0918AE856AD34E35597CA4AE260@CEZ.ICE>
References: <BAYC1-PASMTP117A18814EAAFACFE0F31DAE270@CEZ.ICE>
	<7vzmm1mcfz.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP102ED7B30D2B48BEE601F5AE260@CEZ.ICE>
	<7v4q48hizr.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP067B249A8110916F036FB3AE260@CEZ.ICE>
	<7vzmm0eod1.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP01A07DAA61F181E9D9679EAE260@CEZ.ICE>
	<40b2b7d90601130311v78db741dx7c5eaa57ad300850@mail.gmail.com>
	<7v64oo9gc7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: greenkaa@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 18:58:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExTC4-0000Vh-QA
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 18:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422758AbWAMR63 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 12:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422754AbWAMR63
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 12:58:29 -0500
Received: from bayc1-pasmtp09.bayc1.hotmail.com ([65.54.191.169]:35047 "EHLO
	BAYC1-PASMTP09.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1422750AbWAMR62 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 12:58:28 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP09.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 13 Jan 2006 09:59:04 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 10541644C23;
	Fri, 13 Jan 2006 12:58:27 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060113125404.58c4ce30.seanlkml@sympatico.ca>
In-Reply-To: <7v64oo9gc7.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 13 Jan 2006 17:59:04.0593 (UTC) FILETIME=[0AA72010:01C6186B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 13 Jan 2006 09:40:24 -0800
Junio C Hamano <junkio@cox.net> wrote:

> Have you two known that more than one environment variables can
> be set for one-shot command execution?
> 
> 	$ GIT_AUTHOR_NAME="$author" \
> 	  GIT_AUTHOR_EMAIL="$email" git commit -F .msgfile
> 
> would give these environment variables for this "git commit"
> without affecting the later commands.

No, I didn't know that; thanks for the lesson.

> 
> Not that this really matters, since the above example was an
> excerpt of my suggestion about how to do this in a script,
> somehow made to look as if it was a suggestion about running
> things by hand from the command line...
> 

I said quite a few times now this has nothing to do with running
git-commit from a script.   This is just a simple request
to not require the use of environment variables to pass useful
parameters.

I really don't understand your gripe on this one, when someone 
else suggested using a command line parameter for author
information you said:

<quote>

> 	--from="Some User <some.user@theoffice.org>"
>

I agree this would be more useful, direct, easy to understand
and explain way to do it.

</quote>


So do you still agree with that, would you accept a patch?  Or do you have
some fundamental reason to think that environment variables are a better
way to pass information in this case?

Cheers,
Sean

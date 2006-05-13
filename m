From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add "--branches" and "--tags" options to git-rev-parse.
Date: Sat, 13 May 2006 10:38:23 -0700
Message-ID: <7vd5ehu8og.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP0299DC98A51B55188BDF96AEAD0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 13 19:38:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fey4V-0007tB-No
	for gcvg-git@gmane.org; Sat, 13 May 2006 19:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWEMRiZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 13:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWEMRiZ
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 13:38:25 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:46012 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932114AbWEMRiY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 May 2006 13:38:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060513173824.UIXR25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 13 May 2006 13:38:24 -0400
To: Sean Estabrooks <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP0299DC98A51B55188BDF96AEAD0@CEZ.ICE> (Sean
	Estabrooks's message of "Sat, 13 May 2006 11:13:32 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19941>

Sean Estabrooks <seanlkml@sympatico.ca> writes:

> "git branch" uses rev-parse and can become slow when there are many
> tags.  Use the new "--branches" option of rev-parse to speed things up.

Makes sense perhaps.

I understand you added --tags for completeness.  Probably it
would make sense to add --remotes if you are shooting for that.

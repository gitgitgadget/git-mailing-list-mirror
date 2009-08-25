From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH v2] Add script for importing bits-and-pieces to Git.
Date: Tue, 25 Aug 2009 19:59:36 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0908251953480.19406@ds9.cixit.se>
References: <20090824171110.DA9202FC20@perkele> <7vy6p9do4k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 21:00:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg1Fb-0001bQ-MO
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 21:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756028AbZHYS7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 14:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755524AbZHYS7q
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 14:59:46 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:47839 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755990AbZHYS7o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 14:59:44 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n7PIxb1r020150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 25 Aug 2009 20:59:37 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n7PIxaA9020146;
	Tue, 25 Aug 2009 20:59:36 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <7vy6p9do4k.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Tue, 25 Aug 2009 20:59:37 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127041>

Junio C Hamano:

> Nice write-up.

Thank you.

As to your questions, they are very good, and I'll try to update the 
documentation a bit to clarify the points you made. This is the first time 
someone who is not myself have read it, so I expected some rough edges...

Follow-ups on some of the points (I will address the rest as well):

> You might want to mention that this format is different from what git uses 
> for its .git/config and .gitmodules files, and none of the rules apply to 
> them (namely, two/three-level names, case sensitivity, allowed letters in 
> variable names, stripping of whitespaces around values, and value quoting) 
> described in 'git help config' apply to this file.

A quick question on that: Is it possible to use the git-config parser 
stand-alone from a script like this? Then that note wouldn't need to apply.

> As you seem to be supporting merges, you might want to say topologically 
> instead of chronologically---this is minor, as you give more precise 
> definition "all parents must come before a child" in that sentence later.

I'm not sure I get the distinction here. Could you be a bit more specific 
(or point me to what I have missed in the Git manual)?

> How are problematic characters in pathnames (say, SP, '=' or worse LF)
> handled?  Do they need to be quoted, and if so how?

In the current version: Not at all. :-) I didn't need to, at the time.

-- 
\\// Peter - http://www.softwolves.pp.se/

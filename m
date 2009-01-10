From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Google Summer of Code 2009
Date: Sat, 10 Jan 2009 11:33:04 -0800 (PST)
Message-ID: <m3privyn20.fsf@localhost.localdomain>
References: <20090107183033.GB10790@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 10 20:35:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLjcP-00076U-Aw
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 20:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbZAJTdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 14:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbZAJTdJ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 14:33:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:53605 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbZAJTdI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 14:33:08 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1243505nfc.21
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 11:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=ikUF+o21HepR6TR8N+tTrvDcVN1YBaK9Ow5pfYUfrtA=;
        b=DrA6Q9jVUGGIwldCvodjteFLtBGoU6T0w2i1Ad+Diq07U+b7cB2Sc65EAx2WmcOl7U
         C3ULbHuC99vaVPxF3qFBW5ytTB7rc+0llzYK3nxG4dCZAulssUlzkOXq25/KiIyCGcTC
         MZmFo7AjnsyPpx93con63myUcHotDzncvtXR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=afCwVVBpgN+RowyD8bqnR+MfaZNbC2lY97dOgzpJzB3K3SozhV0cTDGrmubYgYNCyF
         2Tuz7K2MXHIANvi+KibThFMN00D4ZZjPiDB1d9LyErft2v0udQpRf7EAiLh5umAHj7mp
         ksHA43ptUQSi4sU9Ryws8FM8ONGh+6kJFbi/I=
Received: by 10.210.90.10 with SMTP id n10mr6227111ebb.150.1231615985835;
        Sat, 10 Jan 2009 11:33:05 -0800 (PST)
Received: from localhost.localdomain (abve97.neoplus.adsl.tpnet.pl [83.8.202.97])
        by mx.google.com with ESMTPS id 10sm2162169eyz.49.2009.01.10.11.33.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jan 2009 11:33:04 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0AJWe4s002940;
	Sat, 10 Jan 2009 20:32:45 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0AJWNDZ002934;
	Sat, 10 Jan 2009 20:32:23 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090107183033.GB10790@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105139>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> The application answers really need to be reworked; we need to
> address our 2008 results in these parts.

By the way, do you know what happened with git-sequencer project? 

If I remember correctly there was agreement on sequences mini-language
(I think), and there was git-sequencer prototype in shell, using
git-cherry-pick if I remember correctly, and even git-rebase and
git-am etc reworked to make use of git-sequencer.  Stephan Beyer wrote
that he has some preliminary version of builtin git-sequencer (in C),
and that it makes git-rebase--interactive and like faster than current
implementation... but builtin sequencer never materialized on git
mailing list as a patch, if I remember correctly, and of course it was
not merged into git either.
 
> The ideas box is once again open for suggestions.  Please start
> proposing student projects, and possible mentors.

Hmm... take a look what features competition has (Darcs, Bazaar-NG,
Subversion, Mercurial, Monotone)...

> 
> 
> Since the program is smaller, there is a chance we won't be accepted
> this year due to space constraints.  But I think its still worthwhile
> to prepare everything and hope for the best.  And before you can
> ask, no, my employee status with OSPO doesn't improve our odds
> for acceptance.  :-)

Perhaps at least _one_ project.  I think that resumable clone /
resumable fetch would be a good thing to have...

-- 
Jakub Narebski
Poland
ShadeHawk on #git

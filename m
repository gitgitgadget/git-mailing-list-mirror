From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Reverting an uncommitted revert
Date: Wed, 20 May 2009 11:21:19 -0700 (PDT)
Message-ID: <m3eiujk54b.fsf@localhost.localdomain>
References: <4A136C40.6020808@workspacewhiz.com>
	<alpine.LFD.2.00.0905192300070.3906@xanadu.home>
	<20090520032139.GB10212@coredump.intra.peff.net>
	<alpine.LFD.2.00.0905192328310.3906@xanadu.home>
	<025225A0-FACC-4A29-A747-40201A7FBA19@wincent.com>
	<alpine.LFD.2.00.0905200853010.3906@xanadu.home>
	<20090520141709.GO30527@spearce.org>
	<7vab57zmd8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 20 20:22:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6qPz-0006xg-01
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 20:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419AbZETSVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 14:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755192AbZETSVW
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 14:21:22 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:53764 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146AbZETSVV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 14:21:21 -0400
Received: by fxm2 with SMTP id 2so591852fxm.37
        for <git@vger.kernel.org>; Wed, 20 May 2009 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Eum8WgYpPfXZUCUuGZJ5p7JyJD6y5wwz/3lmMBg6ExY=;
        b=McXc7ap2Bu2YZTLe82WFDXhz7OnZA/Ft6UUVbN0cOgBN/m3+m1P4RG/pmy+TlgHPt6
         dZAJ2bMOuBTbc5xPZu4MvxJGsScJ1DRFwkcUd1vTfBwAiRn9GLqVcJw0ashKZxLEiQbv
         MiMEpwKKUsPQXa9z35REVuetCY4Ampvu5Kbys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=tCpPbQpIGfnAMdZbWmbv8gpHD3Reuvtd1kk8vEHvV7kKp4V2BRbVNLtAsIfG5VQU0L
         fxiV6tseqO1+4Z5w+G6/2hQ5T6Vk1KOQ4psr3J95n3YBPlVvuSHORtCZqip9xYYlmfWV
         jD0nmkKSRIkydbF7D6dZtAUOaFUXbVPANbZkY=
Received: by 10.103.174.18 with SMTP id b18mr849778mup.132.1242843681311;
        Wed, 20 May 2009 11:21:21 -0700 (PDT)
Received: from localhost.localdomain (abwp37.neoplus.adsl.tpnet.pl [83.8.239.37])
        by mx.google.com with ESMTPS id u26sm3300509mug.52.2009.05.20.11.21.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 11:21:19 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4KILI3C003028;
	Wed, 20 May 2009 20:21:18 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4KIL9qx003023;
	Wed, 20 May 2009 20:21:09 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vab57zmd8.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119627>

Junio C Hamano <gitster@pobox.com> writes:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > You did say "uncommitted entry causes reflog append", so in Peff's
> > original example of "git add a; vi a; git add a", we should be
> > creating a reflog entry for that first added state, which is clearly
> > not a disagreement.
> >
> > FWIW, I think this is a great idea, but lack the time to code it
> > myself, otherwise I probably would start hacking on it right now.
> 
> The devil's in the details.  There are at least four things you would need
> to design before start hacking.
> 
>  (0) Do you want this to apply only to Porcelains, or do you want to use
>      this for plumbing operations as well?
> 
>  (1) When would you "auto" write-tree?  When you do "git add" or anything
>      that adds new contents to the index?  Or immediately before you do
>      something destructive like "git reset"?  Or perhaps both?
> 
>  (2) Enumerate the operations that falls into the category you decided in
>      the above question.  For example, "git apply --index" and "git apply
>      --cached" would fall into the same category as "git add".  If you
>      cover plumbing, you would also need to cover "git update-index".

I guess that if we will not be able to resolve performance issues,
then such safety net would be of necessity limited only to highly
destructive commands that are more likely to destroy huge amount of
work if handled not carefully.

> 
>  (3) What should happen when you cannot write the index out as a tree?  I
>      think it is easier to make mistakes during a conflicted merge
>      resolution than during a straight linear development of your own, and
>      one of the cases that would benefit most would be that you have
>      resolved a path to your satisfaction but then later you screw up
>      while resolving some other paths, losing an earlier resolution.

Hmmm... because of (3), and because of performance concerns,
especially for the deep hierarchy, perhaps it would be better to use
here backup copy of index, or to save disk space just a delta to index.
On the other hand this would introduce yet another mechanism...

BTW., ad (3): how stash deals with conflicted merge? Hmmm... it doesn't

 $ git stash
 foo: needs merge
 foo: needs merge
 foo: unmerged (257cc5642cb1a054f08cc83f2d943e56fd3ebe99)
 foo: unmerged (b7d6715e2df11b9c32b2341423273c6b3ad9ae8a)
 foo: unmerged (5716ca5987cbf97d6bb54920bea6adde242d87e6)
 fatal: git-write-tree: error building trees
 Cannot save the current index state

-- 
Jakub Narebski
Poland
ShadeHawk on #git

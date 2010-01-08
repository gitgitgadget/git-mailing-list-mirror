From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH (v2) 2/2] rebase -i: teach --onto A...B syntax
Date: Fri, 8 Jan 2010 15:37:44 -0500
Message-ID: <fabb9a1e1001081237n11fa61b5m63fa46fac2ad8d4a@mail.gmail.com>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org> <7vskal5c11.fsf@alter.siamese.dyndns.org> 
	<20100106191825.6117@nanako3.lavabit.com> <alpine.DEB.1.00.1001061219180.11013@intel-tinevez-2-302> 
	<7vocl7yxef.fsf@alter.siamese.dyndns.org> <20100107200509.6117@nanako3.lavabit.com> 
	<7vtyux3bx1.fsf@alter.siamese.dyndns.org> <32541b131001081216p27d7e29bu269755db895128@mail.gmail.com> 
	<fabb9a1e1001081222q7122872bu72cea4e393f272ac@mail.gmail.com> 
	<32541b131001081231x1b6ac8c1k30084e4abf8cc896@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 21:38:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTLb3-0004TC-TJ
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 21:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573Ab0AHUiJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jan 2010 15:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753456Ab0AHUiJ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 15:38:09 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:63212 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab0AHUiE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 15:38:04 -0500
Received: by pxi4 with SMTP id 4so2318851pxi.33
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 12:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=V+a/r01yVATU/4RA3zgXzR3Mr+iSsbyzbnlrFqDjbM8=;
        b=PgC/hemfmdXEqNxqWso/XAW4MglghJRJvzQmbgliWhm4YR0PegoClMMksYfF99H7RZ
         4hOctCSBVbPaBwxDj1X8kcR/817eO9XU6Jgm7zJp7bHl5Zbt3W+tHLREs0V3wK7ZqL3I
         aLI4Mvbwd0K0kE8xpABepVLzZ9sKMk/7pNjuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=eOWqlaLnO8IkXo0qc7RTPmWLuebdDerDUpvGqkDS+P5TawWNqMV3SY329KBjxsu9xV
         hWT1ieFlJJ21dB8LabRJoZSFMXBDbsLvusZOx5VBWpmt3Ns3hE7r0bY6Kh4TkANiC41h
         XMOdG5eEaLIyYddkxfGW3B7rbrRKtOalIGKvI=
Received: by 10.142.67.24 with SMTP id p24mr5424469wfa.252.1262983084150; Fri, 
	08 Jan 2010 12:38:04 -0800 (PST)
In-Reply-To: <32541b131001081231x1b6ac8c1k30084e4abf8cc896@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136475>

Heya,

On Fri, Jan 8, 2010 at 15:31, Avery Pennarun <apenwarr@gmail.com> wrote=
:
> Thanks, I didn't know about that one. =A0But my general point is stil=
l:
> we seem to have two implementations when the functionality of one is
> actually a superset of the other. =A0As far as I can see, anyway. =A0=
So
> the obvious way to reduce the duplicated code is to simply eliminate
> the less-featureful implementation.

*cough* git sequencer *cough*

--=20
Cheers,

Sverre Rabbelier

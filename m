From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git fast-import/fast-export
Date: Sat, 6 Mar 2010 20:05:22 +0100
Message-ID: <fabb9a1e1003061105u70cf87b8h579fe154a24fb8f0@mail.gmail.com>
References: <fabb9a1e1003060702r671b57f4m9308863f566d5fbd@mail.gmail.com> 
	<7v3a0di87z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Elijah Newren <newren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@fluxnic.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 06 22:43:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No16z-0004YU-DJ
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 22:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754317Ab0CFTFn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Mar 2010 14:05:43 -0500
Received: from mail-pz0-f200.google.com ([209.85.222.200]:62185 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259Ab0CFTFm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Mar 2010 14:05:42 -0500
Received: by pzk38 with SMTP id 38so246166pzk.33
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 11:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=cqZNF+0aJLQIUtoxtRuCbyP2w5RM4CWC1e1+5DmtKR0=;
        b=cbmu7FPEAFqXgFTSjok7QDUvxLwjOcECw+qWhBX+inZiezPT10DRndNbRhKAijBW+w
         /3U7Ajgit37e+LA2jvUa4rrcwOjGoOhHnoHoyTyRMmHk1h0wg4o1SHVe4ZsgDIvd+k5u
         Unt9m5zmQsgpK9zmB5Tw0w915FgAggDBAcE3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bHmW7XcHprxbuPwbYmI4aVgsmDmwmACEHbr17+x9MFACfVEHQxeqWDSY0JLnSg5SOi
         OGc8ury40ueWaqGuMEnCKYpFH2zg8Jl8OJcZZHCiAR5n8UwaLHG6ni50DdqmzB5Nrsg3
         2Peo+R5wsp7wmud/sYJwQ+P9GHXsIWa6jhoYQ=
Received: by 10.142.250.3 with SMTP id x3mr1766165wfh.347.1267902342067; Sat, 
	06 Mar 2010 11:05:42 -0800 (PST)
In-Reply-To: <7v3a0di87z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heya,

On Sat, Mar 6, 2010 at 20:02, Junio C Hamano <gitster@pobox.com> wrote:
> Isn't fast-import designed to be used as a downstream side of a pipe =
that
> is fed by an independent program you write (and may link with libsvn)=
? =A0It
> wouldn't care what license that data producer program is distributed =
under.

Yes, I'm not worried about using the 'git-fast-import' or the
'git-fast-export' binary, I want to use-and-modify the parsing code to
work as a fast-import/fast-export frontend to svn _on top_ of using
those binaries..

--=20
Cheers,

Sverre Rabbelier

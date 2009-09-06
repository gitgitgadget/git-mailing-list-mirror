From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/4] push: make non-fast-forward help message configurable
Date: Sun, 6 Sep 2009 13:30:32 +0200
Message-ID: <fabb9a1e0909060430q473a821ay61f6b418e5e3fa8e@mail.gmail.com>
References: <20090906064454.GA1643@coredump.intra.peff.net> 
	<20090906064816.GC28941@coredump.intra.peff.net> <7v8wgsk0rw.fsf@alter.siamese.dyndns.org> 
	<20090906072322.GA29949@coredump.intra.peff.net> <7vzl98fr22.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Nanako Shiraishi <nanako3@lavabit.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 13:31:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkFxV-0001cI-Jz
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 13:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793AbZIFLaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 07:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754683AbZIFLaw
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 07:30:52 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:53338 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbZIFLav (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 07:30:51 -0400
Received: by ewy2 with SMTP id 2so1454104ewy.17
        for <git@vger.kernel.org>; Sun, 06 Sep 2009 04:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=sy2kxKChEboMT8PLWA7H/3Qpy+tv3osP+uJGARUdtCY=;
        b=E38mXn/thkKySqI61i++KgrHjB5qLcj5C/8FLt1ARw02/9xjxYYaOSBbxSWvPEv5an
         /pEvqi++GP8KIr/Znui7stJsTylHOwKPkJ5v97YvJBCmRVYqeoX9yV5P30wz+3QHUVDN
         ZlxdEvprKsQqGcSVk9uFxKo3xz3r0KCG+4tH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qlcPYL6qNSo5VEfTfp4tnMTW4Fl5siWjsJ+o378lGKY9VpjHcorVKHLqYMZp/IeXt+
         F0+8lLHw1jCEJl/m22rMWK5xcigBTcApir//Bvo5w/czM2k2L3VjBgLuCiZPr6acRnYa
         z0qBigwY68+X+Ghs9b8sfHXcv45bNWiQW5o1U=
Received: by 10.216.90.76 with SMTP id d54mr1382479wef.55.1252236652189; Sun, 
	06 Sep 2009 04:30:52 -0700 (PDT)
In-Reply-To: <7vzl98fr22.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127851>

Heya,

On Sun, Sep 6, 2009 at 09:52, Junio C Hamano<gitster@pobox.com> wrote:
> Resetting is done because I want to build an alternate history starting
> from an earlier point, and when I am done, I may want to feed this to "git
> diff" or whatever to sanity check the result, without having to go through
> the reflog.

I agree, the 'you are now at ...' is not very helpful, I just TOLD you
where I want to go to! However, 'you were at ....' is also not
optimal, since what I really want to know is where I was at "plus any
old data I had" (going back to the 'git reset --hard' should create a
snapshot of the current content before doing it's resetting'). I would
definitely prefer 'you were at' over 'you are now at' though.

WRT the 'none of your business', it sounds like 'I [already] know
[that]' might be approriate?

-- 
Cheers,

Sverre Rabbelier

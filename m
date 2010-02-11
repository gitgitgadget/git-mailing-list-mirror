From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git cherry-pick --continue?
Date: Thu, 11 Feb 2010 18:05:18 -0500
Message-ID: <76718491002111505u2935381erc376cea862e15801@mail.gmail.com>
References: <fabb9a1e1002101237i60a0b2c5j6d1e52b33dacbaa2@mail.gmail.com>
	 <20100210210419.GA7728@coredump.intra.peff.net>
	 <20100210212408.GB7728@coredump.intra.peff.net>
	 <7v63644uoq.fsf@alter.siamese.dyndns.org>
	 <7vbpfw3f6t.fsf@alter.siamese.dyndns.org>
	 <fabb9a1e1002101423y79460afdn2bc31b117195ef42@mail.gmail.com>
	 <7vpr4c200i.fsf@alter.siamese.dyndns.org>
	 <20100211210445.GA8819@coredump.intra.peff.net>
	 <20100211211937.GA12752@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 12 00:05:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfi6C-0002eW-3g
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 00:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339Ab0BKXFW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 18:05:22 -0500
Received: from mail-iw0-f195.google.com ([209.85.223.195]:46233 "EHLO
	mail-iw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab0BKXFU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2010 18:05:20 -0500
Received: by iwn33 with SMTP id 33so2150002iwn.5
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 15:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aYw1dbM9qqq6FItBMUkgBCFz1pfK13pYCuUpYBw9JaQ=;
        b=UQtt2i7KZyHvzrvvrU/6QglQMR+UrtPsNZU/3J9wL1zBg0/sPOkd9eD/y7FrRSmLZK
         ABEIb/VyjymgiWUF4BD6TEPKJIfx9q9EjnQVyhTJJxF38pLtc7y24K3FHOSqly8ooUnQ
         L5VR29V+0Fu79WmCUtesXXnkIaAUukYFyvDq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=atuYC0nTBvabxi2nKZ4aeJhBr69iAIFFPZ8eLMWFs08Nd3G0A5/fBb+fRNHBnQkwx4
         IzYve84wPMY6fCGQKxywZ/J7smJTFyrJFobznViST42+TGBIQP75IVHkQpG/JpQtk8I+
         IW77yqahoP8PSXm5yViiY/ha7odIaqDmYmeCA=
Received: by 10.231.167.204 with SMTP id r12mr890517iby.31.1265929518481; Thu, 
	11 Feb 2010 15:05:18 -0800 (PST)
In-Reply-To: <20100211211937.GA12752@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139638>

On Thu, Feb 11, 2010 at 4:19 PM, Jeff King <peff@peff.net> wrote:
> =C2=A0Automatic cherry-pick failed. =C2=A0After resolving the conflic=
ts,
> =C2=A0mark the corrected paths with 'git add <paths>' or 'git rm <pat=
hs>'
> =C2=A0and commit the result with:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -c HEAD~23
>

Blech, how is this an improvement? Why can't I just say "git
cherry-pick --continue"?

If I've still got the message in my terminal, it's no harder to use
the SHA1. And if I've lost the message in my terminal, HEAD~23 is lost
and I've got to dig the SHA1 out of my shell history anyway.

(This isn't hypothetical; typically I'll cherry-pick, do some crap in
that terminal such that the message is lost, then I've got to go
through my history to see which commit I had been cherry picking. So
changing the message doesn't help with that situation at all.)

j.

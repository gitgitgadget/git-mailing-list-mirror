From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC] require-work-tree wants more than what its name says
Date: Thu, 5 May 2011 13:15:29 +0200
Message-ID: <BANLkTinaoopUxOHC0XaUxMLXj4pCXND+UA@mail.gmail.com>
References: <7vhb9bgy0a.fsf@alter.siamese.dyndns.org> <20110504073850.GA8512@sigill.intra.peff.net>
 <7vliymfp4t.fsf@alter.siamese.dyndns.org> <20110504212848.GA27779@sigill.intra.peff.net>
 <7v62ppdhh5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 13:16:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHwXX-00046v-Up
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 13:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816Ab1EELQL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 07:16:11 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58406 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab1EELQK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 07:16:10 -0400
Received: by qwk3 with SMTP id 3so1321799qwk.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 04:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=TPBRXjrK/31YgpeBsSVwX5dh3qnrmhtqq9/NxZEefhs=;
        b=NW2hEm3TOWeRumKYQWDhD9wdS5H+xNVuR0ILCpzd5zWUSe1fQ8u3o/DjsHNLxUSVCB
         1v4s2QHWMkUtA/vH9OH3B8+0l5/uOhwxmbaMpvfi+lUtwMDKYaph1X0B4yuuXSBDNrFG
         ehDbfc1ah1GOFUxhwhd1tAe5gdjTxe/sgPNoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=UzS4ITpUEjCrR1TylMS8J6w1HrMzTCL8ZaHZxBrTrqAEykT2B7lrSR0uQ6FdqPfMdz
         Tvzt+BPmwMTdbxhsKrCrTO+Saff08m7BoTXveUKa57pmortcVIex63K53A5SnrmYKm5D
         1e7XiFTMt4QXdJXXpIVGYB0EWBAb3qbRznLzY=
Received: by 10.224.37.10 with SMTP id v10mr2195415qad.84.1304594169268; Thu,
 05 May 2011 04:16:09 -0700 (PDT)
Received: by 10.229.75.70 with HTTP; Thu, 5 May 2011 04:15:29 -0700 (PDT)
In-Reply-To: <7v62ppdhh5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172828>

Heya,

On Thu, May 5, 2011 at 04:11, Junio C Hamano <gitster@pobox.com> wrote:
> =C2=A0- I am not sure if git-submodule.sh correctly works with the "a=
s long as
> =C2=A0 there is a working tree somewhere, it is OK" semantics. =C2=A0=
It may have
> =C2=A0 to stay "require_work_tree" to ensure that the $cwd is within =
the
> =C2=A0 working tree.

So do we need more tests for git-submodule to find out, or is this a
hint to the submodule people to chime in? If so, should they be cc-ed?

--=20
Cheers,

Sverre Rabbelier

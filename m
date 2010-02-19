From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 01/10] Documentation/git-pull.txt: mention --quiet and 
	--verbose for fetching
Date: Fri, 19 Feb 2010 14:31:16 +0800
Message-ID: <be6fef0d1002182231t56d04b89h8910dce5cbed3f@mail.gmail.com>
References: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
	 <1266496631-3980-2-git-send-email-rctay89@gmail.com>
	 <7vhbpe5jvo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Sebastian Thiel <byronimo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 07:31:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiMOZ-0001ZH-0H
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 07:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327Ab0BSGbS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 01:31:18 -0500
Received: from mail-iw0-f196.google.com ([209.85.223.196]:59016 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066Ab0BSGbR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2010 01:31:17 -0500
Received: by iwn34 with SMTP id 34so480343iwn.15
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 22:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DkMxFiDyf+EROrpSnLg4NxLLkreh9iGiiFnPXQUaqts=;
        b=m8syurm/CgvNZ8bTdopuAP0s7lh2wK97QQ4cMzifBS9km0tkrHopOSkhOEfVGNrEfA
         yy6FHg96ohHlPWZW2a0w3CVxXbsmdHHP5ekLVHNG+X1tfk1ueGhV6k5kCCn1OxArMUV3
         3ie7phoJQK1s2NqgTu3OcCcBCuoOdIc1gXTJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lOMyCOkrqthqVZLUa0ks8YH83ecnyTT5cMs4QEWJ/Kb9bn1VdcZ3B34mFvws+QQSBO
         hvEZRzE2ZcjHnEfYjbyzteLIcsD/dNkzxEKIAinRxim/ovP3s9vZGFPGW6thC0ZR/6LT
         j8tHdJviMuZtuvf9W69b63TyPsqkv73QCqD3E=
Received: by 10.231.59.74 with SMTP id k10mr104029ibh.48.1266561076901; Thu, 
	18 Feb 2010 22:31:16 -0800 (PST)
In-Reply-To: <7vhbpe5jvo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140414>

Hi,

On Fri, Feb 19, 2010 at 5:11 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> It may make more sense to list the options that affects both fetch an=
d
> merge at the beginning of the OPTIONS section before the merge/fetch
> subsections. =A0IOW, instead of removing ifndef::git-pull[] like your=
 patch
> did, it would add ifndef::git-pull[] in the list of options on the me=
rge
> side, and add pull specific description (e.g. "this is passed to both
> underlying fetch to squelch progress output of transfer, and underlyi=
ng
> merge to squelch the output during the merging") in git-pull.txt.

I considered adding a "common options" section too, but wasn't sure.
I'll take your suggestion on this.

--=20
Cheers,
Ray Chuan

From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH 2/3] add a library of code for producing structured 
	output
Date: Sun, 11 Apr 2010 20:26:00 +0200
Message-ID: <s2hfabb9a1e1004111126i6822abc1ne0e0e5bad6f4ac7@mail.gmail.com>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk> 
	<20100411113733.80010.3767.julian@quantumfyre.co.uk> <7vy6gtonwt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org,
	Eric Raymond <esr@thyrsus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 20:26:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O11rg-0003Zi-4M
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 20:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708Ab0DKS0V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 14:26:21 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:54624 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456Ab0DKS0V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 14:26:21 -0400
Received: by gxk9 with SMTP id 9so2949636gxk.8
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=P2Y6e2Y4Vq4ELHGXB2RLRXsXruCdGDsXZ6zBgpy0dds=;
        b=rE0f3ZjqdawUF0YNMZ5u8dtruEtgHmVrpjJ5qK74t8z26iXDtgC/hDs9LxXu/dPoYF
         VRbxhxpiGirMx8XBUw7DHwFX22NODXI1HNosqOl1QobMtkA1H5dB4YN0VF7y7GfpDPTW
         wSE1OI0/Lkla2+nFZwUJOtyVRcZW+yqa/omtw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=revan25ISa5O/giP6uLpaRjoI16NmE2EM/N4ZkS4ZPCbKG3IeaUSBSA6ildZRQAa0T
         FV6ljtUuU/vKfg7rVtg89Hiy4s/fkfbj2TZ6ocPXcNUHYIUlQyTTgnHosUNaBEH/Q5q/
         HssgZ+FYVpgQ0D4sfL7Ri5CX0d3SVPpHmSR+8=
Received: by 10.100.206.13 with HTTP; Sun, 11 Apr 2010 11:26:00 -0700 (PDT)
In-Reply-To: <7vy6gtonwt.fsf@alter.siamese.dyndns.org>
Received: by 10.101.152.13 with SMTP id e13mr4998363ano.0.1271010380320; Sun, 
	11 Apr 2010 11:26:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144675>

Heya,

On Sun, Apr 11, 2010 at 20:16, Junio C Hamano <gitster@pobox.com> wrote=
:
> I was hoping that the existing low-level -z routines (e.g. "diff-* -z=
")
> follow similar enough patterns to have a corresponding output-z.c and=
 be
> handled inside output.c library. =C2=A0But that is not a requirement,=
 just
> "would have been nicer if the original were written that way".

I like that idea, I think it would make our plumbing interface more
consistent, and further validate the API design. Any plumbing command
(once converted) can then be used with -z (or --format=3Dzero or
whatever it is) and give a similar output format, very nice.

--=20
Cheers,

Sverre Rabbelier

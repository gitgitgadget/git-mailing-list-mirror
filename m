From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 04/19] teach remote-testgit to import non-HEAD refs
Date: Wed, 8 Jun 2011 21:47:38 +0200
Message-ID: <BANLkTin6u_oZpaHiRfEzsL2kSbj9coZcrQ@mail.gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-5-git-send-email-srabbelier@gmail.com> <20110608193049.GG27715@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 21:48:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUOk1-00036G-LS
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 21:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab1FHTsV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 15:48:21 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50264 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab1FHTsS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 15:48:18 -0400
Received: by qwk3 with SMTP id 3so398626qwk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 12:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=x2lRNEtj5Wz7U6HxRxNltfjDMd71uIsiZdkiTT0rb70=;
        b=trYiz1xPSVHreaSKMpc1iFRugQPlC/iNkaO4MP5gabkW7wVjYanLL1GZGnFTgYZUc9
         Mavdb201sx9KdvTknbAUpJtq3L84TxcL3FMxeIGAbuzqi261cOwYrtIWxH2SU+cNzvZq
         GZd8eaoFkmIEIDH9tTTh3aIB1g50yF6qFLpgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hh9IQOWcHMmjEx6YR5CgPYyJdlvALeauJyDd7yPFKJ8OEzvaw5KGAeWLJcIvKNMKlt
         w7rTc2pKYg+SNQwAsx+iwGoyIBSMbmuizu/yAaTtiMXNOmxE+WzFCXRp6r9mHNH+OBar
         jaaMIfP5cg+9v//q1AdZyUByNyNDEGeMtW1RY=
Received: by 10.229.127.99 with SMTP id f35mr5837367qcs.91.1307562498133; Wed,
 08 Jun 2011 12:48:18 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Wed, 8 Jun 2011 12:47:38 -0700 (PDT)
In-Reply-To: <20110608193049.GG27715@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175451>

Heya,

On Wed, Jun 8, 2011 at 21:30, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
>> =C2=A0 Unchanged from Peff's series.
>
> Looks good. =C2=A0What happened to Peff's signoff?

I pulled the series from his github repo, which didn't have it.

--=20
Cheers,

Sverre Rabbelier

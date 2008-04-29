From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 11:02:16 -0700
Message-ID: <7f9d599f0804291102j4a30c344h18d12d03a6d5953b@mail.gmail.com>
References: <200804281829.11866.henrikau@orakel.ntnu.no>
	 <20080429124152.GB6160@dpotapov.dyndns.org> <481733A3.4010802@op5.se>
	 <alpine.LFD.1.10.0804291132060.23581@xanadu.home>
	 <7f9d599f0804290859y6a579302m5db9f7f827b320a4@mail.gmail.com>
	 <alpine.LFD.1.10.0804291232130.23581@xanadu.home>
	 <7f9d599f0804291048n2c706f3amdf159ffe86bdbc8@mail.gmail.com>
	 <alpine.LFD.1.10.0804291352120.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Dmitry Potapov" <dpotapov@gmail.com>,
	"Henrik Austad" <henrikau@orakel.ntnu.no>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 20:03:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JquAV-0000uG-OU
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 20:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756702AbYD2SCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 14:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756291AbYD2SCT
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 14:02:19 -0400
Received: from rv-out-0708.google.com ([209.85.198.251]:35198 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756595AbYD2SCS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 14:02:18 -0400
Received: by rv-out-0506.google.com with SMTP id k29so59022rvb.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 11:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=qcW//LTR3xf6lOB/1L2BDVsdo1YuQwyLLAJzNzUjBBI=;
        b=UjaKlnDyKPOu3n0/mkWofVgJ4ErYWrDBDm8mcGQKjbJLCi4bGD6vBF8mKxOwhBHiOUPyDiAIVLZ7hH5vnHEVUx+YZhcy9aDqR/voIxoxVGBOPmJKccWkw5KKUQjTLSE+em6ApbxMbsxf7NpKdiKP7l5RqVJsWi6ssFqtUkZwT7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=xp7Ny7PdxFg1lbZYlaZcitnsNs9FDWTl0lvmbguyIkG/LmwSlfM5+Ipk8/7/gIuyTIgbZrFjb2wIZ35rlj6qS77ZmYhrzzBmpyXNYR1asE/ElVLpUNeTMKeLv6QgFaIvLGUDFPJBTCjE44qAy1NFBg5GYTiKoWJUF8s9xrn+goA=
Received: by 10.141.71.14 with SMTP id y14mr698555rvk.253.1209492136595;
        Tue, 29 Apr 2008 11:02:16 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Tue, 29 Apr 2008 11:02:16 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0804291352120.23581@xanadu.home>
Content-Disposition: inline
X-Google-Sender-Auth: 53489cddce404347
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80713>

On Tue, Apr 29, 2008 at 10:55 AM, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 29 Apr 2008, Geoffrey Irving wrote:
>
>
> > Sorry for the confusion: it would handwaving if I was saying git was insecure,
>  > but I'm not.  I'm saying that if or when SHA1 becomes vulnerable to collision
>  > attacks, git will be insecure.
>
>  Right.  And if or when that happens then we'll make Git secure again
>  with a different hash.  In the mean time there is low return for the
>  effort involved.

Yes.  I wasn't trying to advocate switching, just making sure people
know that the "collisions don't matter" argument is bogus.

One important thing: when SHA1 becomes vulnerable to collision
attacks, it will still be secure to trust the repositories and tags
that exist *at that moment.*  I.e., the transition period from SHA1 to
the next hash will also be secure, assuming that preimage attacks
don't become possible simultaneously.  So everything is good.

Geoffrey

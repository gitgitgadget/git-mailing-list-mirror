From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2010, #01; Wed, 03)
Date: Thu, 4 Mar 2010 20:09:16 +0800
Message-ID: <be6fef0d1003040409o5a1e3396l8249951e8d65b1ee@mail.gmail.com>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 13:09:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn9ro-00050C-Rw
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 13:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954Ab0CDMJU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Mar 2010 07:09:20 -0500
Received: from mail-gx0-f217.google.com ([209.85.217.217]:49424 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911Ab0CDMJT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Mar 2010 07:09:19 -0500
Received: by gxk9 with SMTP id 9so1151242gxk.8
        for <git@vger.kernel.org>; Thu, 04 Mar 2010 04:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iHC5mJilUrr23sATGVYMuSxBfqUA7+YsV4UKc9APzbM=;
        b=lr50WJhInmJWuxFL3FYmDpT88gSzJHryoeYFqaMsA+Ks2ws2+pVRQdqflCAzGGqVBp
         sss+zGwAmF0EgmvkvuG3Rc1FM8ceQNr2Uy8LmNIBZ5e4ueYBX7YYjFkV7uv1pAdWwZst
         keQ6l70BaniHfJpajqZAHy97wdVxrTp5TCcqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pWy8dity9Nz4PVGgxHFeSW1DnsAgeER73WN2rF8R0WxkQ/292g0En1jfX0KAAx9h+Z
         UjdRHA5yh+xfiFNDOG9OqBfaMFXi8egIXcQb7CTQ/1uIjwqTQklBitWf3kDkRjB0q/qW
         cJlojBtkRmr7ko697x2XK8siCNvKGp3Nco0/w=
Received: by 10.101.142.22 with SMTP id u22mr1058664ann.146.1267704556525; 
	Thu, 04 Mar 2010 04:09:16 -0800 (PST)
In-Reply-To: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141523>

Hi,

On Thu, Mar 4, 2010 at 8:02 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> * tc/transport-verbosity (2010-02-24) 10 commits
> =A0- transport: update flags to be in running order
> =A0- fetch and pull: learn --progress
> =A0- push: learn --progress
> =A0- transport->progress: use flag authoritatively
> =A0- clone: support multiple levels of verbosity
> =A0- push: support multiple levels of verbosity
> =A0- fetch: refactor verbosity option handling into transport.[ch]
> =A0- Documentation/git-push: put --quiet before --verbose
> =A0- Documentation/git-pull: put verbosity options before merge/fetch=
 ones
> =A0- Documentation/git-clone: mention progress in -v
>
> Didn't look very carefully. =A0Comments from transport people are ver=
y much
> appreciated before moving this forward.

the last discussion on this topic centred around the git-pull
documentation, which this latest iteration has addressed. Jeff also
gave his OK for the previous iteration.

I also noticed a merge conflict - I think the resolution looked ok.

--=20
Cheers,
Ray Chuan

From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Wed, 21 Nov 2007 16:24:42 +0100
Message-ID: <8aa486160711210724s2cad1e05s15360d03a77d8cac@mail.gmail.com>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com>
	 <fi1heo$u4i$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 16:25:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IurRm-0003i0-Tu
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 16:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbXKUPYq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Nov 2007 10:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbXKUPYp
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 10:24:45 -0500
Received: from rn-out-0910.google.com ([64.233.170.189]:18009 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752387AbXKUPYp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Nov 2007 10:24:45 -0500
Received: by rn-out-0102.google.com with SMTP id s46so3543967rnb
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 07:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SdfV3N5a3Uecy7Et5SM0xijr0qC8uQyBPHIQPITIS3I=;
        b=glVMxniqSisUPwKX90DbNnbWhpJCdRFexUnEntF+XtwxEv63NiezPP5pvvjRtphoMsTLm4g9mJkujjAGMW7qE2PVFfeKrN3HDHEr9snRxmFHs8kcNkSI12tjalDNmQeMoKwCj5HFUvZF4KNz73LTMXINeOjKaDlM0aM3q5m5SPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kQqQqIfNvC/Q1l6W0+WODcrz7mKDtaqmZER7MsGCfkuh8yuSFCpFMaZMt5q/7BP3oV4BQXQcu5vZBleqV65tlOvzQKBpDfKPpwVpWA9vTW5batMibwXVTlEBY8kImcsdVg5mpZutp7qOQoKnOc/bdta1YD+vRvDqoY6RhLdlWKk=
Received: by 10.151.7.4 with SMTP id k4mr1309026ybi.1195658682659;
        Wed, 21 Nov 2007 07:24:42 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Wed, 21 Nov 2007 07:24:42 -0800 (PST)
In-Reply-To: <fi1heo$u4i$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65664>

On Nov 21, 2007 4:04 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Santi B=E9jar wrote:
>
> > 3) I can "git fetch" a bundle but I cannot "git push" a bundle, so =
if I have:
> >
> > [remote "bundle"]
> > url =3D /file/to/bundle
> > fetch =3D "+refs/heads/*:refs/remotes/bundle/*"
> >
> > $ git push bundle
> >
> > would create a bundle in /file/to/bundle with the same branches as =
a
> > normal git push, but considering the remote branches as the local
> > remotes/bundle/*
>
> And how you would differentiate between path meaning bundle, and
> path meaning "local" protocol, i.e. git repository on the same
> filesystem? "bundle =3D /file/to/bundle" perhaps...

Good point. The git repository must exist before pushing, but the bundl=
e:

1) Exist and is a file, do nothing by default, maybe requiere a --overw=
rite
2) Does not exist, create the bundle, but maybe you've written badly th=
e url, so
    the best thing would be to say explicitly that you wanted a bundle
like you said.

Santi

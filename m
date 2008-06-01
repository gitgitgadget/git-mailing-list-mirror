From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Remove gitweb/test/ directory
Date: Sun, 1 Jun 2008 02:19:15 +0200
Message-ID: <200806010219.16773.jnareb@gmail.com>
References: <28EDBE43-6E55-4EC9-97C6-8AC8D949E82D@zib.de> <5DBABAFE-C447-4E5D-A7E8-0C16B4D1D960@wincent.com> <alpine.DEB.1.00.0806010018300.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Kay Sievers <kay.sievers@suse.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 01 02:20:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2bJK-00057y-9K
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 02:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951AbYFAAT1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 May 2008 20:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754926AbYFAAT1
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 20:19:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:3089 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754716AbYFAAT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 20:19:26 -0400
Received: by nf-out-0910.google.com with SMTP id d3so220791nfc.21
        for <git@vger.kernel.org>; Sat, 31 May 2008 17:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=b03yWqR6sJBzCuaZCdg/rpqoMxgzQu+9rTA2pM7KEfE=;
        b=T8Ct5z/VL85XnDfY4xhFepJ+XHR5wHI0rC6+495cTZ+wLx3OOPLR6nkXaR3bEkGujf6Ue3NmVCw54h1afgFOXV8gxm6cTpOb6NKgkV3YbZtrkJ1BoczKYdtu6NrLHuOM+JslUYv+Za7Tgn0Z2JHNTpJWvAMYAZGIPpRBusIFmng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=C+fYeHnLjHUKM/ziJcD1gvtnQHJPsTIoi7XZM/H4cuypE+4oX0V/0fNVlJI6UqGUiYLKGBC3chfM4mte1orAUHbjsxPy8rhPQTEMF24NrayJwVFHuFt/29mGT25Sm0f64qsvtuMv9D58As+RlI8cQ1Am1b/DIjHrbLfYHIKP6RA=
Received: by 10.210.26.10 with SMTP id 10mr1964105ebz.15.1212279564753;
        Sat, 31 May 2008 17:19:24 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.204.14])
        by mx.google.com with ESMTPS id z34sm2279413ikz.9.2008.05.31.17.19.21
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 May 2008 17:19:23 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.00.0806010018300.13507@racer.site.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83418>

On Sun, 1 Jan 2008, Johannes Schindelin wrote:
> On Sat, 31 May 2008, Wincent Colaiuta wrote:
>> El 31/5/2008, a las 20:28, Jakub Narebski escribi=F3:
>>=20
>>> Testing if gitweb handles filenames with spaces, filenames with plu=
s=20
>>> sign ('+') which encodes spaces in CGI parameters (in URLs), and=20
>>> filenames with Unicode characters should be handled by gitweb tests=
=2E
>>>
>>> Those files are remainder of the time when gitweb was project on it=
s=20
>>> own, not a part of git (with its testsuite).
>>>
>>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>>=20
>> Ack.
>=20
> And I thought "Ack" was reserved for the people who are considered th=
e=20
> primary authors of the patched code...

Unfortunately, as far as I know, primary and only author of those
lines of code, maintainer of gitweb when it was separate project,
Kay Sievers, is no longer active in git development.

--=20
Jakub Narebski
Poland

From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Relative ls-files
Date: Wed, 23 Mar 2011 09:54:45 -0400
Message-ID: <AANLkTi=BrgZe47Bt5evr_qFzKBL=MY-6NmH22gsRurVV@mail.gmail.com>
References: <AANLkTi=fP+jBpLuxst2rv02pYRmj4HOkv8Yenc-dR-N_@mail.gmail.com>
 <4D89D052.5030801@drmicha.warpmail.net> <AANLkTimc7gNKbh3C2hyMtFK6D1OWNALD+GvzmhG5cZrn@mail.gmail.com>
 <AANLkTimdLGgGXGRNVH5+X-cnhK2NWfWx9k0apt-6rr1Z@mail.gmail.com> <4D89DCBE.3060400@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: demerphq <demerphq@gmail.com>, John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 14:55:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2OWp-0004aA-Eg
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 14:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413Ab1CWNzH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 09:55:07 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57258 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946Ab1CWNzG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 09:55:06 -0400
Received: by gwaa18 with SMTP id a18so3336787gwa.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 06:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=mpmVPC4CLBCcJ9rxsD4whI/IoOIb30lgmnxxX1aGNqA=;
        b=akeuhs6uVZM44bgFOFoOm8IeKbvNbvMzU85XS4rQGG5yY5x6wgiTrMfwKgA+O+8477
         4HXZr8w+jxCmGIIXkvh9FSkblywDVjgmHuLg+d6KgpLCQSNgJnxN60+9ek4VnHdImsKh
         AWN0zg+NDJT/sH513RKOPABNUslDRBONu2MFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Apx2a8Pwmnqm59kou8izF1AXCaRj/20U5fQxeo9xpk1pgxdQO7ofD0alkWfYXvySRm
         1/XdiuOQ3Fs7oYRvnrz8uSMXWMhHBK2SIzrnL5zI2YFYVmzSuBN2uaC+FruFPIMRFNao
         vgUkar/tjjCtK7sB2hvYWRPFCYSok5ytQ9BWM=
Received: by 10.91.164.27 with SMTP id r27mr6375414ago.204.1300888505107; Wed,
 23 Mar 2011 06:55:05 -0700 (PDT)
Received: by 10.90.74.2 with HTTP; Wed, 23 Mar 2011 06:54:45 -0700 (PDT)
In-Reply-To: <4D89DCBE.3060400@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169831>

On Wed, Mar 23, 2011 at 7:42 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Of course ":" has a meaning. "git show HEAD:" lists all files at the
> top-level of the tree at HEAD.

I got excited for a moment... now tested it and there isn't a recursive=
 flag :-(

I've been pining for something easy and intuitive like git ls-files
<treeish>. You can do git ls-files --with-tree=3D<treeish> but I find i=
t
very counter-intuitive.

Context: in some projects, I need to ask

 - is this file in branch foo?
 - has this file moved in branch foo?
 - what files with extension .zoo exist in branch foo?

and the answer is git ls-files --with-tree=3D<treeish> | grep <regex> .
But the --with-tree param is so counterintuitive to me that I read the
manpage, everytime.

Not sure whether the bug is in me or in git, but it sure hits some
cognitive dissonance.


m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff

From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Building Documentation in Cygwin
Date: Tue, 27 Jan 2009 12:44:36 -0500
Message-ID: <c115fd3c0901270944p7a4b6cc5n5dfe9b2f268f038c@mail.gmail.com>
References: <c115fd3c0901270741h2f213b99s31bac8829bd182c2@mail.gmail.com>
	 <be6fef0d0901270832o1a176691nab5500a86c531795@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 18:46:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRs0i-0007R9-Ov
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 18:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbZA0Roj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 12:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754813AbZA0Roj
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 12:44:39 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:42310 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbZA0Roi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 12:44:38 -0500
Received: by an-out-0708.google.com with SMTP id c2so1478779anc.1
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 09:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HolehIcaBqX7RcKaNVb4QzZiDgVDwMZXoPK90VNGFsU=;
        b=RPrPKVOw27iCps8iTiLQqz2m0UI9W558Gb8qcYLp9n7LcPNNef6xYEqWGEB1JzjNaS
         0bvTK3yTKSwFQEZhGXuX6PfI+gftjaJIglqnfUic1OW+T/Ykkqd0/f5LMuiZdFLRUQEb
         dU2IKv3ybIlsdiRv2LFKg+z041vu9W9/hoMLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NWlAA83tmy8lW2+OZiUk30Nudd75MU3SZZ1dD0Vnm0afqYqd/C4yNhfWaLVbcpeY6r
         pgzVAOpkZMimQj7DSJyvZP/nfv5NZGyZGt9oeHpUIY6A5gsujrjDANP5ZeZXfWeGhICz
         A+noQRe1ah0NLlT6Xt9DzW5h5Mm5v7k06xcfg=
Received: by 10.100.107.3 with SMTP id f3mr1783005anc.28.1233078276985; Tue, 
	27 Jan 2009 09:44:36 -0800 (PST)
In-Reply-To: <be6fef0d0901270832o1a176691nab5500a86c531795@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107364>

On Tue, Jan 27, 2009 at 11:32 AM, Tay Ray Chuan <rctay89@gmail.com> wrote:

> try running xmlto in verbose, what does it output?

$ xmlto -v -m callouts.xsl man git-add.xml
Format script: /usr/share/xmlto/format/docbook/man
Convert to troff
Real stylesheet:
http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
xmllint >/dev/null --xinclude --postvalid
/home/tvishe01/projects/git/Documentation/git-add.xml
xmlto: input does not validate (status 3)
error : Operation not permitted
/home/tvishe01/projects/git/Documentation/git-add.xml:2: warning:
failed to load external entity
"http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"
D DocBook XML V4.2//EN" "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"
                                                                               ^
error : Operation not permitted
warning: failed to load external entity
"http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"
Could not load the external subset
"http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"
Document /home/tvishe01/projects/git/Documentation/git-add.xml does not validate

-- cut

It might be germane to mention that I'm attempting to build this on an
offline box.

> you might also want to try getting the cygwin package docbook-xml42.

Sure enough, I didn't have that installed.  Turns out I should've done
that part first too, as it appears to have fixed my problem.  Thanks
so much!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail

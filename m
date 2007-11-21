From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git in a Nutshell guide
Date: Wed, 21 Nov 2007 22:32:33 +0100
Message-ID: <200711212232.33791.jnareb@gmail.com>
References: <1195477504.8093.15.camel@localhost> <fhvs95$5qk$1@ger.gmane.org> <20071121194507.GA3569@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Nov 21 22:33:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuxCG-0008G6-Ko
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 22:33:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbXKUVci convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Nov 2007 16:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbXKUVci
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 16:32:38 -0500
Received: from el-out-1112.google.com ([209.85.162.177]:41768 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbXKUVch (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 16:32:37 -0500
Received: by el-out-1112.google.com with SMTP id v27so993047ele
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 13:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=FbskjBGOm2MSw/8en2p9/0s3aHa/WVBG41qRDOdpyTQ=;
        b=lHE9jT2E41lbbds020Vb2qv8qrKmRyFiVf+h/2fS17YEvlRFMkUDBz84tRn2dwbYHvrsx8O5PhZSCLiC/MItcSndwya1FNN6X9WVE8NpYtt7d49pok6UQuAAbS/R5nR90AXgwTAYF6OAoQ8OSqyNtFFgT+fxRgfnEMbunVums2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DstzimedrW/qgEO95qCylZVCrgf5vO7WDCnE6erP+B6UXTaI9QuF3QYn0p0t1YNaor9L41KUhOeY9YsRdgFEp7QKkRT26Fq5M2ecEW009+lau8nav3JLlQ6FMdh16GL2JXTqLeVCzboKK8ZWi02f+mu/LmqRgKNjQokkqYmlIXw=
Received: by 10.78.200.20 with SMTP id x20mr8950630huf.1195680755635;
        Wed, 21 Nov 2007 13:32:35 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.19])
        by mx.google.com with ESMTPS id e9sm400094muf.2007.11.21.13.32.33
        (version=SSLv3 cipher=OTHER);
        Wed, 21 Nov 2007 13:32:34 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20071121194507.GA3569@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65706>

Dnia =B6roda 21. listopada 2007 20:45, Jan Hudec napisa=B3:
> On Wed, Nov 21, 2007 at 00:57:28 +0100, Jakub Narebski wrote:

>>  2. Git has some historical cruft, including the fact that it began =
as
>>     series of low level tools (plumbing) and became proper SCM (acqu=
ired
>>     proper porcelain) later, what can be even now seen in documentat=
ion...

What I meant here that some of important documentation can be only
found in plumbing commands man pages.

>>  3. Explanation of some features (like object model) would be much e=
asier
>>     with some graphics (diagrams etc.), but chosen documentation for=
mat,
>>     AsciiDoc, doesn't make it easy...
>=20
> I dare to disagree here. Asciidoc supports generating image tags for
> respective output formats and it really does not look hard. We could =
have
> PNGs and if we wanted higher press quality even SVG or EPS and conver=
t them
> to PNGs for the HTML version (and use EPS for latex output).

The problem is that 1) language used to generate images must be easy
to understand and readable in text form (so sources are enough to
understand); 2) one of the main formats is manpage (although that would
not matter for "Git Guide" / "The Git Book").

Should we choose PIC? Or perhaps DOT? I can write little MetaPost, but
I don't think that would be good format for git diagrams, even if it=20
can be converted to PDF, SVG and PNG.

--=20
Jakub Narebski
Poland

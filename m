From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Fwd: permission to re-license strbuf subsystem as LGPL
Date: Fri, 23 Sep 2011 10:12:34 -0700 (PDT)
Message-ID: <m3mxdvqj31.fsf@localhost.localdomain>
References: <CA+sFfMeRDQiqGhO9Y=k3tEnzdXjMx59huFE_fx6Y14cJxj1J=Q@mail.gmail.com>
	<CA+sFfMcmsKkKM7C0g4vKmjmCCNqRHuvz-hwEHAm=+stqnOPpAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 19:12:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R79Io-0000u8-Cb
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 19:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022Ab1IWRMh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Sep 2011 13:12:37 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55984 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988Ab1IWRMg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2011 13:12:36 -0400
Received: by fxe4 with SMTP id 4so4013100fxe.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 10:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=Mc+0o0PGYo4Q1WtndgijeuyxRO3ojMQeb22iT4JbK94=;
        b=YdIw04/z/VCUnaYiRyY70biCRM951TBfwMl/6RkK28yea3UDF5ucZ725SpUhlcoLoD
         gcVmXCvKFNOJ37miH0IcocH6NeKcwKN6187ebcBTU9ao6Z3Z/dduYuEcRKEsteLqw18O
         tMWT1xCeAyCBgaRBf11D/WIID1q4xilk2kgPE=
Received: by 10.223.49.213 with SMTP id w21mr5444104faf.44.1316797955575;
        Fri, 23 Sep 2011 10:12:35 -0700 (PDT)
Received: from localhost.localdomain (abwe70.neoplus.adsl.tpnet.pl. [83.8.228.70])
        by mx.google.com with ESMTPS id w6sm11703055fah.0.2011.09.23.10.12.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Sep 2011 10:12:34 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8NHC8TB025884;
	Fri, 23 Sep 2011 19:12:18 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8NHC2jw025880;
	Fri, 23 Sep 2011 19:12:02 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CA+sFfMcmsKkKM7C0g4vKmjmCCNqRHuvz-hwEHAm=+stqnOPpAw@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181978>

Brandon Casey <drafnel@gmail.com> writes:

> ---------- Forwarded message ----------
> From: Brandon Casey <drafnel@gmail.com>
> Date: Thu, Sep 22, 2011 at 11:21 PM
> Subject: permission to re-license strbuf subsystem as LGPL
>=20
> To those who have contributed to git's strbuf subsystem,
>=20
> I'd like to turn git's strbufs into a library. =A0So with your consen=
t
> I'd like to re-license the code in strbuf.c and strbuf.h, and any
> compat/ dependencies as LGPL so that I can create a strbuf library.

That's a laudable goal.  Do you plan on librarizing other universal
mini-libraries, like parseopt or test-lib?

I wonder if for example "perf" tool in Linux kernel sources (userspace
companion to perf events subsystem) will move to using it; currently
it reuses some of internal git minilibraries, IIRC strbuf and parseopt
included.

By the way, how the 'strbuf' from git (which I think was created among
others to avoid additional external dependencies) differs from
existing C (not C++) string libraries, like 'bstring'[1], The Better
String Library, or the C libraries in http://bstring.sourceforge.net/fe=
atures.html?

[1]: http://bstring.sourceforge.net

--=20
Jakub Nar=EAbski

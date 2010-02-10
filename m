From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [RFC] submodule+shallow clone feature request
Date: Wed, 10 Feb 2010 17:10:07 -0500
Message-ID: <32541b131002101410j3c256dbeg9aa8bacde99886bb@mail.gmail.com>
References: <4B73277C.9010801@columbia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Schuyler Duveen <sky@columbia.edu>
X-From: git-owner@vger.kernel.org Wed Feb 10 23:10:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfKlX-00013W-8v
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 23:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977Ab0BJWKa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 17:10:30 -0500
Received: from mail-gx0-f224.google.com ([209.85.217.224]:53814 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295Ab0BJWK3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Feb 2010 17:10:29 -0500
Received: by gxk24 with SMTP id 24so540427gxk.1
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 14:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=cL/DJF51nMn0ZBoZzoxaPfJFvs14hfO450Lgno8MDaM=;
        b=HeMZgLoj78v1r7+bGgIIi7sU+chYXAoZVSHVA7puXIo3s2Hi7p7bfZUxtCUYP5Uivu
         A3BnecZ05CrjHWhjesJnIh+rm5eTIne+nRTDiLCihoDZyJb0dIfQrAcA8La++WEK3++r
         smVgNXxQBZwLoamjiQtrsI51iSqcdCtLIK05g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=d1D23L5lugyXkYEvjZsaY7khtFRDj0MHjeucq6pXzd+WC2eKpQLtN8AH49TjzTusTu
         2VKxFPNJ3S52aXXqadRg08ZAzkPqzlkM92aOBccJYIedDM+8AutVsDkMCBy95YuIPYE9
         SetYPW3iEtZVws1e+OhR8zM2Gl2uqYeWuM3cM=
Received: by 10.150.117.12 with SMTP id p12mr3359687ybc.254.1265839828752; 
	Wed, 10 Feb 2010 14:10:28 -0800 (PST)
In-Reply-To: <4B73277C.9010801@columbia.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139556>

On Wed, Feb 10, 2010 at 4:39 PM, Schuyler Duveen <sky@columbia.edu> wro=
te:
> 2. Some way to specify an override on .gitmodules sources. =A0This is
> because our .gitmodules includes public, read-only sources (github),
> rather than our local repos we would prefer to deploy from (for the
> purpose of reliability).

You can already override this by editing .git/config after running
'git submodule init'.  Of course, doing so precludes using --recursive
in "git clone."

> I'm not well-versed in the git source code yet, but poking around
> suggests that this is doable. =A0Would a patch be well received (or d=
oes
> someone want to do it for me :-)

The git-submodule stuff is rarely maintained.  I expect patches that
improve it will meet with generally positive response, but it's
somewhat unlikely that anyone will write them for you.

Have fun,

Avery

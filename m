From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] branch_merged: fix grammar in warning
Date: Fri, 25 Feb 2011 22:44:21 -0500
Message-ID: <AANLkTimN2ba8Ab2BRp=sU4NT_e6UYh4HH2L7afgEkHg8@mail.gmail.com>
References: <AANLkTikgmA8useucn0T6Gp7m5ang8iy-a--L_2HuOk9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Hanchrow <eric.hanchrow@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 04:44:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtB5U-0003n6-W7
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 04:44:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186Ab1BZDow convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 22:44:52 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59455 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab1BZDov convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 22:44:51 -0500
Received: by iwn34 with SMTP id 34so1626540iwn.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 19:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=1sDoEZ/2aSZwgaIaSzXxzjk/N9hv1jSCytFT9ebqyH4=;
        b=kSNbp69HOpglqp609XZSb59eFDcazefrNzTwrbevwMlLNgcyxTrfi/7Bk8v+TPncrq
         bIdNFOW3nc+8RddcFJBQriNq4AfTx+Xdb4olIOHImcDVtAne4OWsaDAQPDpGXI3UfcnA
         Z0ibD//4sfEYXIPVZdKAuWV/WUX2XEAfpd+MQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ot8IuUFOE7SIO5aTWaMfg6JqPdJ8Cr7VCocZ592N6S5IjwIdwfNRP+n5FvZ1MSA0ow
         RNr7y4kfi4pgsq9cVdXzq3K3av/4irrZmjxve8Di2fkQ/Hucz13Lr6DOFhfiW56Pt7kW
         izsuDExo7L/6UufFhOrtrB+6uuq/mHTMSyqp8=
Received: by 10.231.37.70 with SMTP id w6mr3398486ibd.169.1298691891103; Fri,
 25 Feb 2011 19:44:51 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Fri, 25 Feb 2011 19:44:21 -0800 (PST)
In-Reply-To: <AANLkTikgmA8useucn0T6Gp7m5ang8iy-a--L_2HuOk9d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167953>

On Fri, Feb 25, 2011 at 10:33 PM, Eric Hanchrow <eric.hanchrow@gmail.co=
m> wrote:
> =C2=A0builtin/branch.c | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 9e546e4..915f270 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -134,7 +134,7 @@ static int branch_merged(int kind, const char *na=
me,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in_merge_bases(rev, &head_re=
v, 1) !=3D merged) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (merged)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0warning("deleting branch '%s' that has been merged to\n"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 " =C2=A0 =C2=A0 =C2=A0 =C2=A0 '%s',=
 but it is not yet merged to HEAD.",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 " =C2=A0 =C2=A0 =C2=A0 =C2=A0 '%s',=
 but it has not yet been merged to HEAD.",

You can drop the "it" while you're at it. :-)

j.

From: Dilip M <dilipm79@gmail.com>
Subject: Re: force "unmerged" for same-file auto-merges
Date: Sat, 27 Mar 2010 22:52:25 +0530
Message-ID: <c94f8e121003271022v2b30ef52j3bd4015f12938f7a@mail.gmail.com>
References: <hobqoc$5h3$1@dough.gmane.org> <hoh16f$koe$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 18:22:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvZiR-0005Sb-Gk
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 18:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714Ab0C0RW0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Mar 2010 13:22:26 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:60214 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab0C0RW0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Mar 2010 13:22:26 -0400
Received: by ywh2 with SMTP id 2so4138225ywh.33
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 10:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DlHl1mC8fWNLKE5mvI8Bdg9LrzPQSbkCyIHLW21XJ/E=;
        b=bq7ogbiT3pPMSTIMVSZc2pm8S81+nkz3mrbRJyYx1jl92+GTKhRkUxY5tkRjaaHNgE
         vIGutG0a3ET8ftf5VAfgF+L9uuCswn4arbUD3QgThW4sjva258Ulc+tx/Kh7FkL06DSJ
         iKkKnZqxZuyWTYbd5f6Ytkot2+5VDEFj0bE8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PAOOwcQIO+57LVD2ZRpVOAklkiDJfjbzgyDg2SBH4LodYakLDfHGamVMZ9o4XzroIH
         DbjzxKQaGpf/aSLrhjbCBGugcxwpIGXNxq3QCCeegJdZbE9bn5vzzII4vuocephSPH6x
         N1WzNQ7HwA3qEFlu7rOTpjtH3IAHt9Qw4wHYM=
Received: by 10.150.153.6 with HTTP; Sat, 27 Mar 2010 10:22:25 -0700 (PDT)
In-Reply-To: <hoh16f$koe$1@dough.gmane.org>
Received: by 10.151.86.13 with SMTP id o13mr2967056ybl.181.1269710545394; Sat, 
	27 Mar 2010 10:22:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143340>

On Fri, Mar 26, 2010 at 6:34 AM, Neal Kreitzinger <neal@rsss.com> wrote=
:

> In other words, when two people modify the same file in different pla=
ces I
> want the automerge results file, but I want the resulting file marked=
 as
> unmerged so the programmer can then run git-mergetool to review the m=
erge
> results. =C2=A0This also prevents the programmer from running git-com=
mit
> immediately after the automerge without reviewing the merge results. =
=C2=A0Can
> "mark automerge of samefile as 'unmerged'" be done in git via config
> settings or command options?

What about merge with '--no-commit' option and than doing 'diff --cache=
d'. You
have option of still seeing what merged and decide to reset or commit.

--=20
Dilip

From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git to p4 conversion
Date: Sat, 5 Feb 2011 01:11:06 +0000
Message-ID: <AANLkTimV1aRiEMa2z-H2bOvRa9H6YAyET1=hn+_O0-0u@mail.gmail.com>
References: <AANLkTi=0TSD6p7WtsVzx=pq8=GVu+jHUdxt1bnC++CT+@mail.gmail.com>
 <4D4AF29E.7070509@vmware.com> <AANLkTikW_sU8oCmU9wN5q1OPPJrQbS2YZAvS0C_nBQbD@mail.gmail.com>
 <loom.20110204T004658-497@post.gmane.org> <AANLkTikfGapDfZtD9H10797Ted_Av78WD8M7XrACOCpW@mail.gmail.com>
 <AANLkTimrwUxNOAnfxgvReGN+-h4_0jhZ731y22TB6u1K@mail.gmail.com>
 <AANLkTi=_spLE-KMnou-2LLQjwq4FUZxNr9pk7D9C=4PK@mail.gmail.com>
 <AANLkTi=dZdSqcNckyU7Lb2Zj-khfj=Xiyzbv7LSC+zT2@mail.gmail.com>
 <AANLkTimGaPQ=hRp+2pvw-hAOg+wp50nvc_sv9jNTay=n@mail.gmail.com>
 <AANLkTimJm81V0D8_j3OfZTcEkyn_jd6_QB2nv8T69JBY@mail.gmail.com> <AANLkTi=onuZtGWPTYvw_-rKsR6t-R2UquAUPLHAm-TVV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Endre Czirbesz <endre@czirbesz.hu>, git@vger.kernel.org,
	Ian Wienand <ianw@vmware.com>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 02:11:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlWgh-0000bt-Dw
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 02:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262Ab1BEBLi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Feb 2011 20:11:38 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47387 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab1BEBLh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Feb 2011 20:11:37 -0500
Received: by vxb37 with SMTP id 37so932466vxb.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 17:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=MiRszo14/PVwKX7Ife7ZyruGOEw3DEWcqzVPdJS5tnY=;
        b=GgtqDjVkUf4VkCufUF0vk1svF2nPae1ZPSuFYq9+Rf/TyPm2Kdtp3Zo0HfjkLv26DF
         4a3Fhw4AC2/7kWbCVXtItX1cXkkopCBaPjFTPwbq4vdW2/XBE4uuYbez4ZysvoHxMgSS
         /Rd7EUWEneV+YkJbvOOkSrbDUUYLZ0cwu/yFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XsVTvxScobGOO93JoexV2x3qugXQ7uaW9qoeSs3dm0nXqnpNfT6wrF15jj5KDjoAJp
         gKr0f5Dh9mD/lTwZ9ZG6tFYprWYvaRjVB3rAYtAbk0Lys41eSr4x3TIGEMupqjjZoPQ9
         vPO+qOCg1SbDx5YycYooty1jMqGOtoi/9T3OY=
Received: by 10.220.198.196 with SMTP id ep4mr3416678vcb.110.1296868296660;
 Fri, 04 Feb 2011 17:11:36 -0800 (PST)
Received: by 10.220.184.75 with HTTP; Fri, 4 Feb 2011 17:11:06 -0800 (PST)
In-Reply-To: <AANLkTi=onuZtGWPTYvw_-rKsR6t-R2UquAUPLHAm-TVV@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166069>

Hi Tor,

On Sat, Feb 5, 2011 at 12:53 AM, Tor Arvid Lund <torarvid@gmail.com> wr=
ote:
> I... wonder if we're maybe talking past one another here...
>
> Let's take a few things from the top, just in case... If we think
> about the perforce setup (before we start doing any git stuff)... You
> have a perforce workspace/client-spec, right? That is - a setup that
> tells perforce where you want the files to be placed on your hard
> drive when you do a standard "p4 sync". Let's call it ~/p4root/ and
> let us say that your project will then be synced by perforce to
> ~/p4root/myproj/
>
> When you want to do a git-p4 clone, you should definitely be *outside=
*
> of ~/p4root/ . Let's say we have a ~/gitroot/ as well. So do cd
> ~/gitroot/ so that the git-p4 clone will be under ~/gitroot/myproj/ ;
> and then do all the git-p4 stuff (clone, add remote, fetch, rebase,
> sync, submit).
>
> I think Vitors point was that before you do git-p4 submit, you should
> clean - not ~/gitroot/myproj - but ~/p4root/myproj/.
>
> This is probably not something that you need to do everytime you want
> to submit back to perforce, but since we have had some rounds with
> trial-and-error with this, we have probably placed some dirty files
> inside the perforce folders... Make sure that you don't have files
> opened in perforce before you sync.
>
> Clearer? More confused? Best of luck anyway :)
>
> =A0 =A0-- Tor Arvid
>

Yeah, I think we're in sync here. I'm almost sure your (much more
detailed) instructions will solve Endre's problem :)

Kind regards,
--=20
Vitor Antunes

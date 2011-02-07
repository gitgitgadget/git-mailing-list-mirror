From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: git to p4 conversion
Date: Mon, 7 Feb 2011 15:13:03 +0100
Message-ID: <AANLkTikCVNoxyNezHVM=8gg6wZNzhV2eOytL952SSP3s@mail.gmail.com>
References: <AANLkTi=0TSD6p7WtsVzx=pq8=GVu+jHUdxt1bnC++CT+@mail.gmail.com>
	<4D4AF29E.7070509@vmware.com>
	<AANLkTikW_sU8oCmU9wN5q1OPPJrQbS2YZAvS0C_nBQbD@mail.gmail.com>
	<loom.20110204T004658-497@post.gmane.org>
	<AANLkTikfGapDfZtD9H10797Ted_Av78WD8M7XrACOCpW@mail.gmail.com>
	<AANLkTimrwUxNOAnfxgvReGN+-h4_0jhZ731y22TB6u1K@mail.gmail.com>
	<AANLkTi=_spLE-KMnou-2LLQjwq4FUZxNr9pk7D9C=4PK@mail.gmail.com>
	<AANLkTi=dZdSqcNckyU7Lb2Zj-khfj=Xiyzbv7LSC+zT2@mail.gmail.com>
	<AANLkTimGaPQ=hRp+2pvw-hAOg+wp50nvc_sv9jNTay=n@mail.gmail.com>
	<AANLkTimJm81V0D8_j3OfZTcEkyn_jd6_QB2nv8T69JBY@mail.gmail.com>
	<AANLkTi=onuZtGWPTYvw_-rKsR6t-R2UquAUPLHAm-TVV@mail.gmail.com>
	<AANLkTimV1aRiEMa2z-H2bOvRa9H6YAyET1=hn+_O0-0u@mail.gmail.com>
	<AANLkTimP81rVPwvpaCSgBJiZ2Jm131+Q9E-Fkj0-jZfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org,
	Ian Wienand <ianw@vmware.com>
To: Endre Czirbesz <endre@czirbesz.hu>
X-From: git-owner@vger.kernel.org Mon Feb 07 15:13:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmRq7-0007gI-J0
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 15:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031Ab1BGONG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 09:13:06 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61496 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269Ab1BGONF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 09:13:05 -0500
Received: by yxt3 with SMTP id 3so1700263yxt.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 06:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=h3OdFtc4DfrWrDlpQNEHT6G4IdKRdsZNCLdf1N2+5VU=;
        b=mRMCfUTYHU5a1a1yGbSVduuMm2b0aI06tavWaykVys3r4u1wMO+9YIRl+v/nNQXbIf
         Zd+JLm0tPUOdW0LEOIuxxCY8wZyqCVD6uic9K3kUNhMuVHdTMrQwa+GebCtkIdmGBH5J
         9dDdnI67QiUM17prZWWnc/ZEwVonSjC9Uxjo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DFNwrwc0xih8SLmZtiukLjdZQkgPixZ77lKiEWYySjtDB19SAY4yg7TLMdBCJk5hmH
         veirZqfRSiCZZxuz3RE6so3uW53zP9XOkLCgYzxW+Xqgyy1Bi7r/mdzAWCNxeX7ypzyI
         T4nFiPLUQ4tyldnN9gM9Nv7sIPH2t0js7uoU4=
Received: by 10.101.165.31 with SMTP id s31mr9704365ano.216.1297087983497;
 Mon, 07 Feb 2011 06:13:03 -0800 (PST)
Received: by 10.101.1.19 with HTTP; Mon, 7 Feb 2011 06:13:03 -0800 (PST)
In-Reply-To: <AANLkTimP81rVPwvpaCSgBJiZ2Jm131+Q9E-Fkj0-jZfd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166262>

On Mon, Feb 7, 2011 at 2:57 PM, Endre Czirbesz <endre@czirbesz.hu> wrote:
> Hi,
>
> Thanks for your patience and the detailed help.
> I forgot only one thing, that I need two separate directories... :)
>
> So, after some minor mods in git-p4 (I have some directories with
> spaces, and some files with #@*% in their names), it seems as if it
> worked, my files are in P4 depot, although I got an error message:
>
> Failed to merge in the changes.
> Patch failed at 0001 Initial commit
>
> When you have resolved this problem run "git rebase --continue".
> If you would prefer to skip this patch, instead run "git rebase --skip".
> To restore the original branch and stop rebasing run "git rebase --abort".
>
> Exception: command failed: git rebase remotes/p4/master

Maybe you could run "git p4 submit --verbose"? (the 'verbose' option
might give you a clue as to what the underlying problem is)

    -- Tor Arvid

> Regards,
>
> Endre
>

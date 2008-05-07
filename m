From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: inconsistent detached worktree handling: several bugs
Date: Wed, 7 May 2008 21:20:42 +0200
Message-ID: <8aa486160805071220v50026bf9ga5a8ae4314bffadc@mail.gmail.com>
References: <20080505160643.GA28318@lapse.madduck.net>
	 <8aa486160805070115k676b03a6s59d3a74d48d44254@mail.gmail.com>
	 <20080507180637.GA2282@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git discussion list" <git@vger.kernel.org>
To: "martin f krafft" <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Wed May 07 21:21:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtpCw-0003rU-Ee
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 21:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933114AbYEGTUt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 May 2008 15:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbYEGTUs
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 15:20:48 -0400
Received: from ik-out-1112.google.com ([66.249.90.183]:18248 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933182AbYEGTUq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 May 2008 15:20:46 -0400
Received: by ik-out-1112.google.com with SMTP id c28so173585ika.5
        for <git@vger.kernel.org>; Wed, 07 May 2008 12:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=UD4okZaoxbKCzt88eNAKRUpyjKx0pa4td8ml5//h76g=;
        b=dfzypQwM95DdZDNNg0Rh2vwxiPZvz9VHgcA3Nft8LufiM+SOnWelgiY4B4LjX9YLL4ExAyvF81IVs9NQ2+ipR0gbITVv646JjdLk2vdMESXyTyBHg+VkoI6R2C/mjJ8lYR5rfjX4oMFW9pIZxoKSctqli2JossJTv7M/MTAxAsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ten0+M5z5QukBE8HgKnWByPT8CTKtRZL6Lfn+1b1xWnjRen8YAzAOUddjJZXhi0TRV88kkyluQgmJ27jJGS9iNBlERu8EIN+Z+2BTqB8qQaygodbQww78tlf3+6HF92deslgENgX0hjLmMJuHwtUkyDudk1ISlnhSp20WEQvy+8=
Received: by 10.150.50.2 with SMTP id x2mr2516105ybx.34.1210188042636;
        Wed, 07 May 2008 12:20:42 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Wed, 7 May 2008 12:20:42 -0700 (PDT)
In-Reply-To: <20080507180637.GA2282@lapse.madduck.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81473>

On Wed, May 7, 2008 at 8:06 PM, martin f krafft <madduck@madduck.net> w=
rote:
> also sprach Santi B=E9jar <sbejar@gmail.com> [2008.05.07.0915 +0100]:
>
> > I don't know if it resolves all the issues, but:
>  >
>  > - If run outside of the working copy =3D> equivalent to run it fro=
m the
>  > top of the wc.
>  >   (for the normal case it just fails)
>
>  This is not what the output of git-status suggests:
>
>  lapse:~|master|.fgits/zsh.git% git status                           =
     #1,801
>
> # On branch master
>  # Changed but not updated:
>  #   (use "git add <file>..." to update what will be committed)
>  #
>  #       modified:   ../../.zsh/zshrc/30_aliases
>  #
>
> no changes added to commit (use "git add" and/or "git commit -a")
>
>  If, what you said were the case, it'd be .zsh/zshrc/30_aliases.
>  ../.. is the setting of core.worktree.
>

So it is run inside the worktree ( $workingdir/.fgits/zsh ) and the
repository is inside the worktree.

>
>  > - It is not recommended (supported?) to have the repository inside
>  > the working directory (unless it is .git, of course)
>
>  Why not?

I read it in this list but I don't find it now. Maybe because of the
special handling of .git does not apply to an arbitrary path.

Santi

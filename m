From: knittl <knittl89@googlemail.com>
Subject: Re: set-upstream for existing branch...?
Date: Thu, 17 Feb 2011 10:25:32 +0100
Message-ID: <AANLkTimPYkEczv=suCr02rVb3OSg_h9o88_5CEmonPTR@mail.gmail.com>
References: <buoei77xmpc.fsf@dhlpc061.dev.necel.com> <AANLkTikqj8NjLwR647E1tHUuDO=OitUJ1dm5Fs7gtXXt@mail.gmail.com>
 <buo8vxfxhhy.fsf@dhlpc061.dev.necel.com> <AANLkTim6HDCaeTDuEtK+3niKKoz6A3KA=m=UCr4DaY-V@mail.gmail.com>
 <4D5CDB01.9070502@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Miles Bader <miles@gnu.org>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 17 10:26:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq07e-00024k-Ll
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 10:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877Ab1BQJZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 04:25:58 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48551 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab1BQJZy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 04:25:54 -0500
Received: by pzk35 with SMTP id 35so336013pzk.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 01:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=D/en43/RJUkE88tRn2L1rFRbp23Jb1rxla2Zl8mWdbk=;
        b=TB+Gsa6ln2sX5zDXirAWUFe1z8O6Gaj26ue2Qg98gADChBSCw/fxl5Io9l6YL2kJLr
         9ij+HQ6DLuAsucSya2/S3IWHfpJKb5AyBUVV7es0x7R0nwxWKEsOwPGUAnbklnEysLxd
         iioErhd76AEn0kwrNpMKumdcMxyFj5Zz2CoT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=FJLm8me9A3cmk6+KcdNj3BbDrZXTXCicYIg7mv7JllYJW9ljWv7MKaUAvsGEIEo+TW
         uyBynIg+GImJsIwvJqMjU1ccGBZtpoKWcrV0k5LPMmlOTrp4SUl06do+a+Z+HtQDiFKj
         r+0LWEDamGbCsIFewTB3REYh5q7Y8SVOE1uco=
Received: by 10.142.241.13 with SMTP id o13mr1292055wfh.9.1297934753448; Thu,
 17 Feb 2011 01:25:53 -0800 (PST)
Received: by 10.143.4.16 with HTTP; Thu, 17 Feb 2011 01:25:32 -0800 (PST)
In-Reply-To: <4D5CDB01.9070502@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167059>

On Thu, Feb 17, 2011 at 9:23 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Miles Bader venit, vidit, dixit 17.02.2011 08:24:
>> Hmm, on a related note, is there an obvious way to _show_ the current
>> branch's upstream...?
>>
>> [I mean, which just prints out "origin/master" or whatever...]
>>
>> Thanks,
>>
>> -miles
>>
>
> git for-each-ref --format="%(upstream)" $(git symbolic-ref HEAD)
>
> I can't come up with a better way of expanding @{u} without resolving
> the resulting refname to a SHA1. You could do

what about

    git branch -vv

it will show all local branches with their upstream plus behind/ahead numbers

cheers,
daniel


-- 
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!

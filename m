From: =?ISO-8859-1?Q?Daniel_Fran=E7a?= <daniel.franca@gmail.com>
Subject: Re: error commiting in Git
Date: Sat, 31 Jul 2010 19:50:17 -0300
Message-ID: <AANLkTimmgU1SJaWZuDmSfuU05yBsUzvcnd9i4c7p2d5+@mail.gmail.com>
References: <AANLkTimOZr8zq8uXdrzrpLMTDQqwJkZEyxB_zcWFEYBs@mail.gmail.com> 
	<AANLkTimqWF7gZHAXFOmz0URdDTF=CfMmjJrBwmFavUkK@mail.gmail.com> 
	<AANLkTi=n-J5rMOz0pkcxQZ7VgGs_EtXpotO=wZoDyz=C@mail.gmail.com> 
	<20100731223356.GB7490@burratino> <AANLkTi=ExhKbUC4yqmPudD_=SpGxxV6MUm-bhaycSJOu@mail.gmail.com> 
	<20100731224351.GB7678@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 01 00:50:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfKtL-0005rQ-Og
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 00:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604Ab0GaWul convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 18:50:41 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42054 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab0GaWuk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Jul 2010 18:50:40 -0400
Received: by pvc7 with SMTP id 7so950020pvc.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 15:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=NTdK12x92umKNtuH8qv/NBmJLb8EyDB4iThZ9ot66KQ=;
        b=C+QOtEBgRvanlyQ/fb2M43XEplmNk2bVg2hnA57MLd6LZdjr0V31h7mx7v40PDQAFu
         H08jatZaE/cD/Fi95lA+unwp1NSr+2KldN3JH+Sbi+06GdSHUBwWY6t61z6LT0ZKT6FS
         f/X5mH43HgTt02l1ktPXHjx3s8NdfCcXcVI18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NkvKsyYu+dMfawmczM2kiWzjg9O/gqbc+XEfUeAUZ/FRwlS8as43yUURlaAIhclDSh
         8mCcW4J7YGHwXy8OHgUog00tDxcBpk1jNDcNyYpvz3fMCF1uxAIql+kPPdi0P9hWa87L
         BFd9Bd48noEv8ZDlP3Wipc3Ka6pzEmIGaWb20=
Received: by 10.114.172.2 with SMTP id u2mr4578680wae.198.1280616637129; Sat, 
	31 Jul 2010 15:50:37 -0700 (PDT)
Received: by 10.115.23.7 with HTTP; Sat, 31 Jul 2010 15:50:17 -0700 (PDT)
In-Reply-To: <20100731224351.GB7678@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152346>

thanks, I'll look that, I've the stupid habit of click reply instead
of reply to all :P

2010/7/31 Jonathan Nieder <jrnieder@gmail.com>:
> Daniel Fran=E7a wrote:
>> 2010/7/31 Daniel Fran=E7a <daniel.franca@gmail.com>:
>
>>> git commit -a -m 'Teste'
> [...]
>> the output:
>> find: illegal option -- n
>> find: illegal option -- a
>> find: illegal option -- m
>> find: illegal option -- e
>> find: *.pyc: No such file or directory
>
> Ah, you have a pre- or post-commit hook. =A0Take a look at
> .git/hooks and you may find something interesting. :)
>
> Good luck,
> Jonathan
>

From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Merging (only) subdirectories
Date: Wed, 1 Dec 2010 11:56:55 +0000
Message-ID: <AANLkTiki=BAZJ+xhDZaaOkfejJdvj4zeLRpyHbJ-cu8b@mail.gmail.com>
References: <AANLkTimZc0r8WBOsE73V=7SKdZgONiCKfYCk7rBrCY3F@mail.gmail.com>
	<20101201114759.136280@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Martin_Kr=FCger?= <martin.krueger@gmx.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 12:57:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNlJC-00033I-K5
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 12:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856Ab0LAL46 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 06:56:58 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39826 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab0LAL44 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 06:56:56 -0500
Received: by gwj20 with SMTP id 20so3324977gwj.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 03:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=1rOdSO+nfsg8EKmJKBZToPQIoDShiLWR/KdTQPHvsh4=;
        b=AL7Z9hO+8mT3TaPJrb7Z7TIqKmYVRawwHq5M29uXZeLsELGldx/SclfT9YVLFev8lG
         lr07LG/01xrHuK6DGUjpNfqGYyc79VefN596ooo8mibU3KiiDHd0L5MVjeQybs+7ptEn
         CctEQ5c8jfNp0KsY/liJYXutZn7iPrqOYw0R8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=I/MyVfLaBuHX7PJWKtnsUwv9P1NQHQ90+JrYTwN1Kd3oXEcI7szue9gAXvP4rRN1CE
         cG1FVIgAXKwPCqWPkCRLmBZ+KvYlSz3pSs9DxExQxCIJ3PSXpub3be8rHkUReEOvuTlZ
         8SUVeBIsKC89TLa56S1UClB7eviF96C8jc6tY=
Received: by 10.100.80.8 with SMTP id d8mr887121anb.108.1291204615822; Wed, 01
 Dec 2010 03:56:55 -0800 (PST)
Received: by 10.100.38.15 with HTTP; Wed, 1 Dec 2010 03:56:55 -0800 (PST)
In-Reply-To: <20101201114759.136280@gmx.net>
X-Google-Sender-Auth: M4eQN2Hv0jMTzbjyX4RIJXafgBg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162501>

2010/12/1 "Martin Kr=FCger" <martin.krueger@gmx.com>:

>>
> I would say you are not working best practice with git. The idea of c=
ommit is a atomic =A0change of the whole project. =A0It seems like you =
mixed completely unrelated changes in a commit.
>
> You can try as a resolution:
> git rebase master =A0(on a temporary-branch)
> git format-patch master
>
> Strip the patches with filterdiff
>
> Apply the stripped patches to another temporary-brach.
> Merge to the target-Branch.
>
> Best regards
> =A0 =A0 martin

thanks Martin,

There's a whole bunch of stuff there that I am not familiar with so I
need to do some reading!  When you say we are not using best practices
can you elaborate? I am very open to improving the way we do things.

Howard

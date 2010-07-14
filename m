From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Merging branches
Date: Wed, 14 Jul 2010 01:24:52 -0400
Message-ID: <AANLkTimFGQg1KEqpVBvifrLR8_BH_p6s6qswn614s58q@mail.gmail.com>
References: <1279056529462-5289861.post@n2.nabble.com> <AANLkTikPdOVCs5aB7Gs5QCFGDIgBm00DO5XPkP39mzIW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jhapk <pradeep.kumar.jha@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 07:25:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYuTA-00026y-NY
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 07:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526Ab0GNFZO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 01:25:14 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50567 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab0GNFZN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jul 2010 01:25:13 -0400
Received: by gwj18 with SMTP id 18so3183953gwj.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 22:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=1EMNaKBGRjZB40QkH6Z/nglAbmAaMJPgMOxrQl+BrpA=;
        b=AEwe9LnSujvFtv7ztf1m7aZll3MQhzu6kO51FbxM5+5Bt2gHSr1zw+MXJQQqY5YN0C
         09MH+gnpD0kA56HIA1u65wI6SB0rleiWg1sAJcWdGGmOclCXirmiZVTB4oammh32lLj6
         r4S8q29aGUAdWDhAyhOFkdBpgR+5Bq61Vdemw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hIqg6b2C4fikIFZrcia2nGP/zx4kWNhjeZ/1NgU5bTqrWgK98B6Ux5zLV4Vrufos5a
         Cybv97slBKYkmjzj1lUftpqeJSxqBauHTLNftBLq7wGcJXQsc9CkmlzGA5Op9EZaZu9b
         xxgStBvVivmWIUrIZy2R6Of/MQ9fRxvToBv94=
Received: by 10.150.52.11 with SMTP id z11mr7930309ybz.274.1279085112367; Tue, 
	13 Jul 2010 22:25:12 -0700 (PDT)
Received: by 10.151.85.19 with HTTP; Tue, 13 Jul 2010 22:24:52 -0700 (PDT)
In-Reply-To: <AANLkTikPdOVCs5aB7Gs5QCFGDIgBm00DO5XPkP39mzIW@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150965>

On Tue, Jul 13, 2010 at 6:05 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Jul 13, 2010 at 21:28, jhapk <pradeep.kumar.jha@gmail.com> wr=
ote:
>> I have a git history which looks something like as in the figure abo=
ve. I
>> want to merge Branch A in Branch B. However, the commits a1, a2 and =
a3 are
>> ugly and so I don't want those commits in my Branch B log. Is there =
anyway
>> that I can only pull the final form of Branch A without pulling the =
whole
>> history of Branch A?
>
> Yes, you use rebase to squash or drop those commits, and then merge t=
he branch.

Or just "git merge --squash".

Have fun,

Avery

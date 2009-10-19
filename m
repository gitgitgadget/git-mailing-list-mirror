From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: denying branch creation in a shared repository
Date: Mon, 19 Oct 2009 11:08:27 +0100
Message-ID: <26ae428a0910190308t3233debdjfc0c8beedb9c0ac6@mail.gmail.com>
References: <ee22b09e0910190132u20931fb4i6a98fb87582a9e56@mail.gmail.com>
	 <alpine.DEB.1.00.0910191155310.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mohit Aron <mohit.aron@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 19 12:15:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzpGw-0002lu-BJ
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 12:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747AbZJSKPK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Oct 2009 06:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754732AbZJSKPJ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 06:15:09 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:36751 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724AbZJSKPI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Oct 2009 06:15:08 -0400
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Oct 2009 06:15:08 EDT
Received: by ewy3 with SMTP id 3so3403580ewy.17
        for <git@vger.kernel.org>; Mon, 19 Oct 2009 03:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=03oeaydZeN1ejF26EAnguTyGohnStHi8jDjgA05kZyI=;
        b=SV83C4vAcwoR1MAfhfeWm5lLnr5gdGRsaezStz2s/1948B3c4uxA6KGqOEob6PdJh5
         KIlhrcIQW2O7rVcfO3rSv8YHzto3LPvokzGi/eB2TKyPq+LgsaZ3FLawNMEJI7bmbiUB
         1VHiZI6AEBPTBgOkNovNZXgdhEPrLY0jeOI5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=MjL+NCfamzDMvmsVxPMNXkknwS67me/ucjLk7LPh/I6ZYF64C/fCNzRpk5k2fd//Mq
         Lllquno1aRxLO+Bl8L4JRZ8KxPYLa3QG3WlwXq8x3Kn73tSXJ8a15fiFDF3ZkM+AHWVE
         A6x5DP0ohyTgWha+452Txzr8RaiYPueI/dj7w=
Received: by 10.216.88.68 with SMTP id z46mr1628187wee.27.1255946907297; Mon, 
	19 Oct 2009 03:08:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0910191155310.4985@pacific.mpi-cbg.de>
X-Google-Sender-Auth: 9ecca55e69384ad1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130688>

Hi,

I'm quite interested in this too but I can't see what that patch does
at all. I'm unsure what the 'mob' account is but a search suggests
it's something to do with anonymous access, which doesn't seem to make
any sense.

Can you explain?

Thanks!

2009/10/19 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Mon, 19 Oct 2009, Mohit Aron wrote:
>
>> I'm setting up a shared repository and I'd like to prevent users fro=
m
>> creating branches in it (they can of course create local branches in
>> their own clone of this repository). How can I accomplish this ? I
>> looked at 'git help config' and it seems I need something similar to=
 the
>> parameter receive.denyDeletes - this prevents deletion of branches.
>
> The easiest way to accomplish things is to look who had the same prob=
lem
> and solved it:
>
> http://repo.or.cz/w/repo.git?a=3Dblob;f=3Dupdate-hook;h=3D98b419ecad6=
1f6c80f;hb=3D6f92e96db0d605bed50db99029172607af301792#l16
>
> Hth,
> Dscho
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

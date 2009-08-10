From: Rostislav Svoboda <rostislav.svoboda@gmail.com>
Subject: Re: .gitignore vs untracked working file
Date: Mon, 10 Aug 2009 14:59:57 +0200
Message-ID: <286817520908100559u6cdcaab0u3a7fdb92cd43eed9@mail.gmail.com>
References: <286817520908100257n35b178ebu387161658554b4a@mail.gmail.com>
	 <20090810100148.GB22200@pengutronix.de>
	 <286817520908100317k4e98faf9n4e852b7abd4719fe@mail.gmail.com>
	 <4A800785.8050909@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Mon Aug 10 15:00:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaUUK-00038q-M3
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 15:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639AbZHJM76 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2009 08:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754550AbZHJM76
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 08:59:58 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:43981 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599AbZHJM75 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2009 08:59:57 -0400
Received: by bwz19 with SMTP id 19so2548091bwz.37
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 05:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=+WmN6+QtB4OVWG8u7WqI63sYAOtglQdhuUdHKA4QhW0=;
        b=jeh5eVj6Dh2f5cBxgmgS+MVYMlY0ESLbi0Oo9GM7j3KgJEMs5MCF9islH5ZnKlu8ZA
         cfBgiDM7Ovc9As//U7LqZP6m7lpHzcHZmU4+n6kvB/rBSgRHS7J3JCDuJj57D1wb0QNR
         byQWoIGnvM8cc1zsNBUvNTQe8kgKu5pXRNL0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=UiRGm4Gjgv0xJn3xA1ZWpOg5w6Xog/DJ1z3oc9Y5qsVTDE1+jtw3c5cevFtrwLwCuO
         td07yr+nfcDcGm8TkzunvGVFRHfcDLFWzKlsNxMM1wTvJYIoeFmuWiyMG5AoNTKpBas3
         jep2QIKaz23XSLC8xwi21vQyoSim9czmdmulQ=
Received: by 10.239.180.133 with SMTP id i5mr474964hbg.22.1249909197373; Mon, 
	10 Aug 2009 05:59:57 -0700 (PDT)
In-Reply-To: <4A800785.8050909@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125439>

2009/8/10 Johannes Sixt <j.sixt@viscovery.net>:
> Rostislav Svoboda schrieb:
>> 2009/8/10 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
>>> Hello,
>>>
>>>> $ git checkout master
>>>> error: Untracked working tree file 'Project/bin/path/file.jjt' wou=
ld
>>>> be overwritten by merge.
>>> What is the output of
>>>
>>>        $ git ls-files master bin/
>>
>> Nothing:
>
> It should have been
>
>        $ git ls-tree master bin

Merde!

$ git ls-tree master Project/bin/path/file.jjt
100644 blob 8d5e24f12c37fd1a435de2d4402591f5b0c2a3cc
Project/bin/path/file.jjt

There's a file.jjt in the repo already! But guys! I bet I'm not the
first one having this problem. Do you think it would be wise to have a
kind of a check returning
    'The file '...' ignored in the branch X is not ignored in the
branch Y (or something)'

instead of responding questions like mine over and over again?

Bost

PS: ... and yea, thx a lot!

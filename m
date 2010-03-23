From: Jacopo Pecci <jacopo.pecci@gmail.com>
Subject: Re: Master branch not updating
Date: Tue, 23 Mar 2010 09:34:15 +0200
Message-ID: <295c22191003230034m63eec998wf2f8e552fb28b07c@mail.gmail.com>
References: <295c22191003220943o2ef330ddk58a8180411ddbb2b@mail.gmail.com> 
	<4BA7A640.1080207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 23 08:34:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtydQ-0000o3-2t
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 08:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822Ab0CWHei convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 03:34:38 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:63725 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab0CWHeh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 03:34:37 -0400
Received: by fxm5 with SMTP id 5so2427042fxm.29
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 00:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=QdiC6Eza/qtKy8V4MfDnDfBEZdjwsi9jDvdDNRQwOcI=;
        b=FxOwRS/osLhOD6ytpXV2FvQRTqd2L+qGpxeXbTRki12RT0e+UX8N4zy7vM5esvzBx/
         AkyctDUo+h4FP/oQ29JYAQ4Sc2iuEhSxTyHcYFoybSWl4XcXo6H26WCkpfImbYRDc/ps
         0NzziaPDqnCSwq07KGJf6RDNQi7odBCIBlWx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pswa2ExKewQUg5+U+me9ghTdFBMXm4N+hWiJzjUwARfhdUE6PpcYA+RIPmb69Ki8MX
         wAKflzv01/Oh6AUe8xHFB7D1lfC/Z1lIA5uz653Rjlw6rgjqzrGejTX2K6pFUlgOGQ3+
         mp+qTraqHAbdCtgfMfbIcsWtAsMUyFXD2phxE=
Received: by 10.223.15.89 with SMTP id j25mr7915715faa.97.1269329675418; Tue, 
	23 Mar 2010 00:34:35 -0700 (PDT)
In-Reply-To: <4BA7A640.1080207@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142991>

THANK YOU! THANK YOU! THANK YOU! THANK YOU! THANK YOU!
I managed to recover all and actually the article made me understand a
bit more Git.

Jacopo


On Mon, Mar 22, 2010 at 7:17 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 3/22/2010 17:43, schrieb Jacopo Pecci:
>> Then I have tried =93checkout master branch=94, suddenly all the com=
mits
>> in between the one labelled [master] and the latest one vanished. I
>> have not been able to get back.
>>
>> I am terribly afraid I have lost 4 day work. Do you have any
>> suggestion? How is it possible that something which I have committed
>> is not retrievable anymore.
>
> 1. Don't panic.
>
> 2. Make a backup copy, *including* the .git directory (very important=
!)
>
> The .git directory contains your 4 day work, and it is very likely st=
ill
> retrievable.
>
> It may be a simple matter of
>
> =A0 git branch the-lost-state HEAD@{1}
>
> If you can't work on a command line, then git extensions certainly ha=
s
> some nice UI that lets you create a branch at a particular revision. =
In
> this case, the branch name is "the-lost-state", and the revision is H=
EAD@{1}.
>
> You can try more branch names at HEAD@{2}, HEAD@{3} (you get the poin=
t).
> It means, roughly, "the state where HEAD was 1, 2, 3, etc. git operat=
ions
> ago".
>
> -- Hannes
>

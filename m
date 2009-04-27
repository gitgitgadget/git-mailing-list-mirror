From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH] t3702: fix reliance on SHELL_PATH being '/bin/sh'
Date: Mon, 27 Apr 2009 19:01:08 +0100
Message-ID: <e2b179460904271101r6b405595yd4ad3562633eae60@mail.gmail.com>
References: <e2b179460904270812t3fa159f1ja3b06905d9effebe@mail.gmail.com>
	 <alpine.DEB.1.00.0904271812180.7741@intel-tinevez-2-302>
	 <e2b179460904270930m3c292bd8l5067447fff330fef@mail.gmail.com>
	 <alpine.DEB.1.00.0904271940100.7741@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 27 20:01:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyV9P-00073w-Pg
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 20:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756781AbZD0SBM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Apr 2009 14:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbZD0SBL
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 14:01:11 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:36530 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbZD0SBJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 14:01:09 -0400
Received: by bwz7 with SMTP id 7so64284bwz.37
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 11:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K5PxfulygFarQU1xoF/IXXNUCG5YD3YMBBDTw9B+JOQ=;
        b=Sw+tKeAI5I4TSBBu1YDkGNQL61AV64skZC/k72/9KlXdP7/hcNv52mE6xxUfj5z3K6
         dW4YtiSCG3E3McBe+0rF0jAmgqxAW6rwElf9mFPpeQJmJNz7pNeJ/+oXpU8Ux5rG9olu
         i+Qysxarvc/0PD0rZ0k5AoMwocIPmA+YFdJhM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kb9hKqNYQwVCCmBU2tuZHM1Ob1ubOdDUQ8ujXsr8j4Z5gsYjTba0wVJbauThO60DpC
         AkNPSN6rrgeRyeFBlijvDW63E2pOx4PU6Pznm+pW53Zqdg8hvL+sXo9O/0T0/qN3ijqG
         IAxvLjsewTLub9vkEvYe78enXrj5qnaPfEhiY=
Received: by 10.223.108.196 with SMTP id g4mr2012229fap.36.1240855268419; Mon, 
	27 Apr 2009 11:01:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904271940100.7741@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117697>

2009/4/27 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Trying to be lazy and comparing files with fake-editor.sh to avoid
> having to provide another example text does not work well: the blob
> name changes when SHELL_PATH changes, and so does the 'index' line
> in the diff.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Aargh.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0I know what it is. =C2=A0Sorry, _very_ stu=
pid thinko on this side of
> =C2=A0 =C2=A0 =C2=A0 =C2=A0the ocean.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Time for a day off.

I shall merely extend my thanks for diagnosing the problem (which I
should have been able to do), and for fixing it - which I wouldn't
have been able to do, because I'd assumed you were trying to be
clever, not lazy. 8-)

Tested-by: Mike Ralphson <mike@abacus.co.uk>

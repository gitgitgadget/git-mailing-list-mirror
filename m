From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: help reproduce fast-forward in rebase
Date: Wed, 20 May 2009 19:37:50 +1000
Message-ID: <fcaeb9bf0905200237j1cc4eb76hdc679975471e007@mail.gmail.com>
References: <fcaeb9bf0905200113s43eb5693l24a1f8848bafabd2@mail.gmail.com> 
	<20090520093321.GF6169@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed May 20 11:38:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6iFf-0006ow-S5
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 11:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbZETJiM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2009 05:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753013AbZETJiK
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 05:38:10 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:47974 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbZETJiJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 May 2009 05:38:09 -0400
Received: by an-out-0708.google.com with SMTP id d40so873508and.1
        for <git@vger.kernel.org>; Wed, 20 May 2009 02:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=fMGpsFzMR1koiKupN5VX8PqRe3+SDfKY2DtSVDv/B4s=;
        b=dInpRZqZbGwiTeDUAY1qGFNM6nIYpcKGpKhBhXHECO2qhvFkvIs9X01LWHiLddrjzV
         YoTUTwUHgNJcDYZhXVMcO6ja5p5Qt7IkrbXX06gEaLc5vJkXSLRrR+HbVL59orxWyolH
         i+yJTNi05VzSOMSq3P2KxjoKqhUpTApoGGBEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=IBzlE5Zr/Pk/Qs92nTeDtVbcRI8hUurQ6Rl6UXpWGuTxhIulme0HVAw5FicvWxIN7M
         YUZhsZh8LDgNFhboE9FbGOD0ftnjgFsEWO7wSaWi8BmS3derVtZWffT37zQ/jj8dHw8L
         JRVTdNysp6tzJB7jF2iCE3G8RVdPkwC/kO8qc=
Received: by 10.100.91.19 with SMTP id o19mr2205989anb.48.1242812290181; Wed, 
	20 May 2009 02:38:10 -0700 (PDT)
In-Reply-To: <20090520093321.GF6169@leksak.fem-net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119594>

On Wed, May 20, 2009 at 7:33 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi Nguyen,
>
> Nguyen Thai Ngoc Duy wrote:
>> Hi,
>>
>> I'm rewriting rebase in C
>
> Oh. First two remarks that may or may not affect you:
>
> =C2=A01. rebase -i -p is reworked by Dscho:
>
> =C2=A0 =C2=A0http://repo.or.cz/w/git/dscho.git?a=3Dshortlog;h=3Drefs/=
heads/rebase-i-p
>
> =C2=A02. sequencer, a C backend for git am and git rebase -i, actuall=
y exists
>
> =C2=A0 =C2=A0http://repo.or.cz/w/git/sbeyer.git?a=3Dshortlog;h=3Drefs=
/heads/seq-builtin-dev
>
> =C2=A0 =C2=A0although to even more lack of time the missing/non-perfe=
ct parts are not
> =C2=A0 =C2=A0getting fewer.

I should have said it clearer: I am rewriting git-rebase.sh in C, not
git-rebase--interactive.sh. The latter is even bigger than former.
Anyway thanks for the pointers.
--=20
Duy

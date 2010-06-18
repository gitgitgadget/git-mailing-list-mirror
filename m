From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: rebasing a merge
Date: Fri, 18 Jun 2010 00:38:16 -0400
Message-ID: <AANLkTimyqTOhkeDIMLwgw3iuN0IkDDquPi1tMV5WKoNc@mail.gmail.com>
References: <AANLkTilY_9j2sXlplhYB4FPAIAzuPBg2UyUTEk4DaaYF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 18 06:38:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPTLT-00024R-Is
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 06:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813Ab0FREiS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jun 2010 00:38:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60908 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab0FREiR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jun 2010 00:38:17 -0400
Received: by iwn9 with SMTP id 9so658772iwn.19
        for <git@vger.kernel.org>; Thu, 17 Jun 2010 21:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=X94/T42xI2kJ/yfn8jDHh9y8YIIzQeOoG967HWypfHw=;
        b=QYjVJ5/SutDG4Wdz6AQslRPbfu4jiV6maZg3LdWTujLOfziDHNjwctNmgJFLVAmjHK
         BFSjJDMIZsO9siuChxtf2eeZVhG8AZ5KeN7eZMVw587hZm3+Xxa7uuHaQdnl76MIXAZL
         gVgnaLRsUCRQJ1D0mUod2K17G3Kv/Kc+QY9MI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=R9JceP0dSDJg96h7e/IbP8INUfpBbYL2UFkljE9r8vOnAjY1S4vb6l1DMdrJRsl9FQ
         x6y1yMj0UFSYn41+JJPVVRoHpHhbdYYNh1+V7sjsmYQn0NYw0fHI5uhvLaM8MDWMy7jL
         U3rFVkRZgV/tpi31/LWQk13qMd9JJyF4titp0=
Received: by 10.231.66.79 with SMTP id m15mr495319ibi.139.1276835896630; Thu, 
	17 Jun 2010 21:38:16 -0700 (PDT)
Received: by 10.231.120.19 with HTTP; Thu, 17 Jun 2010 21:38:16 -0700 (PDT)
In-Reply-To: <AANLkTilY_9j2sXlplhYB4FPAIAzuPBg2UyUTEk4DaaYF@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149335>

On Thu, Jun 17, 2010 at 11:51 AM, Jay Soffian <jaysoffian@gmail.com> wr=
ote:
> git merge origin/master =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# resolve as needed
> git branch -f temp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # save the tree
> git reset --hard ORIG_HEAD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 # restore back to the merge
> git rebase -i -p --onto origin/master HEAD~1 # rebase the merge
> git checkout temp -- . =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # resolve the conflict here
> git rebase --continue =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# commit the resolution
> git diff temp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# no difference=
s
> git branch -D temp

This is a bit more efficient:

mc=3D$(git rev-parse HEAD)
p1=3D$(git rev-parse origin)
p2=3D$(git rev-parse HEAD^2)
git merge origin || exit 0
tree=3D$(git log -1 HEAD --pretty=3D%T)
git reset --hard $(git cat-file commit $mc | sed '1,/^$/d' | git
commit-tree $tree -p $p1 -p $p2)

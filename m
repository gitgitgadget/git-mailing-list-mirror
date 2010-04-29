From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Proper way to abort incorrect cherry-picking?
Date: Thu, 29 Apr 2010 10:07:27 +1000
Message-ID: <s2x2cfc40321004281707x50e59113t9f2ca9aea355ac5@mail.gmail.com>
References: <s2m76c5b8581004281238jf7179fffna7d757fee6ab4f10@mail.gmail.com>
	 <r2s302ed1461004281249xd1b65e41l43fa7b639db7c97d@mail.gmail.com>
	 <h2v76c5b8581004281259yfaca7abfz5a455ff8fd6cdc6b@mail.gmail.com>
	 <o2j2cfc40321004281539j28fe44e0r5d029061e3e08b90@mail.gmail.com>
	 <20100428233758.GA1654@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eugene Sajine <euguess@gmail.com>,
	David Borowitz <dborowitz@google.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 29 02:07:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7HI2-0006rn-Mt
	for gcvg-git-2@lo.gmane.org; Thu, 29 Apr 2010 02:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756820Ab0D2AHc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Apr 2010 20:07:32 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:47239 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756324Ab0D2AHb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Apr 2010 20:07:31 -0400
Received: by qyk9 with SMTP id 9so22125345qyk.1
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 17:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Kx2xpH9coH39v/RuCc0YZR5Z3CtCea1hOKcs9vgR8dA=;
        b=cPW/1+qHJCSTjStfv6QcJpo3eu2sd3V5KanpDjtEBeXlQTlIkfzTQfSqYziMbknRUk
         R2cBrYsSJKRmHJbnow7oJbS+cUeknBP3fntsWi7lspiI+qWPP/i8gNB8/BmahV/oCVWs
         qjFmwJhZdZZL9F4ui45woPDRZMO8X+HPn52ig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dSSmOAeg8GQnq/AlVp7zmvQ/rxqKP/hl3LXIoDS+Vc9/jzGJ9hTpiJkHerGrW5Lqiv
         rG3EzESSFJqw7t8413yH2CJwX6Q7jr2AUMpBnPrQS0kwjPdp1XvUYupZeFcCQHurIjbJ
         3pA2mAPg9TNWcTMThKsDV2z5M1MjvwufYae9c=
Received: by 10.229.211.210 with SMTP id gp18mr10378981qcb.31.1272499648081; 
	Wed, 28 Apr 2010 17:07:28 -0700 (PDT)
Received: by 10.229.224.65 with HTTP; Wed, 28 Apr 2010 17:07:27 -0700 (PDT)
In-Reply-To: <20100428233758.GA1654@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146022>

On Thu, Apr 29, 2010 at 9:37 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi Jon,
>
> Jon Seymour wrote:
>
>> If you use git reset --mixed HEAD@{1} you can reset the index to
>> HEAD@{1} to reflect the pre-merge state.
>
> The HEAD doesn=E2=80=99t advance in a failed merge, right?

True, but I understood this issue to be that there were two cherry
picks, one of which worked, one of which failed because it was out of
order. Hence git reset HEAD@{1} would reset prior to the first
successful (but out of order) cherry-pick.

Any way, thanks for the explaining the virtue of git reset --merge.

jon.

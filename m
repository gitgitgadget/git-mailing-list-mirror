From: David Aguilar <davvid@gmail.com>
Subject: Re: Feature requset: listing of current stash in git gui
Date: Tue, 22 Nov 2011 02:24:21 -0800
Message-ID: <-8099236111493298698@unknownmsgid>
References: <201111211100.52367.dexen.devries@gmail.com> <4ECA2D8F.4060005@atlas-elektronik.com>
 <30417194.1411.1321907485839.JavaMail.mobile-sync@ieja14>
Mime-Version: 1.0 (iPhone Mail 8C148a)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: dexen deVries <dexen.devries@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 11:24:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSnWj-0000EE-Kb
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 11:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076Ab1KVKY2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Nov 2011 05:24:28 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47448 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625Ab1KVKY1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2011 05:24:27 -0500
Received: by ghrr1 with SMTP id r1so747871ghr.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 02:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=references:from:in-reply-to:mime-version:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4ARs6q9I+BMYz4xSv8uSNuav/boj6cXIkhkMlhQGDGs=;
        b=aL3FW7mcPDe5yPQoxBTM+FZTMbrI60whSrcqcXYFBwETur/ePLjOGAZX4Laq7X45Dm
         x39yoHb7Z83jwp09g1V9x6SVe0ERVQyyw+95sEezNkC2cYh+1s9oN0csN/wvmP5x+nRw
         UqTrcxeLkOn8Hm+K2xOGXTGJGVnq4cpsXZdek=
Received: by 10.236.190.197 with SMTP id e45mr25752469yhn.101.1321957467027;
 Tue, 22 Nov 2011 02:24:27 -0800 (PST)
In-Reply-To: <30417194.1411.1321907485839.JavaMail.mobile-sync@ieja14>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185779>

On Nov 21, 2011, at 4:41 AM, dexen deVries <dexen.devries@gmail.com> wr=
ote:

> On Monday 21 of November 2011 11:53:03 Stefan N=C3=A4we wrote:
>> You can simply put the following in your ~/.gitconfig:
>>
>> [guitool "Stash/show"]
>>    cmd =3D git stash show -p
>> [guitool "Stash/list"]
>>    cmd =3D git stash list
>> [guitool "Stash/pop"]
>>    cmd =3D git stash pop
>> [guitool "Stash/drop"]
>>    cmd =3D git stash drop
>>    confirm =3D yes
>
> that's nice, but doesn't list visually the stashed changes. I'd rathe=
r have a
> listing similar to Unstanged Changes / Staged Changes, with ability t=
o view
> line-by-line diff just like for Changes.

[blatant plug]

git-cola has this feature.
>

   http://git-cola.github.com/

Have fun,
--=20
            David

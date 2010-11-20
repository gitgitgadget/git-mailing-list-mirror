From: Yang Zhang <yanghatespam@gmail.com>
Subject: =?windows-1252?Q?Re=3A_How_to_fix_=93Your_branch_and_=27origin=2Fmaster=27_ha?=
	=?windows-1252?Q?ve_diverged=94_after_editing_a_commit_that_came_before_a_pul?=
	=?windows-1252?Q?l=3F?=
Date: Fri, 19 Nov 2010 17:59:55 -0800
Message-ID: <AANLkTinRfzzG-Dc9Ervc-h0_4cwx9KBO1aTkhwBGpHHs@mail.gmail.com>
References: <AANLkTikr+uGrO2EB9WQk+CXeOm7jiYxdbhGzRRvgc9B9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 03:00:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJcka-0007Kb-Hw
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 03:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756424Ab0KTCAS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Nov 2010 21:00:18 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51549 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756314Ab0KTCAR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Nov 2010 21:00:17 -0500
Received: by yxf34 with SMTP id 34so3119745yxf.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 18:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=D4DXQdxMduUQWDeDPDTgWNht4oMp0Gsxidedk3aVtlA=;
        b=YUdE4hLpgEBY0cKy9Yw4lsJNJawfCGxgHmasnMatPkOmANLklyRff28KFsGO8EY6ao
         MXylJMGTKQYGCQDYfNeEUJmO89s4a8B+ammAYAhYce6CmY3dM0MeoMMVOSl53KgYy3qs
         ls9cbNezSXJpduNGkl2Wvl0taAQ1Y8INqPwfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=yDUzJCMLkJEUnukYreXOTyAiOI4K40SMeNEzIabjEmUWPgwXHqc7q/RtiJxQSGYS0E
         Jov8L5dTQZkAwZzk597IZwCktq8SwtJ9B1b+WPbEIyyaak0MHX1UgCBaU5y4GntBWT26
         AeAGFFmrndc4lcmg1SnrvmxfyOyBL9kEqH85I=
Received: by 10.90.2.23 with SMTP id 23mr3581544agb.97.1290218416590; Fri, 19
 Nov 2010 18:00:16 -0800 (PST)
Received: by 10.90.222.2 with HTTP; Fri, 19 Nov 2010 17:59:55 -0800 (PST)
In-Reply-To: <AANLkTikr+uGrO2EB9WQk+CXeOm7jiYxdbhGzRRvgc9B9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161818>

Clarification:

Simply pulling again does not fix the problem; it just reapplies the
commits D, E on top of what I already have (despite the D, E already
being there in the history), which also has the side-effect of
producing superfluous conflicts.

On Fri, Nov 19, 2010 at 4:36 PM, Yang Zhang <yanghatespam@gmail.com> wr=
ote:
> In the following scenario:
>
> 1. Make commits A, B, C
> 2. Pull, getting commits D, E
> 3. Make more commits F, G, H, ...
> 4. Realize that you need to tweak B
> 5. Tweak B using git rebase -i and git commit --amend
>
> Now git status says:
>
> =A0Your branch and 'origin/master' have diverged.
>
> How should I fix this? Thanks.
>



--=20
Yang Zhang
http://yz.mit.edu/

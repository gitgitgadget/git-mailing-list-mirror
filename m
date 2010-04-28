From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Groups of commits
Date: Wed, 28 Apr 2010 10:05:39 +0200
Message-ID: <y2t81b0412b1004280105p46962bdeq163bc4fb92cb0fdb@mail.gmail.com>
References: <j2u43d8ce651004271859t8f306261n330004142a42b6df@mail.gmail.com>
	 <87sk6ge312.fsf@troilus.org>
	 <r2jbe6fef0d1004272225rd61ef84axe86ba45a0b352a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Poole <mdpoole@troilus.org>,
	John Tapsell <johnflux@gmail.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 10:05:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O72HE-0007Uz-Pt
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 10:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562Ab0D1IFn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Apr 2010 04:05:43 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59099 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab0D1IFk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Apr 2010 04:05:40 -0400
Received: by gyg13 with SMTP id 13so7139737gyg.19
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 01:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=n7Iep6IjMNwA56/e3AXZS5efakvD/KU+JHYvprCaVQE=;
        b=YWcKOEA4LwtuGvglmKebIyUbBlxxNdYFLalNy09qVa0AynKXuwQNCS448+1yTtMOG1
         Op7q2hlP58w3itl6J6MEAUnba218QTl9Mdz4irAwy2NFeOZMbaUvOCOO8zJNANm5mkzf
         BNVsjuN7Rax77JjqYR4Af1UP/ZjkpX8uaeZ9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wRIh06AtmlnsiQcTNYfKB1WHszP6RNTo7r8um2iDxFbVok++jR+CEz9Yk6dC7tJWhu
         v4QeRZHVBZqSwGoSV36BBwxap+cwVtDtM524Th6+3luFukJgVtJO17ERU0CZ4JPR2Xx1
         KvxjSEvTuXHP5FygLhnDn5hfI6ocS0sdb8NQA=
Received: by 10.101.107.12 with SMTP id j12mr2326090anm.98.1272441939694; Wed, 
	28 Apr 2010 01:05:39 -0700 (PDT)
Received: by 10.100.120.9 with HTTP; Wed, 28 Apr 2010 01:05:39 -0700 (PDT)
In-Reply-To: <r2jbe6fef0d1004272225rd61ef84axe86ba45a0b352a8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145974>

On Wed, Apr 28, 2010 at 07:25, Tay Ray Chuan <rctay89@gmail.com> wrote:
> Just to add to the "merge in topic branches" idea - if you find that
> the commits are trivially fast-forwardable, you can still add a short
> note/cover letter with
>
> =C2=A0git merge --no-ff -m "Added in foo's work" <branch/commit>
>

Except that is not a "short note" anymore, but a full-fledged merge
commit. You forced it with "--no-ff".

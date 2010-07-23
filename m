From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: rfc - Changing the way gitk and git-gui are managed
Date: Fri, 23 Jul 2010 02:16:45 -0400
Message-ID: <AANLkTin9kbMp5nOS=GaM2rX1w+y8vbzYfWunkSSeoPZg@mail.gmail.com>
References: <7vocdygbw0.fsf@alter.siamese.dyndns.org> <AANLkTimdYfv-Z57iHD+YLfjKi66av5xmaC3JEMRNRw+Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 08:17:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcBZM-0003Dz-5D
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 08:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866Ab0GWGRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 02:17:10 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47057 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab0GWGRI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 02:17:08 -0400
Received: by wyf19 with SMTP id 19so1243976wyf.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 23:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=eIatNHdHzf1l2JAD7mf2ZP+2Zen9yn3Qfx7p58Qz2g8=;
        b=mjHqXoUZbgvVVDQsWcwiYp888FFEu1HS/F2Dsy4hOfHG2zSLOkoho5zImVVn7cxWJn
         41QHJPtyM/LRmiSh3d2Ou9fV+htW71vJJ6g4dxsN7yugrbmLZtWxsTGV7x9C58JGxIAx
         Wq6aPh59p77z2EN81U8E7/wagdXK8gBStZU/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=hqDgyBY5l5KCbBtgQ4SvreCZjbJvn2LMcMEGykMVM0X3++J1Fp4scnDeLiQkba6C0N
         u4HZvt9jIZZlZ5q85qyTvqNFhrOWRucZjRNHC661RfJjVsUBJOBzGzKdQDrWisoxogOl
         KasPEGqQb5ocGMSTtuGiO/8UZqnAywWYhwFPI=
Received: by 10.216.237.100 with SMTP id x78mr2903781weq.114.1279865825193; 
	Thu, 22 Jul 2010 23:17:05 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Thu, 22 Jul 2010 23:16:45 -0700 (PDT)
In-Reply-To: <AANLkTimdYfv-Z57iHD+YLfjKi66av5xmaC3JEMRNRw+Y@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151504>

On Fri, Jul 23, 2010 at 12:04 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Thu, Jul 22, 2010 at 21:39, Junio C Hamano <gitster@pobox.com> wrote:
>> Somebody off-list suggested removing gitk and git-gui directories from my
>> repository and I've been playing with the idea and kind of like the end
>> result.
>
> The neighboring thread [0] about git subtree seems highly relevant to
> this decision. Avery, do you perhaps any additional insights wrt this
> particular use case?

Only this: Junio said that there are no major downsides to this change
- and given the slow pace of change in gitk/git-gui, this is probably
true - but are there any *upsides*?  What problem does this solve?

git-submodule and git-subtree solve different problems, so which one
is "better" depends on the problem to be solved.  As a
mostly-just-user of git, whatever is currently being done is super
convenient and easy for me and I wouldn't ask for any change at all.
Obviously it might be very different from Junio's point of view :)

Have fun,

Avery

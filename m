From: Matthew Wang <mattwyl@gmail.com>
Subject: Incompatible '+=' syntax in git-completion.bash
Date: Wed, 24 Jul 2013 09:54:04 +0800
Message-ID: <CAK6R3tz73t1HQ2AkeimFDGnmZbFT1PJ5idTbKt8QwsPOSaYqQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 24 03:54:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1oHL-0003hB-MF
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 03:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991Ab3GXByH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 21:54:07 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:58466 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab3GXByG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 21:54:06 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so9062459pbc.18
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 18:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=GkK1FdDaodgZ6mgwUy11fvgviJgCCeZIwcX+avs2ohg=;
        b=R/7nTp7NlRPzL5o7GwF6BxPNGjNPlvcSX/sjAGkdTHC1v7Z2Abxef24abl6lGuZ96s
         WwJgKzDiu54eqEMyZ0+G13wbJodM5nr1/9NARMbQIoy7PZAT99/lsxHy9Z1XrdITuoMD
         GUO5v+7Lyw8EP7D1UZgkFvssi9aVGSt+4C0NjeZGYlFN6bOnWlYuPFiVmOpuisiQTgfv
         VWj+Nt3Bce+Cuizqy2L5yUUDHjs4yAE15dqQV5McI0d4hiREeOUKDkq4q6ORJmo8TO8G
         K3VFX9sLQ+jg30x1eBa02UKl5WVRyv9mvceopM0nUBfVd9B6L6i1W/x3hUp3ClpnVeuj
         lnqw==
X-Received: by 10.68.105.195 with SMTP id go3mr35803202pbb.180.1374630844747;
 Tue, 23 Jul 2013 18:54:04 -0700 (PDT)
Received: by 10.70.69.196 with HTTP; Tue, 23 Jul 2013 18:54:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231072>

Hi there,

I noticed a change in commit 734b2f0 on
contrib/completion/git-completion.bash which reverted a syntax fix for
'+=' syntax [1], the syntax does not work for bash < 3.1.  As far as I
know, bash 3.0.x is still widely used on some old servers, could
someone add the fix back again?

Thanks,
Matt

[1] https://github.com/git/git/commit/734b2f0532d847a9f566183982f83ddea8d8d197#commitcomment-3664571

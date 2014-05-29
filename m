From: Jonathan Leonard <johanatan@gmail.com>
Subject: .gitmodules containing SSH clone URLs should fall back to HTTPS when
 SSH key is not valid/existent
Date: Wed, 28 May 2014 19:07:14 -0700
Message-ID: <CA+OJ3uv0XqeodTCzeauUrH9FjzknBupMd5kxh+3qgyji5TwOzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Albietz <inthecloud247@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 04:07:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WppkY-0006z8-Q3
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 04:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878AbaE2CHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 22:07:16 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:62080 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573AbaE2CHP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 22:07:15 -0400
Received: by mail-qg0-f41.google.com with SMTP id j5so20592293qga.14
        for <git@vger.kernel.org>; Wed, 28 May 2014 19:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=mJOJLx92VpLktCfmfFwXnOY83Rl+VtlQl7ASESfu5ao=;
        b=PtDzTe4wvmCfDuQRPGkYQN84wEge/dgvquKf2cp/qIhQsxYhujOdLOiVWTDnDgjUPq
         LiOXPA/pMj+ZIsGEI3pAG2fbCxJvh7KLmaytqv819Wcz3zwIXY+kafKSVwlInOD2BnmL
         iP29ShMazNTatv7yb+Vkq/JHUJxalBsqP5qscc7qMo+DS1nnL1U4V3ytqa9qQ7ERUSir
         EmHmxF5kipNGHZGqtuvaLmzFBz0i4u8ZXCxw9NtXdwAtjq8Qa5Pcszdcu3WBl7mxYyt5
         5NNYdgIM4E8RATDEQ4xf3CBsJ1E1BbuG53KoiGBrIoooce1iJ2+YZh4t+kGWPCMnyerx
         x0FQ==
X-Received: by 10.140.23.7 with SMTP id 7mr5364421qgo.0.1401329234351; Wed, 28
 May 2014 19:07:14 -0700 (PDT)
Received: by 10.140.108.203 with HTTP; Wed, 28 May 2014 19:07:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250351>

The title pretty much says it all.  Lack of this feature (or presence
of this bug [depending on your perspective]) is a major PITA.

--Jonathan

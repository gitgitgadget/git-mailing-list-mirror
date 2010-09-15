From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: ab/i18n + jl/fetch-submodule-recursive cause failing tests in pu
Date: Wed, 15 Sep 2010 11:12:23 +0000
Message-ID: <AANLkTimCu7YdmuJP0xunSRYp04J6=P9VAg-0gQHvEqPh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Sep 15 13:12:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovpuh-0003yn-S0
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 13:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551Ab0IOLM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 07:12:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42216 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab0IOLMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 07:12:25 -0400
Received: by iwn5 with SMTP id 5so66894iwn.19
        for <git@vger.kernel.org>; Wed, 15 Sep 2010 04:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=PHAv1hz21490RP+cTrEbt6GP87aLcVcFytK7x6zKeBw=;
        b=MSI4v7ZUyL0cqcKquFsCauZz0ACfDO6fTLIOCF/gVHAU4GznTvQhrp2gQHtheqBuJ9
         cpxRkWlX493G01SiX2qD3e5Iu7Pc+xJ962JrJNo9XUHZX/guXfN6H5I8ruR6yBXtbAj7
         YEtFYzVEyh5TGX63+9G+rWkaeJdk0N1l+ES9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=tsC+TmTqjJr1r3zGNnfaGRM3dSMG8V4g4MFliE/xY2oOLfkkiZ4PhsRAuuVelK62cE
         zdx3F/E6Fa6is21lD0yuDqSOM0W11pC7HszHlW0UFjuK6JICaxk/KuzB1E6LildaMaLy
         H9Bc6ilHPLlvsWJPvK+Ci9fbSJTQs0Vf0XQHk=
Received: by 10.231.33.12 with SMTP id f12mr1615056ibd.31.1284549143928; Wed,
 15 Sep 2010 04:12:23 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Wed, 15 Sep 2010 04:12:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156230>

Just a note: The t5526-fetch-submodules.sh test is failing in pu
because the gettextization of git-submodule conflicts with its tests
assumptions.

It just needs the NO_GETTEXT_POISON prerequisite. I can add that to
ab/i18n once jl/fetch-submodule-recursive is merged to master, or the
other way around, whichever comes first.

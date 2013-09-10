From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v6 1/8] reset: rename update_refs to reset_refs
Date: Tue, 10 Sep 2013 09:13:16 +0530
Message-ID: <CALkWK0kC-jwONA2iZ+KYSe7iJAEq=SFNdUEmuxWUpKuJ+r_AKQ@mail.gmail.com>
References: <cover.1378732710.git.brad.king@kitware.com> <cover.1378773895.git.brad.king@kitware.com>
 <caa29a576f30be135956073ccab6534d0877a418.1378773895.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 05:44:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJErz-0004ZX-CN
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 05:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697Ab3IJDn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 23:43:59 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36485 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab3IJDn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 23:43:58 -0400
Received: by mail-ie0-f182.google.com with SMTP id aq17so15230563iec.27
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 20:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=z0MGI4mFJ+DCvGVL1TSgGTNOgWMZaGDuCX2pu9s4hBc=;
        b=Udc3z0ILspyxtF083B5rRsSESunABJWT7z9C8fgnsHh5O8pIDes6fmDJOZxksr8rxf
         DSOQlqaa17+m/TBqhgU56r24IIe6YbaHPqli+7RRri5x38V1mpjbV94ASwQ4ffJA3+KB
         oBy2lvYZd13OSgITEisQp6PY6ZlUitXpLaG7ylG86nznweiZkLkqMmtPj1qVEpwDxo/Q
         ZIp3XAojWMbgZgk3C1KPuyyY+XMbD9B/csbWcXeBgDTzldS1YMeTDq+TT2+k5vk1RQbc
         xxRH20ORPnH9dFl0FoRiV0iuAjow+/U+VYpCox9xs+y+O2wK0OAE9Uk1hkN2AgKSKvb0
         xxxA==
X-Received: by 10.50.97.35 with SMTP id dx3mr10070569igb.55.1378784638007;
 Mon, 09 Sep 2013 20:43:58 -0700 (PDT)
Received: by 10.64.73.5 with HTTP; Mon, 9 Sep 2013 20:43:16 -0700 (PDT)
In-Reply-To: <caa29a576f30be135956073ccab6534d0877a418.1378773895.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234417>

Brad King wrote:
> The function resets refs rather than doing arbitrary updates.
> Rename it to allow a future general-purpose update_refs function
> to be added.

Makes sense; thanks.

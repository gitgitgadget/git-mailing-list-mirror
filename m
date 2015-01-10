From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Git::SVN: handle missing ref_id case correctly
Date: Sat, 10 Jan 2015 17:14:34 -0500
Message-ID: <CALkWK0mXx5qQSNSC4ju8Bejy_XhewxDA+nwy1JCmodX3t-H+3A@mail.gmail.com>
References: <1420900510-78522-1-git-send-email-artagnon@gmail.com>
 <CALkWK0=jEh06hZSmHim54BaP_KiC8hg-455STQphu17PSoQTqw@mail.gmail.com> <20150110221308.GA32253@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jan 10 23:15:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YA4JX-0001Xf-1w
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 23:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213AbbAJWPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 17:15:17 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:60838 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585AbbAJWPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 17:15:16 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so20362043iec.11
        for <git@vger.kernel.org>; Sat, 10 Jan 2015 14:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EgQrfi5e/pfsEinqg3ipSgFkYkyEXr3/GDyduPoNU7Y=;
        b=bctNJd1cnSAq417UJoAqyR4sa7LVg2nkLRuD7wnSymKHderkTFM+jJoAPTtp5MboVz
         +2/Ya9czwBm2CvXI62/mKbzVJ4XHrCiUi0Z2ROa/k4TGQq9svJMDRx/c8dAn/UKaB4u6
         vjZv1Q9ncexsQ62W8AlecA0EeeLichKiZNchKEMankq0NtlA5+/MK7g2GlCDD3GQIPW4
         GtRVBqbjIm8JdcGal01nPqkVvRq3htyjmoJYEtx6GAvNThLeaAIInNi/fKYwdAK5ff8k
         Lsp9YZwvz3CmA+MKeK471gos0//JwXKOSu3DUevDEM2UU50oCS9brXZFNgOJB+tSiFpH
         8Yjg==
X-Received: by 10.107.46.28 with SMTP id i28mr21399385ioo.73.1420928115273;
 Sat, 10 Jan 2015 14:15:15 -0800 (PST)
Received: by 10.107.3.75 with HTTP; Sat, 10 Jan 2015 14:14:34 -0800 (PST)
In-Reply-To: <20150110221308.GA32253@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262276>

Eric Wong wrote:
> It is functional, maybe someone will use GIT_SVN_ID=0 ?

Right. Kindly drop the first hunk.

From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] Document pack v4 format
Date: Thu, 5 Sep 2013 11:19:41 +0700
Message-ID: <CACsJy8BeU_01c0f5RJExcYo7xGETnduKOw-_shszHd0ZFgZDXw@mail.gmail.com>
References: <1377602225-30439-1-git-send-email-pclouds@gmail.com>
 <1377917393-28460-1-git-send-email-pclouds@gmail.com> <alpine.LFD.2.03.1309030156410.14472@syhkavp.arg>
 <alpine.LFD.2.03.1309030231350.14472@syhkavp.arg> <CACsJy8CZP+55nhfEbgRGa9=y0PyExyHt_seiSc23kB31-_c1Hg@mail.gmail.com>
 <CACsJy8CzpW_xsoxU=+OE6ssbnPu9tyAqRten0=Q5cxPUZ4aeMw@mail.gmail.com> <alpine.LFD.2.03.1309042350560.14472@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Sep 05 06:20:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHR3P-0001eS-JQ
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 06:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756422Ab3IEEUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 00:20:15 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:60023 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756332Ab3IEEUM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 00:20:12 -0400
Received: by mail-ob0-f176.google.com with SMTP id uz19so1417212obc.21
        for <git@vger.kernel.org>; Wed, 04 Sep 2013 21:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hZsu8RYi/lXzkDTHtgSFTjVosBhhON1wHCm4js6ZasM=;
        b=VEMs3UFx3gNcP+QbyMGbKRO0VT7i4lAr2NISbmBov6WUU8oP7XfJKK+E/PvM71pVA8
         zRhZKswDUsSJq91iEFiyJP6nrA65iGiRb0huseoXLKxnb58YUTpvoqP71OOpIBvwXUM0
         6oOUcNzYrtHxi16jglefjGERlpSm1sDbtLD89T6Vmw2yWiMatUfWlfItByEE2UFYy2Ie
         1949R3bYTofSSZUpCZhRWQoMVoNX53RIx2+pLpvdDs3aQiLmbWxV2Wzqf+uJud1JUgl5
         Eml1ThxHEo7nGE0AgXdrEhFed2/hX0SZwgIZOJhtnnb+jhLUKUrXbob3lQeGlWAujz5X
         jXag==
X-Received: by 10.182.98.162 with SMTP id ej2mr4940640obb.61.1378354811808;
 Wed, 04 Sep 2013 21:20:11 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Wed, 4 Sep 2013 21:19:41 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309042350560.14472@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233890>

On Thu, Sep 5, 2013 at 11:12 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> Many other bugs have now been fixed.  A git.git repository with packs
> version 4 appears to be functional and passes git-fsck --full --strict.

Yeah I was looking at the diff some minutes ago, saw changes in
pack-check.c and wondering if fsck was working. I'll add v4 support to
index-pack. Waiting to see the new, v4-aware tree walker interface
with good "rev-list --all --objects" numbers from you.
-- 
Duy

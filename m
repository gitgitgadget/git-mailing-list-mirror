From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: Do not require tags to be annotated
Date: Tue, 10 Sep 2013 21:45:11 +0200
Message-ID: <CAHGBnuOtCU+4w_bb3vK0pN3eG_GusXitsBzb=ETcE30U54z9pQ@mail.gmail.com>
References: <522A36AA.3050701@gmail.com>
	<xmqqeh91wrvq.fsf@gitster.dls.corp.google.com>
	<CAHGBnuP6w8rvoz+h2Xase1ApY_kpZh4X=VF6LY4O0r7RS0UayA@mail.gmail.com>
	<xmqqsixgvci1.fsf@gitster.dls.corp.google.com>
	<CAHGBnuNKrtGSoOYS1T0VH=tGvKUW0XKFnWf_WNvZkOriGurgpg@mail.gmail.com>
	<xmqqr4cx1u7u.fsf@gitster.dls.corp.google.com>
	<CAHGBnuN=vpJPXgd78aLohW3Awe+Y+0J7Bxwr4Fmn2NijMK1Z5g@mail.gmail.com>
	<xmqqy574zmzd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 21:45:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJTsI-0007LW-Ux
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 21:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822Ab3IJTpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 15:45:15 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:54285 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab3IJTpN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 15:45:13 -0400
Received: by mail-la0-f43.google.com with SMTP id ep20so6562857lab.2
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 12:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rLbdn2wv4TrPeGgbbDcPtPbdBakeObkVSNelT7cA9xw=;
        b=YAY/wO7XLK5FIFrJyzDygPYXG51gvhlWrcfktwMam0cSjYwLdJX2l51K4cllg2H5wc
         ys8Gn0bwMHK8hFC4Ytd9SJS64uY5CEv9ETkhVRwI+chxiz0C7vN80K4msBUBEoOTAG4T
         XUr5rEkUFcIx2JJ4qP7Gm9ThVcPGXJuRq/6bpO9UeF7fIbc/Tt7cec5zzALp4J2V60ml
         q7wo/hQuDyW8GZjOJjF5Y1gzPXoY3SZ4s+QZFnZ1veutq+ymJBN9FGGsRp8luf/D9FkJ
         ZDdTnbXO10Fe5MzpytwZxWwBL0kjrPqZ0y6JpGETFrrdqBqCFJzgJ4h+V3xtM5su3sIU
         VCdQ==
X-Received: by 10.112.167.230 with SMTP id zr6mr2752407lbb.35.1378842311541;
 Tue, 10 Sep 2013 12:45:11 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Tue, 10 Sep 2013 12:45:11 -0700 (PDT)
In-Reply-To: <xmqqy574zmzd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234474>

On Tue, Sep 10, 2013 at 5:59 PM, Junio C Hamano <gitster@pobox.com> wrote:

> string to that file before building, so in that sense, we do not
> *need* DEF_VER and version.  But they have been there for a long
> time, and I do not think it gives us a good trade-off between
> risking regression and reducing the linecount to change it to remove
> one.

Fair enough!

-- 
Sebastian Schuberth

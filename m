From: Delcypher <delcypher@gmail.com>
Subject: Re: [PATCH] git-remote-hg : Enable use of, $GIT_DIR/hg/origin/clone/.hg/hgrc
Date: Sun, 20 Apr 2014 22:25:02 +0100
Message-ID: <CANNJ_zg4hNWJDignen7YK1ta5gEDyu6nP4D8ZQNTn-1xypm2-Q@mail.gmail.com>
References: <53076DFC.1000602@gmail.com>
	<53499bb02c140_285f9032ec58@nysa.notmuch>
	<CANNJ_zjVaymTUmSSFHfSpmcH7H2v62nsHaUoxRfi098zqLi_Ow@mail.gmail.com>
	<53540df5ad0fb_18fb153d2ec8b@nysa.notmuch>
	<CANNJ_zhpoRRTL1j8XKahrsqEgKfvFck-+aJ20X1OyAg73gGiqQ@mail.gmail.com>
	<535425d891e41_6b186d130cc5@nysa.notmuch>
	<CANNJ_zi=qrhmWjd0_QR5-LLjuf2yM8g88xhiwmwdqansvaYy3A@mail.gmail.com>
	<535432b6494cf_4a5cd6130c16@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 23:25:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbzEa-0004dd-PM
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 23:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbaDTVZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 17:25:05 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:38620 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbaDTVZD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 17:25:03 -0400
Received: by mail-ve0-f172.google.com with SMTP id jx11so6609290veb.17
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 14:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LgIu3RrUYzz1PFanh7jtJn8uMpIe3XCNIJoDia/Ilz8=;
        b=NN+kuG0UKJk+oUjEADiaVTwXBF79wTidoLK7BGlOlefCJa9Go1S5em9h1gLa8qBF2G
         FDg3MwkfsLs/nJLz9TBo7mjdJ4VBotvKzPkopE6Bhy/j+sQY9fAREzgttUJBGA0WXfSL
         tefRwthsH0d2mvG3NYD0Z6UpSzujiMkeY43bP/WWciAeP8xZYWRhAqhu2X5SJA3efe7d
         bt3dUmy7mxuI2H9w8SKrIRhbG8ElPMHUN7aYQmPBMSG1CU0mQ3/5Pz/q7sl4CfKW+Ice
         ZZGs65p0JgqPP6Xr359RoWEQt1uKLS+6ByuRK2seiaB8Vr2NzNI2xwlW31LH+rR0DscZ
         QWVQ==
X-Received: by 10.52.144.42 with SMTP id sj10mr21847505vdb.19.1398029102240;
 Sun, 20 Apr 2014 14:25:02 -0700 (PDT)
Received: by 10.220.88.70 with HTTP; Sun, 20 Apr 2014 14:25:02 -0700 (PDT)
In-Reply-To: <535432b6494cf_4a5cd6130c16@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246587>

> I see now, I've taken the patch with repo.ui and applied on my repo:
>
> https://github.com/felipec/git/commit/ee17fe1cf80d5196be382ebbbcb1a24c05e61658

Thanks.

It might be helpful to catch the exception raised if https
authentication details are missing so that a more user friendly error
message can be presented. I considered doing this but I wasn't
entirely sure how to correctly do any necessary clean up.

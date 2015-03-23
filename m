From: Julien Cretel <j.cretel@umail.ucc.ie>
Subject: Re: [PATCHv2 0/2] log decorations for HEAD
Date: Mon, 23 Mar 2015 10:36:43 +0000
Message-ID: <CACdBeKkpH8O+tXbB9dK0GDBZc3gPMTf-WDt_FOk9mjZT2ranMQ@mail.gmail.com>
References: <54FEC8D0.2060304@drmicha.warpmail.net>
	<cover.1425995310.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 11:36:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZziy-0000uw-SG
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 11:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbbCWKgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 06:36:44 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:33074 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbbCWKgo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 06:36:44 -0400
Received: by ykek76 with SMTP id k76so69727358yke.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 03:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=O1Hxk0ggHgwin6Wp1xfdSY77F4XMsonwi34WUHuRN68=;
        b=WFXlbQvk13yJu36/irvafkWvj23kKAAv2FytdnkbJrwQbqxQ/1r3LBBl0lrJERflpq
         QAZKMIKCm7XoCbGUf+XVSipw8zoMd7h/W0zqkCcl1UHQOM7QNF8C2gQjBwgx41K4lH32
         d1IsxYOxxphyY0Jfgx6g+6KPcBttiEdNcETCVvu0XafuEO1NAvBSWiHjXrpH4Ejpxnm+
         p3EwUt/gntCveBQaFTeRsrWLi2N8btysa5vp3crGAmaO1uOgtW8hCqwiaPDjhjBamM/b
         EFGnOEzXr5/KTtQx4RTIE+llpS4ZvKNYpFQ9TGj/t91enD8nFtG/LPoxNyLfX27AcLcp
         ThWg==
X-Gm-Message-State: ALoCoQnOw9mYD/B1IQJedamxP+NS9+NoWql+jPsVzpfj1/Ou0DXbM6oWPtNustFAk3dnAcDWITvk
X-Received: by 10.170.206.84 with SMTP id x81mr37383920yke.122.1427107003341;
 Mon, 23 Mar 2015 03:36:43 -0700 (PDT)
Received: by 10.170.54.15 with HTTP; Mon, 23 Mar 2015 03:36:43 -0700 (PDT)
In-Reply-To: <cover.1425995310.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266135>

On Tue, Mar 10, 2015 at 1:53 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>
> So it didn't take too long to convince me after all :)
>
> Here comes Junio's version, preceded by a cleanup of the color
> setting and resetting for decorations.
>
> Junio C Hamano (1):
>   log: decorate HEAD with branch name
>
> Michael J Gruber (1):
>   log-tree: properly reset colors
>
>  log-tree.c                        | 76 ++++++++++++++++++++++++++++++++++-----
>  t/t4013/diff.log_--decorate_--all |  2 +-
>  t/t4207-log-decoration-colors.sh  | 16 ++++-----
>  3 files changed, 77 insertions(+), 17 deletions(-)
>
> --
> 2.3.2.346.gb6960c9
>

I'm so glad you've implemented this. Thanks again.

I hope I'll get familiar enough with the Git codebase to start posting
patches of my own, in the future.

Jubobs

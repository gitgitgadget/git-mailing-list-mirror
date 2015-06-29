From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: always use any proxy auth method available
Date: Mon, 29 Jun 2015 10:00:23 -0700
Message-ID: <xmqqzj3ibgbc.fsf@gitster.dls.corp.google.com>
References: <FCAB894186380D42A07AFFFA5A1282B8F1EC65FD@EXMBNJE2.ad.twosigma.com>
	<xmqqfv5etgqt.fsf@gitster.dls.corp.google.com>
	<FCAB894186380D42A07AFFFA5A1282B8F1EC7AB5@EXMBNJE2.ad.twosigma.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "'git\@vger.kernel.org'" <git@vger.kernel.org>,
	'Nelson Benitez Leon' <nbenitezl@gmail.com>
To: Enrique Tobis <Enrique.Tobis@twosigma.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 19:00:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9cQ4-0002ms-GK
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 19:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbbF2RA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 13:00:28 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36966 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbbF2RA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 13:00:26 -0400
Received: by igblr2 with SMTP id lr2so57070245igb.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 10:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Lenw/K3yMT7UPY5CoDRoV6Vn7j7qnA/zzpV3383Qy0c=;
        b=SlbqmfGLYWjPTEDnWtYFLCzg9mLNGjdQHwE0FMErLp1M8ouaqglZc6VAlLJ7b5cwf7
         YqGXIjQhtUyIfrhwhqHlb2nPFpK4a5lf2ESOonxvehKtaOWBJ7Aq73K+6HqfGvnSx5fj
         vaMWJbotJuenYMrSfOCcqoDXXS8DcODYNrmJda6johzQAbmszEqfADIlVLiiIaKApHuO
         Bq1Fx3BLZbJnwKCWCJR/XTn0xK3wt1yCy4Kvd2WZ5YUvSXVToo3Ipu9nF2TqBJ8+L00P
         gzZbjZJVd6QvIBU+g7RABnbBFYXT5MIQtzwg7T6lcnW5sW1QVydyHLdyhlnK64F6cmFt
         wmPQ==
X-Received: by 10.107.151.75 with SMTP id z72mr20754552iod.46.1435597225682;
        Mon, 29 Jun 2015 10:00:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:946c:210:22fc:378d])
        by mx.google.com with ESMTPSA id x3sm5835273igl.2.2015.06.29.10.00.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 10:00:25 -0700 (PDT)
In-Reply-To: <FCAB894186380D42A07AFFFA5A1282B8F1EC7AB5@EXMBNJE2.ad.twosigma.com>
	(Enrique Tobis's message of "Fri, 26 Jun 2015 21:53:24 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272974>

Enrique Tobis <Enrique.Tobis@twosigma.com> writes:

> You did guess correctly. As you said you are not an expert in this
> area, should I wait until someone else chimes in or is this enough to
> resubmit for inclusion? Assuming my revised explanation is acceptable,
> of course.

I'll queue the patch as-is with your updated log message to explain
it.  Maybe somebody else has more comment on it, but I think the
change makes sense.

Thanks.

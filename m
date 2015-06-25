From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] commit: add commit.signoff config option
Date: Thu, 25 Jun 2015 07:55:37 -0700
Message-ID: <xmqqlhf725xy.fsf@gitster.dls.corp.google.com>
References: <1435243807-32112-1-git-send-email-cmarcelo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 16:55:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z88Z8-0001B4-4U
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 16:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbbFYOzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 10:55:40 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38794 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbbFYOzj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 10:55:39 -0400
Received: by igin14 with SMTP id n14so57186964igi.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 07:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=F7OLSOOD1XvG/MkPx49g73jlNJarBTgPX7D/qMmcxac=;
        b=A/4vbyBT7o59yDx0IMTmDqmXrZj1ZlSEBdlz2K+SDuF1A3ocavlnwtCeO1zluEp565
         5Eon/8ROfH4+mQA2TN2Z+Oc76ugDGqyiD5KwfQHlbZik1q4Xvji3NTSNBHvGLw+8YQF3
         ee3B60DzOG65N+QvxKbWYfb8aunFFjn5VqqXjg3dZLg/q5JuOkahaBQSoD7D+KNY2+xl
         CQPnV6sXnXNePjmmtbMzjqRDFKbHU4miAFpaijh4x28b4L3d2GMJDataINcYX10P17Rs
         s5p9wdWVYYjnPnulXXJYTVx9ZDyqBqszD+7UQNoH3UHHgXMaqb70fzzEgX62q3JdHbvD
         YnIA==
X-Received: by 10.107.170.216 with SMTP id g85mr52129146ioj.31.1435244138706;
        Thu, 25 Jun 2015 07:55:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id z195sm19737576iod.33.2015.06.25.07.55.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 07:55:38 -0700 (PDT)
In-Reply-To: <1435243807-32112-1-git-send-email-cmarcelo@gmail.com> (Caio
	Marcelo de Oliveira Filho's message of "Thu, 25 Jun 2015 11:50:07
	-0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272680>

Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com> writes:

> In projects that use Signed-off-by, it's convenient to include that line
> in the commit message by default. The commit.signoff config option

Hmm, I do not recall seeing v1 but that is OK.

The following immediately comes to mind.

http://thread.gmane.org/gmane.comp.version-control.git/51754/focus=51780

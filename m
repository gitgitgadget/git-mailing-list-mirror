From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/8] port branch.c to use the filtering part of ref-filter.
Date: Wed, 23 Sep 2015 12:16:32 -0700
Message-ID: <xmqqbnctx7xr.fsf@gitster.mtv.corp.google.com>
References: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
	<vpqsi65t0yi.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 23 21:16:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZepX8-0007C5-0g
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 21:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950AbbIWTQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 15:16:45 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34884 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754941AbbIWTQp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 15:16:45 -0400
Received: by pacfv12 with SMTP id fv12so49113145pac.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 12:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xN4CM2SJsB+UxQBJVlnT4Dz2tdid3ZIZxqucKWLTqfM=;
        b=T0A6tFF+FEu98GA7ncRChqyQdqDgD6Gx0sd9mOQQfsQg3Is4sbVbZ9oZQEt4K3ctrl
         iRATJ5YHzWmvxjoIwW096M31F3JttpZa5Ut4wIvbL237sPS/giU/AwPVAvpqan0NHVIg
         1e9Hj08dBtJiQVLAfJpDicZk7SxpFUha8UA6T+CxaOI6J8LSs44H21V1BnV4hRQhMUvJ
         Vd23TdgXVBiuBxbhVJ3ch7XvZXHZJ1TyQJJOcqLWt6CCmvkwUoMcsfmXQg0WsMF/MRA0
         V2btelP2qbiQrjtWzNyXYB6uYBfePqVRQ2ecb15jBRQk67ErVo6CKrSKz35Qzq+d1nnO
         58KQ==
X-Received: by 10.66.101.39 with SMTP id fd7mr38305908pab.3.1443035794165;
        Wed, 23 Sep 2015 12:16:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:a07c:76d3:22e9:4d3d])
        by smtp.gmail.com with ESMTPSA id sb6sm9393326pbc.12.2015.09.23.12.16.33
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 23 Sep 2015 12:16:33 -0700 (PDT)
In-Reply-To: <vpqsi65t0yi.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Wed, 23 Sep 2015 21:00:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278505>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> The series looks good to me. I did a minor remark on PATCH 5/8 but this
> should not block inclusion.

Thanks.  As long as the log message is telling the truth, I do not
mind the actual lossage of the error message shown to the user.

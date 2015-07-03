From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] list-object: add get_commit_count function
Date: Fri, 03 Jul 2015 10:49:40 -0700
Message-ID: <xmqqtwtl3zd7.fsf@gitster.dls.corp.google.com>
References: <1435815536-30611-1-git-send-email-lawrencesiebert@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Lawrence Siebert <lawrencesiebert@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 19:49:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZB55v-0006QQ-3A
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 19:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbbGCRtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 13:49:43 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37155 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755013AbbGCRtm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 13:49:42 -0400
Received: by igblr2 with SMTP id lr2so81099941igb.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+fgiBbwNuvlrmruW28mQxDe2r1XkV+5JYwNRG7iDdHE=;
        b=lGPVd92P6wwAKK+dLoIzGoz0ZMRjj26I2peM1tbADRCRdQkLZ97H/vogGGBogFwChj
         RBxiDSNnGz0cJucPl7FFL4WryVEd/7mW+4zewkc/gF3q4K7jX+FPjDYsr3lro9y8ojy8
         j+QZa7O7RO+ggLZfqQco9c4WR9cVxOke7isC620Vq01LaP8hyys5QOeDjh56vIC8PDPq
         X7eGT6Pl2RZkFsmDKM7xlREreWcEISuNMWLs6/ayEABfM7Yv3A6ofzS4Lyaw6KsDdRRX
         yMyROS4k4kiEKiOkXTPnYPEXfv8Ar/yMeAzKI4GrFXJQEHgV4uiEgRcyiOOaQgdCRe/w
         usKw==
X-Received: by 10.107.27.7 with SMTP id b7mr51809568iob.64.1435945781647;
        Fri, 03 Jul 2015 10:49:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:846f:c5d0:52c9:d18a])
        by smtp.gmail.com with ESMTPSA id fv2sm3863118igb.22.2015.07.03.10.49.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 Jul 2015 10:49:41 -0700 (PDT)
In-Reply-To: <1435815536-30611-1-git-send-email-lawrencesiebert@gmail.com>
	(Lawrence Siebert's message of "Wed, 1 Jul 2015 22:38:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273303>

Lawrence Siebert <lawrencesiebert@gmail.com> writes:

> Moving commit counting from rev-list into list-object which is a step
> toward letting git log do counting as well.
>
> Signed-off-by: Lawrence Siebert <lawrencesiebert@gmail.com>
> ---

No way.  Look at the things provided by list-objects.c API.  They
are not about formatting outputs.  printf() calls do not belong
there.

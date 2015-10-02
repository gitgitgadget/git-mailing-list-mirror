From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 27/43] refs.c: move should_autocreate_reflog to common code
Date: Fri, 02 Oct 2015 13:57:13 -0700
Message-ID: <xmqqh9m93s5y.fsf@gitster.mtv.corp.google.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	<1443477738-32023-28-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 22:57:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi7OJ-0006G8-Hp
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 22:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbbJBU5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 16:57:15 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34968 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbbJBU5O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 16:57:14 -0400
Received: by pacfv12 with SMTP id fv12so118288350pac.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 13:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/uAs02jdhaVUaWLlwD4FQZoRBZWkE6fTb0h1scvtJLc=;
        b=Hgx8jjszW1BEyGKSDGyQQUjjBVpgS2AZDjoiOXbvzH1Ca2BFmu0T/CEup+xBxgtVFG
         qZ8kpzh8o14CKawFdV3sb6iAR9kR4wubUSzl9LnShjujD6FD7EELeEz/egBCORdm1x3S
         Sc44KNZ5GMhm0vxO2w7FOomxdQ1kl6YiO5OsZ18QowuTJ6baEOtsByoal5Fg/09wimwZ
         WSvzmYg1qdJzcXf0O2nDAmby2MhitPxigkUJ2OETFnrmOcV56/Ti9MHR2KudKuXhYLOF
         eUnPJiLd3FgdD9/VdD0PDWTjldhMvZ/LVjpABf+/Fe8JJxm7EQQKLMTZXlbfGq5D3xYV
         Zmcw==
X-Received: by 10.68.109.2 with SMTP id ho2mr22751423pbb.158.1443819434475;
        Fri, 02 Oct 2015 13:57:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:5831:5c0e:ce5f:86ea])
        by smtp.gmail.com with ESMTPSA id bs3sm13545989pbd.89.2015.10.02.13.57.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 02 Oct 2015 13:57:13 -0700 (PDT)
In-Reply-To: <1443477738-32023-28-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Mon, 28 Sep 2015 18:02:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278948>

Up to this step everything looked sensible.

Thanks.

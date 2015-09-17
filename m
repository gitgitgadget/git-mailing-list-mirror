From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/8] branch: roll show_detached HEAD into regular ref_list
Date: Thu, 17 Sep 2015 10:21:32 -0700
Message-ID: <xmqqwpvphsgz.fsf@gitster.mtv.corp.google.com>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
	<1442129035-31386-4-git-send-email-Karthik.188@gmail.com>
	<xmqqzj0ovlno.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQ51+TKvOiJvWa-emmJJGirAqkr9m0a_7BrQ2UbiSJdjA@mail.gmail.com>
	<CAOLa=ZQxounTiJk0t+zB2-7=UQa8oL+uJ9EQpTkWL7kYFHjxwQ@mail.gmail.com>
	<vpqpp1hqgcd.fsf@anie.imag.fr>
	<xmqqh9mtkrg0.fsf@gitster.mtv.corp.google.com>
	<vpqio79oxva.fsf@anie.imag.fr>
	<xmqqeghxj8i1.fsf@gitster.mtv.corp.google.com>
	<vpqmvwlm0rt.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 17 19:21:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZccsM-00036N-M4
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 19:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbbIQRVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 13:21:34 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36744 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbbIQRVe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 13:21:34 -0400
Received: by padhk3 with SMTP id hk3so24846415pad.3
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 10:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4ZBKQvWZRN5C4ZVbHhigMp8iJGT4v3LcV7nLbUAIp9Q=;
        b=yZhdh0rRB26++opvEBvc7MNJiNFE3j0leIMR/uTk///eAyhaf+UawPUC3bNeJQjLj7
         bTC/QP5pyz8sgCrN4XX2GwH63SZxa746GZxIM35vRkOucEbsSmaOyy2DkO3qBOFsD288
         E/zz14jyspo7iE8213H3EQGbaAgr1l8i59c4Oz9YsP4pTrdf4OaUpxnLsMiXySWtVdho
         s56oM8VAF2bVhzSc1z2oEQN3ylrCTZbL346iXUmcRDtYQuhyxFWLp8pV2xJlwpUWycSu
         xVZ21dIUR2Lw6zAfXG9RS+oncD5kh/1xJ42690pDGOeIe5kuEh/7SU8ukXcbjnU3lpD+
         CKIw==
X-Received: by 10.68.244.34 with SMTP id xd2mr533658pbc.50.1442510493609;
        Thu, 17 Sep 2015 10:21:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:25ac:307e:6383:2d03])
        by smtp.gmail.com with ESMTPSA id ki3sm4517823pbc.9.2015.09.17.10.21.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 10:21:32 -0700 (PDT)
In-Reply-To: <vpqmvwlm0rt.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	17 Sep 2015 19:08:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278147>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> ... But we can decide "if sorting on refname, then
> HEAD always comes first anyway".

Sure.

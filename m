From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] pseudorefs
Date: Mon, 27 Jul 2015 15:04:27 -0700
Message-ID: <xmqq8ua1gsus.fsf@gitster.dls.corp.google.com>
References: <1438027720-23074-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, sunshine@sunshineco.com,
	philipoakley@iee.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 00:04:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJqVe-0003hC-RQ
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 00:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbbG0WEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 18:04:31 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35018 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497AbbG0WEa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 18:04:30 -0400
Received: by pabkd10 with SMTP id kd10so57886628pab.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 15:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=0Jo7LUyLSOEm74G2muKZPVOQqQMHIp4aazr1hj5Oflo=;
        b=TYZUdc++H5GU80PUmNc4NJn7tOpPdAEPJyvzxVkmme9MhOGo25iETxcsB5BMQcPXn0
         lJhO3r+eP2yivSBsaxVqO24Yc48h1OJecVTttEWkDcvWGqOFpUQl2F4CDxnRGab/AHef
         Unxzo5I0yeQHYBbt05rJe+6+Z0hAQRdlRBIElNE48Rb/a23qVYxFcMAx1KC01Etsox0s
         1o3I7ahon59fuZnIj7KBt64fUa0i6T+V/+qAeJIxj6VCJ6VTqCqTb2Z5tJC3foahz22t
         0cSCuN82/EkFAPx0TXh7RAXKIq0U2ngDQGIW1d0gMbNGm1Wl4/Mkqy1Vse9JKy/FC5C3
         Es6g==
X-Received: by 10.66.140.98 with SMTP id rf2mr75034328pab.138.1438034670087;
        Mon, 27 Jul 2015 15:04:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2496:725d:b368:d039])
        by smtp.gmail.com with ESMTPSA id da3sm31320322pdb.8.2015.07.27.15.04.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 Jul 2015 15:04:28 -0700 (PDT)
In-Reply-To: <1438027720-23074-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Mon, 27 Jul 2015 16:08:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274717>

David Turner <dturner@twopensource.com> writes:

> This version of the pseudorefs patch series is much simpler.  Instead
> of forbidding update_ref and delete_ref from updating pseudorefs,
> these functions now just special-case pseudorefs.  So we can use
> update_ref to write pseudorefs in a rebase and sequencer, and
> we don't need to rewrite so much code.

The resulting update_ref/delete_ref look quite straight-forward,
too.  Thanks.

> In addition, I made typo fixes suggested by Eric Sunshine and Philip
> Oakley.

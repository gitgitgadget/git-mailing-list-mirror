From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "HEAD -> branch" decoration doesn't work with "--decorate=full"
Date: Wed, 13 May 2015 07:51:16 -0700
Message-ID: <xmqq617wbkez.fsf@gitster.dls.corp.google.com>
References: <55534D95.60609@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git discussion list <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 13 16:51:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsY0J-00073c-Bq
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 16:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933809AbbEMOvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 10:51:19 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35956 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933623AbbEMOvS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 10:51:18 -0400
Received: by iepk2 with SMTP id k2so32804845iep.3
        for <git@vger.kernel.org>; Wed, 13 May 2015 07:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=W4/sN3qybYZtxL23HR2m0TJuPOyc9ztePnptVqAj9SU=;
        b=Yb9LC5bs94y20BrYOm4evaz/EZfy7nH4ErG4LhY8yceeD5hZ3L4xzV+kMfMN2dR5LA
         I4/xCe/fjzZV1q/KQ8s+v247S+6djqfYDY0TbCjKMil36L2NRKFBU0tbz+4+dleMuspw
         JkqggX+ZEMQ6i6dm2019f3iQco1UQg6NRGpz83+h5ZKxqtJYgUSAHfBkAAzChlC9a/Uh
         h7eP+k+PWlk2vYRBmacN13g9SIjd7Z4NVNIDbMx7TKSDSUI6qm6EJhve9ekD4su3y7Zb
         dWqxGM+Y3XtCEVxjnj0BZ3n+lQbDT3nW4oljPPVMw4KFo4NEmL2pBscNfXM6ULUmeibh
         iC9A==
X-Received: by 10.107.150.73 with SMTP id y70mr3676205iod.21.1431528677788;
        Wed, 13 May 2015 07:51:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3cfa:54ee:8e48:89ad])
        by mx.google.com with ESMTPSA id kl1sm3735208igb.15.2015.05.13.07.51.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 13 May 2015 07:51:17 -0700 (PDT)
In-Reply-To: <55534D95.60609@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 13 May 2015 15:11:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268986>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The new-style "HEAD -> branch" style decoration doesn't work when
> "--decorate=full" is used:
> ...
> Was that an oversight or a conscious decision?

I do not recall making such a decision, and I doubt (the other)
Michael wanted that way, either, so patches welcome, perhaps?

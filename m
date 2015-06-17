From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-checkout.txt: Document "git checkout <pathspec>" better
Date: Wed, 17 Jun 2015 08:29:54 -0700
Message-ID: <xmqqoake4akt.fsf@gitster.dls.corp.google.com>
References: <558127CB.70603@web.de>
	<CACsJy8CuRcV2Rxaz8Ut4ayW-Hyd8Aao5W4JMc20jcfggOG3d4g@mail.gmail.com>
	<vpq8ubiwqo9.fsf@anie.imag.fr> <mlrmnt$te5$1@ger.gmane.org>
	<vpqoaketusa.fsf@anie.imag.fr> <mlrn9r$9ho$1@ger.gmane.org>
	<vpqtwu6sf4r.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Andres G. Aragoneses" <knocte@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 17 17:30:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5FHu-0004OA-BY
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 17:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbbFQP36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 11:29:58 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35369 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbbFQP35 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 11:29:57 -0400
Received: by igbzc4 with SMTP id zc4so105882955igb.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/ARcz/+Hp6hWu8VPNklAwjYfrlWw75qsYumr9RtiDQ8=;
        b=NqaZ1ek2eRJxTIRLMvrOfviWMRczSJyHzoGcfhc3eEpO+yuRc/DWk+KTGDDK9dOy8c
         ZkBST7j/UVHm1WIZoDV8olK41qJ94Xo1B/+I0jM77vw+jHbWMrACgpBhU6suCMHj8k7b
         twNEtMKK4cOpIjz3uG366KdQD3Gb/hKI+XBK2afYQE7Cf60WBEF95X2iftxphmFZ81di
         DCpgD6T6D1pvYSXftwNGYjRH+Zhn2U2q9+F0II5ShkfKDg221LamMq+s73/7O5MzzMWv
         jZ0Eyl6/HYOCsOKHu+RFMldLt8+jh2psrQRO7LgHwxrYDkjwivmdsAuyXAlVUDL5a1D1
         /RKw==
X-Received: by 10.50.109.138 with SMTP id hs10mr12018268igb.48.1434554996948;
        Wed, 17 Jun 2015 08:29:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id b17sm2635872iod.32.2015.06.17.08.29.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 08:29:56 -0700 (PDT)
In-Reply-To: <vpqtwu6sf4r.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	17 Jun 2015 14:17:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271857>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Yes, but "Switch branchs or discard local changes" still does not
> describe "git checkout HEAD^^^ -- file.txt" (restore to an old state,
> but does not switch branch) or "git checkout -- file.txt" (get from the
> index).

You are right, especially when file.txt does not have any change
relative to HEAD, there is no "discarding" going on.  You are
actively introducing a change to an unchanged file by checking
contents out of a different revision.

> To me, "discard local changes" imply that there will be no uncommited
> changes on the files implied in the command after the operation.

Yup.

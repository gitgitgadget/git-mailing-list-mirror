From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 07/19] fsck: Make fsck_ident() warn-friendly
Date: Fri, 19 Jun 2015 12:48:48 -0700
Message-ID: <xmqqr3p77a3j.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<3e2deca4addda073f9b80e47865d2a5c95cea6e2.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 19 21:48:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z62HY-0006kh-50
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 21:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228AbbFSTsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 15:48:52 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35566 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbbFSTsu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 15:48:50 -0400
Received: by igbzc4 with SMTP id zc4so21581422igb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 12:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Rujn0NAH9FRc2Ix8kaxgsqhdLI029OzcaSvNWcD+qXw=;
        b=SdU8I3nZzNmgqPeChWrMlUcW0cET9XE1JYjasXvKS6IWRPL/NvOJHul1cwunayRUbv
         hT7A0N5HwRuS3me5fHjydcmVapWELjwpWCKCLz7lgMCmpaBzd/zV5zsGrmIIUvLv3CA3
         NsgfTW/jYm9xHwiT4+As5xpQJNptkW7hk6oSxlmE7dOxR6PfQEkRIBno8cnTQO5bVh6l
         10zlDF/ISGbdxWNzoNv9vmVcCE3UdT/jQLjvcl1Lis+ZFtlWiFhynGKmF8LhvctQOj8h
         Df0/mIH6K6rRZ/qGbbAauanbQ61L31XUZKs3Z+Azz3EAnBEmPINTDpq07kInwb4CkJp1
         7zTA==
X-Received: by 10.50.138.70 with SMTP id qo6mr6673314igb.15.1434743330168;
        Fri, 19 Jun 2015 12:48:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id y124sm7663067iod.13.2015.06.19.12.48.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 12:48:49 -0700 (PDT)
In-Reply-To: <3e2deca4addda073f9b80e47865d2a5c95cea6e2.1434720655.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 19 Jun 2015 15:33:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272191>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When fsck_ident() identifies a problem with the ident, it should still
> advance the pointer to the next line so that fsck can continue in the
> case of a mere warning.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Makes sense.

From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/6] stash: simplify option parser for create
Date: Mon, 13 May 2013 20:29:06 +0530
Message-ID: <CALkWK0n_QEUhNUSTTgzBjQDMqC7W86P_C5QDE_X-P06GDuj6wg@mail.gmail.com>
References: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
 <1368449154-21882-4-git-send-email-artagnon@gmail.com> <7vfvxrosnf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 16:59:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbuEB-00045C-UR
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 16:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754981Ab3EMO7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 10:59:47 -0400
Received: from mail-ia0-f178.google.com ([209.85.210.178]:35073 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051Ab3EMO7q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 10:59:46 -0400
Received: by mail-ia0-f178.google.com with SMTP id i9so3588500iad.23
        for <git@vger.kernel.org>; Mon, 13 May 2013 07:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=MsFVzd7ryE2yjs26r92aaHiNAoW7HRFs5SBk2EQowQo=;
        b=FwA02djSbODjsqZA77Av04W4C7ypGbyzA99L2zsxR+9yY+J+dn6In56uvMdHHSTHql
         YuC0OxD5K7DTi8VahWco99iKKIve8tbSA+955qaGEOjlOVWnYQ85eBj+UbYJ2onZwcwK
         v+HnTEU53OKGFZ3T6joe+iXVH3+nLo0y8BjSo8lX+Jyrvy7iZ2j9U8Ni/GNFze4aSvgN
         AnUgSBcDDcda81IaVbUf8WiwqyZyHUh7SB4EQVZjfpYbGc4Oa0DiGI6uChryEwwJUjFF
         LHdZzlhIhzSWKdVHuzI8wy7JnfkQbqt0iSqS5pcdFEeAccqU4X0DrU0fy/iasX4we2wc
         2S0Q==
X-Received: by 10.50.3.38 with SMTP id 6mr10361675igz.44.1368457186316; Mon,
 13 May 2013 07:59:46 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 13 May 2013 07:59:06 -0700 (PDT)
In-Reply-To: <7vfvxrosnf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224163>

Junio C Hamano wrote:
> The semi-user facing "git stash create" never was meant to take
> anything but a message sentence and "$*" is the proper way to say
> "everything is meant for a single message (just like echo)".
> Changing it to "$@" will change the semantics in a big way.

Ah, I see.  As an interactive caller, it is impossible to set
$untracked (I thought this was a mistake, but you're indicating that
it's intentional).  Okay, I'll fix the patch and documentation.

Thanks.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] git-rebase--interactive.sh: add config option for custom instruction format
Date: Mon, 15 Jun 2015 11:42:37 -0700
Message-ID: <xmqqtwu895k2.fsf@gitster.dls.corp.google.com>
References: <1434212818-94682-1-git-send-email-rappazzo@gmail.com>
	<1434212818-94682-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: johannes.schindelin@gmx.de, git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 20:42:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4ZLJ-0003Y3-8K
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 20:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755840AbbFOSml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 14:42:41 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36934 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171AbbFOSmj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 14:42:39 -0400
Received: by igbsb11 with SMTP id sb11so57196592igb.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 11:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=IDyKD7uM2ufZGm3rfnNMIO3M+RTdV67Zb52HwJvzi0A=;
        b=OZrzgDNlbP9n/rSWTg80l7L2aH2Rgpv1XI7BGBaSLI3stSg4zCFrhJNfsUNxu+PHJn
         aaVn6GpoJ/2FJQHs4CM27pQhXbBl05R9ccTSw2CsoMAfWEc9casY9FhmSOQLWsgfg7JP
         eXkAzhz/W5kJF3J7SYT8Dgqjj70Gov8mz2hsiLzoA+rIZBSyttHtJZminFm3go/ohme9
         9QIlCCyVRR2+GeXs4dzyr3j00JYqPWwg2VICfBhzVVtGRgVTCX3mNmIUGdFxr4JiQB7V
         cTzHJb+s5xU7TiMRBFCI0r/i2Bm9l/vy5KuJVAMXumV4kcRAtf/sAllgcchXIPHpjscI
         4Tvw==
X-Received: by 10.50.64.244 with SMTP id r20mr22384344igs.33.1434393759324;
        Mon, 15 Jun 2015 11:42:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id o19sm8140440igs.18.2015.06.15.11.42.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 11:42:38 -0700 (PDT)
In-Reply-To: <1434212818-94682-2-git-send-email-rappazzo@gmail.com> (Michael
	Rappazzo's message of "Sat, 13 Jun 2015 12:26:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271705>

Michael Rappazzo <rappazzo@gmail.com> writes:

> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 1d01baa..8ddab77 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -213,6 +213,9 @@ rebase.autoSquash::
>  rebase.autoStash::
>  	If set to true enable '--autostash' option by default.
>  
> +rebase.instructionFormat::
> +   Custom commit list format to use during an '--interactive' rebase.
> +

Funny indent (no need to resend, as I can locally fix, but I am
pointing it out because it was irritating enough that I had to keep
correcting it every time I replaced this series with a new version).

Thanks.

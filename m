From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] git help: group common commands by theme
Date: Thu, 14 May 2015 13:51:44 -0700
Message-ID: <xmqqa8x6khlr.fsf@gitster.dls.corp.google.com>
References: <1431608351-9413-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: =?utf-8?Q?S=C3=A9bastien?= Guimmara <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 22:51:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt06j-0005aE-0Z
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 22:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933905AbbENUvs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2015 16:51:48 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36820 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933873AbbENUvr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 16:51:47 -0400
Received: by igbpi8 with SMTP id pi8so177981252igb.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 13:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=MT3saHROp7mbJXoFGjxNmMxm22SJqOpl8gJ3OKU9FBA=;
        b=CKR/+IOaDMXpk5WyJi3GXbk93qO8Dni/YxI+vj+LH3HYg68Q5m9qpaYiMBOns15Z7g
         fs67XFsr71joa6g6xk4+gm/2a08yc3X3APupVhtvS3rg0UPDsCzFaqrCpwOQMu0B2G0A
         stOCDq9s405uxa9fjuGzdTJA9UqilVLOL4IJOVi1M3GCQAGb1QKSsyEGfoi06q+1rWBd
         vPkIu2bEttL88FHfeo+wkRStYmLrY1m/yf2tTjk1f+XNjQdTJN+yTyFSq6iXglVD1mQ2
         51+JtxWEoPfR/AdYsVU958Soblduwtyas6fNLTxAdWApGc1N1bqCqvGXl2oBSnpYaRx4
         i2ZQ==
X-Received: by 10.107.169.93 with SMTP id s90mr581178ioe.83.1431636706970;
        Thu, 14 May 2015 13:51:46 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:74eb:19e4:cd06:a6b6])
        by mx.google.com with ESMTPSA id h138sm139683ioe.2.2015.05.14.13.51.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 13:51:45 -0700 (PDT)
In-Reply-To: <1431608351-9413-1-git-send-email-sebastien.guimmara@gmail.com>
	(=?utf-8?Q?=22S=C3=A9bastien?= Guimmara"'s message of "Thu, 14 May 2015
 14:59:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269091>

S=C3=A9bastien Guimmara  <sebastien.guimmara@gmail.com> writes:

> This v6 is very similar in content to the v5=C2=A0[1], except minor f=
ormatting
> adjustments in 'git help' output and recommendations from Eric.
>
> The major change is in the patch series itself. Commits have been
> reordered and adjusted so that each 'apply' doesn't break the build, =
and
> preserve bisectability.

Hmph, did you decide to abandon the "whitespace fix" patch?  This
does not seem to be based on that one, and it would be crazy to
have these patches *and* the other one as independent two topics
and expect them to be merged cleanly later.

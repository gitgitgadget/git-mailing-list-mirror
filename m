From: Javier Domingo Cansino <javierdo1@gmail.com>
Subject: Re: [GSoC] A late proposal: a modern send-email
Date: Mon, 28 Mar 2016 00:31:27 +0100
Message-ID: <CALZVapn9KjXCpO+zaYuB6RSnG747u4a7e_m_HDg+uH-uz8UhQg@mail.gmail.com>
References: <CAKqreuyC8p9m_dgVpXCiT_hf=8qBA_5kZ5NABQGx0QDOiCBbww@mail.gmail.com>
 <xmqqzitm2zkj.fsf@gitster.mtv.corp.google.com> <20160327220002.GA29057@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Mar 28 01:31:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akK9y-0001y2-Ha
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 01:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbcC0Xbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2016 19:31:50 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36180 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbcC0Xbt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2016 19:31:49 -0400
Received: by mail-lf0-f43.google.com with SMTP id e133so25911468lfe.3
        for <git@vger.kernel.org>; Sun, 27 Mar 2016 16:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1DhNEikh71bWfDTo7ODzJwzTinDQCyvZnXJ00wqOOBk=;
        b=PqXSrX0bAcLDtbR/DLrTPYBH0GmRL6wfxJGQRkSpYuX42pMybJWZ61iSRmAv0c/pSf
         3IdrBpNUJbN5vEknuxaALz1X8YqICsxXuiMwr1f0s0cJSuBugh4hrSoHsFNGuJBafmcX
         T8cSlGgWxxj6wZtE6DL7kpQfYSgBtfOw3zsM2gos9IJwdcrERBQYCkGojkBangWR+3G4
         Yq9GcHITNcwMIeLlv/bs8L4nkBVD0ZEsc6shyvnji+9tCXb+y1wfGBJUPLVUB2XTKELt
         I8NXMtY0NBAAYQImtwLCKlRTs/4nRZx2MqN95oLYQZfSS0VLTR7XExPKoUYSb7uN/Wnq
         WZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1DhNEikh71bWfDTo7ODzJwzTinDQCyvZnXJ00wqOOBk=;
        b=m/cRTufrdkj/0mwp8ZltVtmj9l4GdYMqoNEeLalFa1vVEgIPDXs3B1yxUrQHQc9JtX
         g7jTm265DSqDvboVmofmPvEvUf4Psdf94a76wwK3Xz3Qs1nm6WYJWXnnUQrjvwnWwOVE
         RexV3eiX/6xVivYPR6C6ijvJGz/B8d5yc6OyzP33m6v6so3sRtOv72tjfPFMmNmG8fgp
         XWHzu3yLqVdGWDWMaBVEnVGxYoq3Aq19LLGWcNX9Q9pFQopavTn6La0dLILfGX9Z04WU
         KVFm7dL3DajvsCwbA9TlvczTC2wGe5HLOzyX11fJjTQAfQUaSrtYHCGolHIvZf+eFxg3
         B5og==
X-Gm-Message-State: AD7BkJL+Aza2yiNckYBner5XP1F9i9t8Xfrma1wGx68Xaqp7C0oYE9iG496XijRt/BEyaPPuecu3GK/OWp89PA==
X-Received: by 10.25.167.144 with SMTP id q138mr9126936lfe.17.1459121507474;
 Sun, 27 Mar 2016 16:31:47 -0700 (PDT)
Received: by 10.114.172.206 with HTTP; Sun, 27 Mar 2016 16:31:27 -0700 (PDT)
In-Reply-To: <20160327220002.GA29057@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290025>

> While Gmail provides SMTP access, it was (last I was told)
> incompatible with two-factor auth; so I've encountered users
> unable to send patches with their normal 2FA-enabled accounts.
>
> Maybe git hackers at Google have enough pull to lobby Gmail's
> web interface to make it easier to send plain-text patches;
> but I would love more to see users running local mail clients
> and even running their own SMTP servers.

Just in case, I use git send email with my gmail account and I have 2
step auth configured. The only "limitation" however is that you have
to create a password for each email client on it's own. If you own a
gmail account, go to
https://security.google.com/settings/security/apppasswords to create a
password for the email client.

-- 
Javier Domingo Cansino

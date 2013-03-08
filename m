From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/3] environment: add GIT_PREFIX to local_repo_env
Date: Fri, 8 Mar 2013 16:39:02 -0500
Message-ID: <CAPig+cRUCnWJLeuXL=LLk7kUkwPnHqaL_KGcSdq3yO+YZ345tQ@mail.gmail.com>
References: <20130308092824.GA9127@sigill.intra.peff.net>
	<20130308093025.GB1923@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Lodato <lodatom@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 08 22:39:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE50v-0008HT-Or
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 22:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757334Ab3CHVjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 16:39:05 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:48844 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756762Ab3CHVjE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 16:39:04 -0500
Received: by mail-lb0-f180.google.com with SMTP id q12so1703079lbc.11
        for <git@vger.kernel.org>; Fri, 08 Mar 2013 13:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=UYmAwqLvhHyCPF89pRYgp0y4uO9SmgnUbKiGOim/Lsg=;
        b=MXnVoEhfpA2/7JAqIwiVKriK5RxS6RCRzFpvPOsuqlRscOy0h+GddbRGlnCA38R+NX
         ZB8r4/fn0VGmTUWDaShXBGWcOnxkVycX+TELoEDo1Ju3UBXdiqdfMUmVSoqok2Mgnu9F
         0iQsFIcHCX500RgUCAehbnFIm8HOFp2r4dQ2geU/aB5ovmvPVTuOdlVb/xGl8bnh4fBW
         DZ09VHU2KSO+7BLi517qOMxX1A2DnSZvZbibZ+5ndW8L+/BKidWYrGTmj1xdy7T3xX7O
         LuR/qvXwlucLS1oWlYfu8+tR9N+TvSz4YtUcdI7cc01WKNKMfBiTyVHWeo7GOnXK75A2
         l9rg==
X-Received: by 10.152.133.130 with SMTP id pc2mr3258763lab.51.1362778742607;
 Fri, 08 Mar 2013 13:39:02 -0800 (PST)
Received: by 10.114.1.43 with HTTP; Fri, 8 Mar 2013 13:39:02 -0800 (PST)
In-Reply-To: <20130308093025.GB1923@sigill.intra.peff.net>
X-Google-Sender-Auth: Dz4VutXY1xG_xnQr8whszyQKLAg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217683>

On Fri, Mar 8, 2013 at 4:30 AM, Jeff King <peff@peff.net> wrote:
> The GIT_PREFIX variable is set based on our location within
> the working tree. It should therefore be cleared whenever
> GIT_WORK_TREE is cleared.
>
> In practice, this doesn't cause any bugs, because none of
> the sub-programs we invoke with local_repo_env cleared
> actually care about GIT_PREFIX. But this is the right thing
> to do, and future proofs us again that assumption changing.

s/again/against/

-- ES

From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] stash: tighten IS_STASH_LIKE logic
Date: Fri, 19 Apr 2013 23:52:00 +0530
Message-ID: <CALkWK0maM5ocSoSGy8OdL+hNW9mm_s1m1h+xJeCq-JKfTMW0Uw@mail.gmail.com>
References: <1366270717-19929-1-git-send-email-artagnon@gmail.com>
 <7vk3nz4h20.fsf@alter.siamese.dyndns.org> <CALkWK0m_Nt8SFdjGKWWHtBJ+HVsk095ukjZ0N=KBt5q+or5XFQ@mail.gmail.com>
 <7v38um2yvr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 20:22:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTFxU-0001up-7Z
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 20:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380Ab3DSSWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 14:22:42 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:37886 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203Ab3DSSWl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 14:22:41 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so5120542iec.28
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 11:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=MSzZhke3pCkq+FlDd40RGGDcWZe//vRzsxlyzANSpn4=;
        b=n4zz5yj7gL/asYcsnlo/wCsaqmsvLk/gCRj0ldYgwj/wveO/kVl6NsvRLXMuzqYqTF
         mjc8Np+6PVoIdD/HrqiCTl2qqs2Z5fw1IN/QyBYDbgD+/GBMbQ+ZLPHu4Jd6xD4Fc5oa
         ukJWT0u8iOcDwdvXOfAsrhBV3LLMPTENm3yuNofToDb9U/WG+ZOTGQ4WCiDxmtc/8er2
         dGz5QELzIpy8cs81cPQQu2s6Ph0PTdE8J0IDFRJFGjRBPMVJAIl8mGVCu0aA8PIImXmJ
         V2WDmJOcDmO3pWDf8enyMyuYDiUWYb607sq35XqKIgpwo+rgNOWp+IYSRFAbZn6xcLeL
         3+2A==
X-Received: by 10.50.17.71 with SMTP id m7mr9964287igd.14.1366395760637; Fri,
 19 Apr 2013 11:22:40 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Fri, 19 Apr 2013 11:22:00 -0700 (PDT)
In-Reply-To: <7v38um2yvr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221791>

Junio C Hamano wrote:
> The risk of actually closing the door for future developers.  That
> is a downside of this patch, if we were to apply it.

Okay, no issues.  Drop it.

Consider documenting the fact that IS_STASH_LIKE is merely a
contextual synonym for IS_MERGE_COMMIT somewhere though.

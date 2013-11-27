From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] gitk: make pointer selection visible in highlighted lines
Date: Wed, 27 Nov 2013 15:29:53 -0500
Message-ID: <CAPig+cTKofBCdgwJkpyPsAHjhi4-GqPwU2CuOAPsf_qr8isJ9w@mail.gmail.com>
References: <20131127180601.GA31211@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>, Git List <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Wed Nov 27 21:30:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VllkF-0002uj-VZ
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 21:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757932Ab3K0U3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 15:29:55 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:59174 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757783Ab3K0U3y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 15:29:54 -0500
Received: by mail-ie0-f177.google.com with SMTP id tp5so12475334ieb.22
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 12:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=JUtVoZX7QLZIyleBe14xVqQvcWTBKXzbDA/auPwUIQs=;
        b=almYRsz1zRHC1/RF78ePBffwC3cUH1lg7VjHdEHcqarPVDmh8/mOccILeK6CjRZr1U
         /bbkAUSn4Nu7aE0Jy0CTDGl2jHVEAkq71p4BMlBsRPUUbjzklf/Opo4067y3z1peye3c
         FTt2MZNLpGiSgtAdNIUwPaq0hT3wmPSuVNE1re+rATCVKjQpUNftydF2rHfBhYyfKKVN
         SCq+B/6oDJXR4zJhgf/z+8SYbs9ly/u3ci5OVk3m0Fl4wtPf7wHlhLy+TCUaY71Yk+GE
         9H9P216CU0UHr6vQui0Aq124JWwxTbaJfA2noXlYOWuyh3E6rXzPc5vIYiWmO2ChZH3E
         ucSA==
X-Received: by 10.50.13.9 with SMTP id d9mr23473256igc.25.1385584193607; Wed,
 27 Nov 2013 12:29:53 -0800 (PST)
Received: by 10.64.250.198 with HTTP; Wed, 27 Nov 2013 12:29:53 -0800 (PST)
In-Reply-To: <20131127180601.GA31211@wheezy.local>
X-Google-Sender-Auth: IzvbdR5802uEo4sdta_vaE5USDA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238460>

On Wed, Nov 27, 2013 at 1:06 PM, Max Kirillov <max@max630.net> wrote:
> Custom tags have higher priority than sel, and when they define
> their own background, it makes selection invisible. Especially
> inconvenient for filesep (to select filenames), but may also affect

s/aslo/also/

> other tags.
>
> Signed-off-by: Max Kirillov <max@max630.net>

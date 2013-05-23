From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 16:59:34 -0500
Message-ID: <CAMP44s3hyekQBxV13=+4qcJEMZe4TY6ZoMMDLN8yKFJJ=t_7rA@mail.gmail.com>
References: <20130522115042.GA20649@inner.h.apk.li>
	<7v4ndukhx0.fsf@alter.siamese.dyndns.org>
	<20130523090657.GB23933@inner.h.apk.li>
	<CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu May 23 23:59:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfdXw-0004PK-9z
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 23:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759690Ab3EWV7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 17:59:36 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:48285 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759313Ab3EWV7g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 17:59:36 -0400
Received: by mail-lb0-f182.google.com with SMTP id z5so3910814lbh.41
        for <git@vger.kernel.org>; Thu, 23 May 2013 14:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oIKyhxU6/kg1i+jCm2EFYGewnm4cyaTS9d/WI6SALBg=;
        b=HlrG4sJ0GbH53ANLm3QvjXfQNr14qF69jlLQACRPOWe4d0/M3tyPoQym1Ge9MHyXbq
         COiZBpSADFF4ycqkRorEXEo5i/hF/eguhrwIIy9YIQvF+nzYRx24hwkxGKHLksSfVkqg
         Bek14Na/WnYPevTYZgbTMIKRTgyFNXALnqY/3qDVagHOheDazGKj/IM3nHF4HlgK9y5+
         j0KaOoLUXBKHbYrmvbQw6FqNIWikCkJSRZK5EqyhSi9XenvlRhNmBgFhsRK+B87/O8gh
         w7zeqENTba46rRLoLGBYWkZbcgb7022aM5ha3lHBvrPI1RiBdoB2WxwlHYUal54vUtm7
         ki1A==
X-Received: by 10.112.218.102 with SMTP id pf6mr7441670lbc.77.1369346374615;
 Thu, 23 May 2013 14:59:34 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Thu, 23 May 2013 14:59:34 -0700 (PDT)
In-Reply-To: <20130523215557.GX27005@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225307>

On Thu, May 23, 2013 at 4:55 PM, John Keeping <john@keeping.me.uk> wrote:

> So I was asking if it would be sensible (possibly in Git 2.0) to make
> git-pull pass --ff-only to git-merge by default.

Definitely yes.

-- 
Felipe Contreras

From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: L10n regression in 1.8.0.rc2: diffstat summary (git diff --stat,
 git format-patch)
Date: Wed, 17 Oct 2012 18:51:21 +0700
Message-ID: <CACsJy8CS9TKGaT8+MQ_JOEQD+fgnc9HVAbr1pjQ3JE_3ZjE9=A@mail.gmail.com>
References: <alpine.DEB.2.00.1210171145360.12699@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Oct 17 13:52:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOSAQ-0005Wa-47
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 13:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756615Ab2JQLvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 07:51:54 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:43633 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754602Ab2JQLvw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 07:51:52 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so7291304oag.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 04:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aAUx9RY2ev2I8tApmUuoR/yQyYITOJNeAl3dqjFJmXc=;
        b=BaeTVysCoyciL7s11lZDAgZIcou6OZ+gpbPduoKdgJJLMlofnreygagBGh9RQhWBJz
         a8tZ55wCxznBbeEuE6w/8pMEpdUOo7aNaCmcHTJHyHQt3UkUTmAUCSbhnkWxPi3uhpBg
         FK18pI3V20qmc3bBqxl7TKSPFlbB/AqINajCk7ubD9hnt88xqCSWQpJXVSDumgiZ+gRg
         rluYufp906r+Qs6sBFLcxcmk8eKPp5lBlbrG/EjvWg0ZNie1V+rddP3gmXfsrl5BV9RD
         STQnCouyGTI7tk7GWEFeMFRQKxE6Xjpe5wcy1MCbHALQRHq9ocEveaVEnGwnIHjFGlLR
         7nAQ==
Received: by 10.60.22.136 with SMTP id d8mr14914812oef.124.1350474712050; Wed,
 17 Oct 2012 04:51:52 -0700 (PDT)
Received: by 10.182.108.10 with HTTP; Wed, 17 Oct 2012 04:51:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1210171145360.12699@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207910>

On Wed, Oct 17, 2012 at 5:53 PM, Peter Krefting <peter@softwolves.pp.se> wrote:
> Hi!
>
> The output of "git format-patch" and "git diff --stat" no longer becomes
> localized when using 1.8.0.rc2, compared to 1.7.12

It's the result of this discussion [1]. I don't remember exactly the
open issues. But I think it involves drawing a line between team
language vs local language, whether team language can be anything
other than English, the maintenance cost for supporting it. You're
welcome to revive the discussion. Maybe we can find a solution that is
agreed by all parties.

[1] http://thread.gmane.org/gmane.comp.version-control.git/204285/focus=204283
-- 
Duy

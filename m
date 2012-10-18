From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/6] Bring "format-patch --notes" closer to a real feature
Date: Thu, 18 Oct 2012 18:06:10 +0700
Message-ID: <CACsJy8Dxx6JtRXP_HWNBrobNems+4UsaOGSRef08cf8--b5dOw@mail.gmail.com>
References: <1350539128-21577-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 13:06:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOnwD-000257-HT
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 13:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483Ab2JRLGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 07:06:42 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62191 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754903Ab2JRLGl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 07:06:41 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so8379634obb.19
        for <git@vger.kernel.org>; Thu, 18 Oct 2012 04:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YcgQVNi+TKvwKvXia4y++dYFbTVH/5lOrnoMNOk9p2k=;
        b=kHl3SYsFaQ3wxSaB1dIrI3g2uAZ8EB85iZrn3CjiCu6TTGJpTrkBmkquREi0zurec0
         SoRGPJEFo8Wq4vEvI/9p+eI724afGGlNin7T7mKpRRHddIvWh6FUuMSh53h3y2C0C73v
         4boMV2eUImBtvSp6M6DFjCz5fuVxHASDv8joVt5CcC/up0bRGQGBURfhstGigvW8wBoS
         OTgAMcMizWXghqgjqfD4iReY3dBFYACQPmDeW5rA/jCYfRRQS3l+OmxDy/vjX+3vEhC7
         lV5SQqKIl8gyM5aYsdu3rXuMP7g00eSLmdUUHNG1Qi/vISK8DHsBhNZh8j9bmkesuxPN
         uZwg==
Received: by 10.60.1.40 with SMTP id 8mr16816777oej.55.1350558401189; Thu, 18
 Oct 2012 04:06:41 -0700 (PDT)
Received: by 10.182.108.10 with HTTP; Thu, 18 Oct 2012 04:06:10 -0700 (PDT)
In-Reply-To: <1350539128-21577-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207995>

On Thu, Oct 18, 2012 at 12:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> This replaces the earlier "wip" with a real thing.
>
> We never advertised the "--notes" option to format-patch (or
> anything related to the pretty format options for that matter)
> because the behaviour of these options was whatever they happened to
> do, not what they were designed to do.

Stupid question: does "git am" recreate notes from "format-patch
--notes" output? If it does not, should it? I think it could be a nice
way of copying notes from one machine to another, but not enabled by
default (iow "am --notes").
-- 
Duy

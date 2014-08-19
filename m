From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/18] Signed push
Date: Wed, 20 Aug 2014 06:07:02 +0700
Message-ID: <CACsJy8AMCR5v1YYfA1AWWWXuYyuvOpsuXUfYzWfxhPYZE9SbcQ@mail.gmail.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 01:07:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJsV8-0001ke-O3
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 01:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbaHSXHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 19:07:34 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:41585 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbaHSXHd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 19:07:33 -0400
Received: by mail-yh0-f42.google.com with SMTP id a41so6375354yho.29
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 16:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=j1yA8Rs72aBOPOSdeCNAALmmTro5TZtgXRQXmDYgF3Y=;
        b=0ZGu3ZOOw3ADfkJDSO/sHjxUNcO7AjPKF9lxQpU/Vq8dkBlJkwI1hJtjZaasrUIM0j
         G1MAcgto5ANeA5/9uqKxDk4xQwhuE8LdVrcbgKrLcbRNl5vhNwzyT251YI0AJraXiX+j
         r8GZ1NEMCiNkZCVaqUoKA1DXz1WuV0O/mPFuiNrjyWdyIFMaf7oJB3NaMg86od6GFHp2
         63gNmxASXGobTZ6zuuUAJQTaDQJxK6a/Yl56Z8MzweT3IqkBN2ITpftZW2o8YtMKc2xD
         t5f7zsKcqi4j25jdnwA6Keb6hk78qSbnGJB5iB4YhMbCAuA3/5HBBd73SL8wuHNZATPi
         SqMQ==
X-Received: by 10.236.38.71 with SMTP id z47mr71715335yha.18.1408489652964;
 Tue, 19 Aug 2014 16:07:32 -0700 (PDT)
Received: by 10.170.68.80 with HTTP; Tue, 19 Aug 2014 16:07:02 -0700 (PDT)
In-Reply-To: <1408485987-3590-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255543>

On Wed, Aug 20, 2014 at 5:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> While signed tags and commits assert that the objects thusly signed
> came from you, who signed these objects, there is not a good way to
> assert that you wanted to have a particular object at the tip of a
> particular branch.  My signing v2.0.1 tag only means I want to call
> the version v2.0.1, and it does not mean I want to push it out to my
> 'master' branch---it is likely that I only want it in 'maint', so
> the signature on the object alone is insufficient.
>
> The only assurance to you that 'maint' points at what I wanted to
> place there comes from your trust on the hosting site and my
> authentication with it, which cannot easily audited later.

I only had a quick read of a few important patches and may miss
something. But all this audit recording is left to the hook, right? I
suppose git-notes could be used to store the push cert. blob, or the
server could make a signed tag to record this info in the ref.. or do
you intend any other way to record these blobs?
-- 
Duy

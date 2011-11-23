From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH] run-command.c: Accept EACCES as command not found
Date: Wed, 23 Nov 2011 14:25:38 +0100
Message-ID: <CAH6sp9PMjywExthnizo-UOf26V-9f1q1DjAtTfA+Buihuuj+fg@mail.gmail.com>
References: <1321912387-4569-1-git-send-email-fransklaver@gmail.com>
	<7vbos5f7ix.fsf@alter.siamese.dyndns.org>
	<op.v5bjtk1r0aolir@keputer>
	<7v62idf2vy.fsf@alter.siamese.dyndns.org>
	<CAH6sp9MxbDhQ3RiA6jO1fswAZX3R6C2fv0gzJdpGp432ovWsjQ@mail.gmail.com>
	<CAH6sp9N2ycsoU=is3BVanH33CowD+sMNmWq=Z1MsPJX=HGYY+g@mail.gmail.com>
	<CACsJy8ATJ33i5YaM-APtUPq_fDkj9=JpKj9pmvqWK2QodgbexQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 14:25:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTCpd-00040y-Gw
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 14:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499Ab1KWNZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 08:25:40 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:46373 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab1KWNZj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 08:25:39 -0500
Received: by qyd20 with SMTP id 20so359816qyd.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 05:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iTu+Bo/J2N4ECY4FwkVsXEyDB/ajQcwMjIxonwx2NO4=;
        b=EGMNU32pTzeMXPSDA81yNtXGLnEAofA0CJDzsCNWSlZ2aoImgdGdCqQ/48GikBPlWv
         yoRz1JGja3rDRShw+lm8ubX2y7SWdjdo0rorNZY/igZRKPEwKvXMuw79cXp7xsnCb/oo
         9EIUJjGP4blIS/qAuZnxiyHlnZo4kt8r3apIQ=
Received: by 10.224.217.66 with SMTP id hl2mr5551848qab.84.1322054738637; Wed,
 23 Nov 2011 05:25:38 -0800 (PST)
Received: by 10.224.86.11 with HTTP; Wed, 23 Nov 2011 05:25:38 -0800 (PST)
In-Reply-To: <CACsJy8ATJ33i5YaM-APtUPq_fDkj9=JpKj9pmvqWK2QodgbexQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185848>

On Wed, Nov 23, 2011 at 1:04 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:

> If you print diagnostic messages with trace_printf() and friends (only
> showed when GIT_TRACE variable is set), then there's no need for being
> terse.

I'll keep that in mind, thanks.

Frans

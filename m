From: Vicent Marti <vicent@github.com>
Subject: Re: [Announce] libgit2 v0.17.0
Date: Thu, 24 May 2012 03:57:24 +0200
Message-ID: <CAFFjANSyRbm=0Q+EFXL8HGJnr=4CBW6phzeEjaCb26wVf4EaXg@mail.gmail.com>
References: <CAFFjANQ_kfRc8LhZD4nxeYmRML6i5dQEskUv3Caz7GmnvZi2Jw@mail.gmail.com>
 <nngy5oi3o37.fsf@transit.us.cray.com> <7v8vgi263h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: dag@cray.com, libgit2@librelist.org, git-dev@github.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 24 03:58:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXNJh-00053U-H8
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 03:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110Ab2EXB6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 21:58:08 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:65530 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863Ab2EXB5p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 21:57:45 -0400
Received: by vcbf11 with SMTP id f11so1221254vcb.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 18:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=SoQQtNpkyuj2XoAV2ME0jerRZaqE0BqBXRbbtkFq8ew=;
        b=w0hjnLR8gaDx6jpxEpR+VKJLFjaPGfTRW6I8c/xvcoeRPP2vtOLWgN7Y6dM6jbG7oi
         lzoMFnDQpe7CvTuUDkzJ9wR6iSYyocj7bwc2S/scUnZ+BYYX2SQIopu+5n+ecZ0SzfRB
         6sAo2pA4B9gJAFLNd4uJHsCfQ+8PfiL/FOLZPwQ0dmH+De+PYu0AkLcLwrb2np5qw0JN
         pe2s78+4ubF69ka1I0/6wK0SS2D+ELCKUd9hMGgcZFyYwZbaoncw02QAP1ZVv0rNH8ge
         W06JSw8cjgj9HZNmLLYnJ+18EHH95QgH3txFxvO1qM0E70/QOz8jrSaqyS+olER95Sso
         Ewsw==
Received: by 10.52.29.69 with SMTP id i5mr14010213vdh.84.1337824664442; Wed,
 23 May 2012 18:57:44 -0700 (PDT)
Received: by 10.52.30.104 with HTTP; Wed, 23 May 2012 18:57:24 -0700 (PDT)
In-Reply-To: <7v8vgi263h.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: ETNatrRIg5DzRzAXp-hu9ttzJ_4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198341>

On Wed, May 23, 2012 at 6:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I am hoping that the library would become solid enough to allow us to
> start attempting such an experiment some day, but at the same time, I know
> that that "some day" is not in a very near future, after having seen at
> $DAYJOB that a certain internal tool linked with a version of libgit2
> breaking user's trees from time to time, bugs against the internal tool
> getting filed and then some of them getting fixed at libgit2 level, either
> by upstreaming fix or by updating to newer snapshot of libgit2.

If you're building internal tools with libgit2 and encountering
issues, maybe somebody from $DAYJOB could spend some of his 20% time
in throwing us a hand pushing the library forward. That way $DAYJOB
and the whole community would benefit.

Love,
Vicent

From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/6] stash: introduce 'git stash store'
Date: Mon, 13 May 2013 23:45:37 +0530
Message-ID: <CALkWK0m=oz_U6kRbGAjdU=m5g_ZiJf016af-KpdEesm02CMCkQ@mail.gmail.com>
References: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
 <1368449154-21882-5-git-send-email-artagnon@gmail.com> <7vbo8fosd9.fsf@alter.siamese.dyndns.org>
 <CALkWK0kMj6q1rppzfxGWrthub4K_+C+jnvF=K4m2Fhk0pAnt7A@mail.gmail.com>
 <7v61ymop61.fsf@alter.siamese.dyndns.org> <CALkWK0mQhzrndaEp28nOpLs5STq136PY8hntCpX5RUZKrdJVAA@mail.gmail.com>
 <7vppwun5zk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 20:16:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbxIX-0005jg-AS
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 20:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812Ab3EMSQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 14:16:19 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:43563 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618Ab3EMSQS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 14:16:18 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so13012829iec.22
        for <git@vger.kernel.org>; Mon, 13 May 2013 11:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=RoYw8K0Fa4fSAHeWtSkUh4gOv6G2HTthB8N7pNaybjw=;
        b=MOBPXfpgqYtW3aAMqBwm2/3A542MpNCgTXuw8RqDtJV8Yh9fXgZdRPlJQDCVYELAr3
         uJ/rl91n0fAHCJnWrEK7t874S/1YC4ofoDmAuBZV7VLYtCQ25kdo1D8ZXLtUIDRIQ5/O
         sxSWGBlsPc6ofN0aESGXEAJaqrgCnkykGgXsiL7WNYEpscC+uCSapKLJvH+vKrNhpqRt
         UhHVo338boZnjDIu6VarIfRkrOWE8TjYyDhCHy5wzqblniQGd8sAbKRhyhwdB7ZH6fiF
         Ma2VEygDZ1QpwZClSm3OY9HbVfHyBXfbsHhvi83nxsvjZsS95TcI/MCVL6Amfea3xFZP
         ZfzQ==
X-Received: by 10.50.66.140 with SMTP id f12mr10648214igt.63.1368468978018;
 Mon, 13 May 2013 11:16:18 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 13 May 2013 11:15:37 -0700 (PDT)
In-Reply-To: <7vppwun5zk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224184>

Junio C Hamano wrote:
> *1* And no, don't even try to rewrite "git merge" call inside "git
> pull" to use the modern style with "-m <message>"; you will likely
> break it (I've tried once and decided it was not worth the hassle).

This falls in my basket of "nice theoretical exercise": a lot of work
for no tangible benefit ;)

Footnote: I'm not saying that code is not important; you've seen me
arguing for beautiful implementations several times before, against
all odds.

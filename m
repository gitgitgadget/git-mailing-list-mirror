From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] standardize usage strings that were missed the first time
Date: Fri, 3 Apr 2015 16:47:18 -0600
Message-ID: <CAMMLpeQkZ2jsuBg_J6veHpGcZiwwSzt+8xQ1g+dL2G18SnBtPw@mail.gmail.com>
References: <1428010016-12968-1-git-send-email-alexhenrie24@gmail.com> <xmqqego2i47o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: pclouds@gmail.com, Ramkumar Ramachandra <artagnon@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 00:47:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeANN-0006OK-0v
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 00:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbbDCWrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 18:47:40 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:33681 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbbDCWrk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 18:47:40 -0400
Received: by wgin8 with SMTP id n8so31094313wgi.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 15:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ftp2Ef2ckjAlt5p1u3T1KVg8bxW1L8Nqz39JndR5tj4=;
        b=EQJAEM6C0o+D30ZzQ0/17rEGIGnwpCxUkOW2V2MYYJjstYoWCfZ/008PGjtrTEX3qQ
         2PzjkEg5ZV3aoDsC6cpT6F17l5LP6t+Oi5YuSCPQS8yFopkLXYU6Tlo231dJZdQZcE6c
         RVC5C54C9xFJi/h4CfKUXaTENI07fyOVD06kSPq6M7fVdyp1IVc5BiAP87dt9jilQPVf
         K6nMjWUspUua/pSShcuNxUWdX+wSBYEkwB9eysfllGybiNCCLhHu3GT3uF/dJH02SkoD
         OMwqaRT/U4I5NrdxMQeaPbcTliwnkKEyJn9efxJm1BjGwKjHMRYJuXhmABxH5M39kE+T
         2F8w==
X-Received: by 10.180.101.233 with SMTP id fj9mr37221012wib.65.1428101258748;
 Fri, 03 Apr 2015 15:47:38 -0700 (PDT)
Received: by 10.28.182.196 with HTTP; Fri, 3 Apr 2015 15:47:18 -0700 (PDT)
In-Reply-To: <xmqqego2i47o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266744>

2015-04-02 15:56 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
> Thanks, but please no more _("string") changes for the rest of the
> cycle, as that would impact i18n folks who will be starting from
> tagged -rc releases.
>
> Please hold them off, and resend them after 2.4.0 final.

I thought that during a code freeze, you held onto patches or
committed them to a staging branch. But it's OK, I will resend after
2.4 final is released. Thanks for the clarification.

-Alex

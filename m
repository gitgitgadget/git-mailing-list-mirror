From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v4 00/10] nd/clone-detached
Date: Sat, 14 Jan 2012 11:48:25 +0700
Message-ID: <CACsJy8DggQdM1aoeL+u=3Wz+5f7hi4eG=6MHXPCJZ6pOmhQJ_w@mail.gmail.com>
References: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
 <1326439322-15648-1-git-send-email-pclouds@gmail.com> <7vvcofxtv8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 14 05:49:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlvYV-0007h3-39
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 05:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574Ab2ANEs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 23:48:58 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33767 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab2ANEs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 23:48:57 -0500
Received: by bkuw12 with SMTP id w12so447935bku.19
        for <git@vger.kernel.org>; Fri, 13 Jan 2012 20:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=K4DR+y29t7TIoZFqo6I8LrEw6irmvY1ViKXBS97EX5M=;
        b=iO1IPfbqpvA8qIL3CF22Nb1Je6vuvC8UzMyHAT/nH6LHuQmyp5J58pijI03+TX+xAI
         WDCqKnIZDlBcEKlabDOUYoalCQcuAW/lrsgdbW5i+/hOUEWwgfkIHrS9CBUGBsNRFMnU
         rMJNzJ3NztNwOKEkOe8vh7OpBjOnEsn3XS6RU=
Received: by 10.204.154.200 with SMTP id p8mr1487623bkw.4.1326516536168; Fri,
 13 Jan 2012 20:48:56 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Fri, 13 Jan 2012 20:48:25 -0800 (PST)
In-Reply-To: <7vvcofxtv8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188546>

2012/1/14 Junio C Hamano <gitster@pobox.com>:
> Thanks, replaced (and updated comment strings read much better).
>
> There were some conlicts I had to resolve while merging this to 'pu'.
> I would appreciate it if you can eyeball it to make sure I didn't make
> silly mistakes there.

Right, the conflict with nd/clone-single-branch. I kept thinking there
would not be conflict because clone-single-branch's big change was in
wanted_peer_refs() and missed write_followtags() call. The merge looks
good.
-- 
Duy

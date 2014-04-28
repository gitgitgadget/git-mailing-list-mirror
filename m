From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 03/12] MINGW: compat/mingw.h: do not attempt to redefine
 lseek on mingw-w64
Date: Mon, 28 Apr 2014 17:02:09 +0200
Message-ID: <CABPQNSYOy3k4-4p08wRcWyiVW-SPqp4Ax_oMc8eACRcTSSHvaA@mail.gmail.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org> <1398693097-24651-4-git-send-email-marat@slonopotamus.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 17:03:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wen5X-0003xs-I4
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 17:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756475AbaD1PDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 11:03:15 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34584 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756460AbaD1PDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 11:03:09 -0400
Received: by mail-ie0-f172.google.com with SMTP id at1so3290918iec.3
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 08:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=qm9hLUZpOuxLNlJ42McaEnrBN4gMtb7CSVJnz8b3VQw=;
        b=B/3HjuFupEcIK98VUUlZuOrcWxPhkf4I18+7Ad9afu4GziZ5Jb2YMokyUDfvQWPeyB
         5IcNjnUSsXG76DaTO82TqDkeyHIfLad2hKfgrlD5343RykIQcT2jFDBVISPb5OPa+GpB
         Hf6nBHA+60KPRvv0MKw7NriIFTKPlryVhYiI/2J1kLbWR6q752zwquLLQHPfMao+jjID
         EGRssuaGrzf7blgj+BU6YakXM0sr6puvXY5oyJ8fOmVEPnq9kFBE66WB7ZjmvwZjEObg
         BsGRFqwKrMc75m4lwYwu9sFa5ntp2T+ia9HQkCngQH1mKgxIYrvk+JfPtm26ZNEqiJ6g
         Sqxg==
X-Received: by 10.42.161.69 with SMTP id s5mr2781315icx.70.1398697369850; Mon,
 28 Apr 2014 08:02:49 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 08:02:09 -0700 (PDT)
In-Reply-To: <1398693097-24651-4-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247351>

On Mon, Apr 28, 2014 at 3:51 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> mingw-w64 has lseek defined in io.h.

msysGit has a declaration of it in io.h as well. But it's not a
preprocessor-definition... Are you saying that it's a
preprocessor-define in mingw-w64, that points to a 64-bit version? If
so, looks good.

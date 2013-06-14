From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] pull: respect rebase.autostash
Date: Fri, 14 Jun 2013 18:16:23 +0530
Message-ID: <CALkWK0mbmxahhxqw10vt6Xmc02+ZhmM5XACSMfSfcCyTOs0RBg@mail.gmail.com>
References: <1371200178-9927-1-git-send-email-artagnon@gmail.com>
 <1371200178-9927-2-git-send-email-artagnon@gmail.com> <CABURp0pVzQ2rVB-B2L+uCMtPV7QFPSgkZnHitCsrPCrR9LJOVA@mail.gmail.com>
 <20130614122950.GE23890@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <phil.hord@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jun 14 14:47:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnTPN-0007Az-Sl
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 14:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595Ab3FNMrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 08:47:06 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:49072 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606Ab3FNMrD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 08:47:03 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so1290899iet.37
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 05:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xRkTVEDicRu4UOCeWIwZPq881SSfVQyVWeJUCxbVFXg=;
        b=n2rEptCUz+cj0RuF7BFQPasuFn+LoFiQ/gsz2s6O0r18ZASHT1jvBucOezN+uxVcMJ
         1JiqsOCyuVi8bUyVYl/TXvDb2QiKXiQ/LnYliMdQcd1KF5NKk8MUg0N7THcKycON/XnS
         YlcqeohmIJNu9FYfsF5kKWwcswdJx7PJwqnPJoykA5zg+BVmcTH6/Zypy0pGzU3WEvXT
         gr8cK7evX0gohCrLCWXFl6KOYANyCYdWhVDPA6L3P5ydLA2J8g4Q/hDQIpUGle8UxfjP
         bS5R+BHR9LLhhTFg+edjZA3mnPs/m+WQ99u7AV0sHu+wAnehRuSyA2kcEMoGXJkeyiG2
         MOPw==
X-Received: by 10.50.154.106 with SMTP id vn10mr939336igb.0.1371214023222;
 Fri, 14 Jun 2013 05:47:03 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Fri, 14 Jun 2013 05:46:23 -0700 (PDT)
In-Reply-To: <20130614122950.GE23890@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227820>

John Keeping wrote:
> Is something like this clearer?
> [...]

Yes, thanks.

From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/3] nd/clear-gitenv-upon-use-of-alias
Date: Tue, 22 Dec 2015 17:57:09 +0700
Message-ID: <CACsJy8DFmZSa2x4y2fDwVsvwa5uAuMJn8v=utvYtAPTGFbdWPg@mail.gmail.com>
References: <1449166676-30845-1-git-send-email-pclouds@gmail.com>
 <1450597819-26278-1-git-send-email-pclouds@gmail.com> <xmqq4mfbfqla.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Anthony Sottile <asottile@umich.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 11:57:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBKdW-00027n-0I
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 11:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbbLVK5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 05:57:41 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:36093 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbbLVK5k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 05:57:40 -0500
Received: by mail-lb0-f182.google.com with SMTP id oh2so29099409lbb.3
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 02:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=582J5aqa2XaNDWahWTb+1S8nGpuAI+8aPM2fmHVzXIM=;
        b=LCE5QKb6/O5L59uk3kcbWeHix2XXg1kfHKCaWTzanZkmULMRrol6JoEY1PC35MfQEv
         /Vup41GkC473l/SNnqRIvgaDn/Ied+uVnu0QQDgHZJmEDg+DI6Vt+65/qO2J+un34U27
         0wzFs4sa+iGtuFJBfiwdZSC0D073JJFE59GZRrD6qeAajBR6LEIUi59ghqOWXm+YE6M5
         Xkp0iwHsiXNlu1g76naFW+C4NRk6OKmZ2Mfg3k8i+YXtOn/XPAEm3XcZUYCPEOIZ9eOp
         jd5nT82I+Lq8F2wAjLc1AiA2ersGJ+hHo5Mr06GSwyyj5Lk2cfTymw/fSjnkFDc+Dmli
         Au2Q==
X-Received: by 10.112.134.169 with SMTP id pl9mr7885140lbb.145.1450781859391;
 Tue, 22 Dec 2015 02:57:39 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Tue, 22 Dec 2015 02:57:09 -0800 (PST)
In-Reply-To: <xmqq4mfbfqla.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282840>

On Tue, Dec 22, 2015 at 4:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks.  I wiggled these three on top of the "Revert the earlier
> one"; while I think the result is correct, I'd appreciate if you can
> double check the result when I push the topic out later today.

Looks good. "prove" passed too by the way.
-- 
Duy

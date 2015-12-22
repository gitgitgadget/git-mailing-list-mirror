From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/3] nd/clear-gitenv-upon-use-of-alias
Date: Tue, 22 Dec 2015 18:53:16 +0700
Message-ID: <CACsJy8A5AcRj2HiLe3PQijhYcHMzJ6eEuMyeVTMvPtXvMg_Sug@mail.gmail.com>
References: <1449166676-30845-1-git-send-email-pclouds@gmail.com>
 <1450597819-26278-1-git-send-email-pclouds@gmail.com> <xmqq4mfbfqla.fsf@gitster.mtv.corp.google.com>
 <CACsJy8DFmZSa2x4y2fDwVsvwa5uAuMJn8v=utvYtAPTGFbdWPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Anthony Sottile <asottile@umich.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 12:53:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBLVo-0001l0-Or
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 12:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698AbbLVLxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 06:53:48 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34367 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752961AbbLVLxr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 06:53:47 -0500
Received: by mail-lb0-f180.google.com with SMTP id pv2so43861308lbb.1
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 03:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ml0OoqUS+Umkj82L7y4FIHgOyuRzgLU9gbiKf+joV10=;
        b=Kn6fRihfbyyQnKU5m2kfzqOCdJ/PObc6TuWcHEleMV1gL9i+woM/QQRZeTGiftKrZY
         c19XvfTkWdmzWzLwLQQ7jUjtqhgh/3UualK0j/ROaqt7jyFjdyCPsC97ht0Py8HuozKQ
         EkQopVLxyLttv1YHFqo+M3KUuFWRbgAGdIo6vh6SykGPjgCGyS/PmWeS2882Jn+C0tdB
         r/27N8f9wkwLmmRZUEBmPqNzHPesCDKmg+XYjNt/cx3dYe5YUdPSiOQTksFokwsaENIW
         kBiIsBpOXTrdaAHOv1rX+d6z2wPCKuBNYljzHVHlkSbZrv/Vs5WlIb4W+CoEp3lFhAn6
         5SoA==
X-Received: by 10.112.134.169 with SMTP id pl9mr7988111lbb.145.1450785226289;
 Tue, 22 Dec 2015 03:53:46 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Tue, 22 Dec 2015 03:53:16 -0800 (PST)
In-Reply-To: <CACsJy8DFmZSa2x4y2fDwVsvwa5uAuMJn8v=utvYtAPTGFbdWPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282843>

On Tue, Dec 22, 2015 at 5:57 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Dec 22, 2015 at 4:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Thanks.  I wiggled these three on top of the "Revert the earlier
>> one"; while I think the result is correct, I'd appreciate if you can
>> double check the result when I push the topic out later today.
>
> Looks good. "prove" passed too by the way.

Another by the way, this "forcing aliases as external commands" now
shows something like "error: git-log died of signal 13" when the pager
exits early, for an alias like "l1 = log --oneline". It's probably not
a regression because other external git commands with pager should
show the same message. But I haven't checked thoroughly yet.
-- 
Duy

From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git ignore help
Date: Tue, 24 Mar 2015 16:39:54 +0700
Message-ID: <CACsJy8DDC2FbKnu7o1cJR6F6Lh-NabaYtMYOKbm0xbn8PuKoEg@mail.gmail.com>
References: <47F.3lxhK.7IviRa5Gutr.1L2}X3@seznam.cz> <CAPig+cRU38sNHRsn=8=60wPO_AoQt-zn1dicFHwjG0OK-9tecQ@mail.gmail.com>
 <CACsJy8CGuuRTGycj13cT9d-n=HavzL4LVWC7xjD4Ac=KQGEhBg@mail.gmail.com> <CAPig+cT5=3kzEu4CzfYW3QtKqDDHn5uSwocoscFLU-T9M-+wiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: mdconf@seznam.cz, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 10:40:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaLK2-0004oT-JB
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 10:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbbCXJk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 05:40:26 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36767 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbbCXJkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 05:40:25 -0400
Received: by iedm5 with SMTP id m5so55975776ied.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 02:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4T4dygVFzOUg+r4v78FDkNDD8G3VBFSKT9bFpSGE9Z0=;
        b=CaPqrV7+54ewNDIkraHQ8X8CRFCb6sNwx82F+FaZIFJcemVdW4HMH2V5i3au24duaO
         mBJoauWoKAOjyrkSNIJmtHv4ZK6edlPce1N/lKZLlM/ih/4TO9VBMOmG0pM2UZvJJca5
         5i0yHZ3wjMyUmdj0PBgfdH5Wt3foCQKGZey7K4vklgMji3kXMsFRraofNtUvX30PPrBf
         hCr0w8uk22Qjn3+yElwYI2+zFFZ2uAR7sSgKl9FrebM5VhiwHIQpIIJdC8ebgZQKVlOg
         mNO7xLHk5WonpXZ1rjWG51xGvTgC1qlvdlJYzkD727bOiTu4vUDx9SBmb+ueXZIXPRTW
         aPHA==
X-Received: by 10.50.56.82 with SMTP id y18mr20699877igp.25.1427190024413;
 Tue, 24 Mar 2015 02:40:24 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Tue, 24 Mar 2015 02:39:54 -0700 (PDT)
In-Reply-To: <CAPig+cT5=3kzEu4CzfYW3QtKqDDHn5uSwocoscFLU-T9M-+wiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266180>

On Tue, Mar 24, 2015 at 8:55 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> e.g. "db", "reports" or "scripts", we could keep going for a while. I
>> think I attempted to do this in the past and failed (don't remember
>> exactly why). Maybe I'll try again some time in future.
>
> I also was pretty sure that you had attempted this, but couldn't find
> a reference to it, so I didn't mention it in my response. However,
> with some more digging, I finally located it[1].
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/259870

Thank you. I only looked at my repo and no branch name suggested it
(if only there is google search for a git repository..). So I gave up
because of performance reasons again but that was for enabling it
unconditionaly. If we enable it via a config variable and the user is
made aware of the performance implications, I guess it would be ok. So
it's back in my back log.
-- 
Duy

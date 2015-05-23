From: Luke Diamand <luke@diamand.org>
Subject: Re: What's cooking in git.git (May 2015, #06; Fri, 22)
Date: Sat, 23 May 2015 20:24:24 +0100
Message-ID: <5560D3E8.1010704@diamand.org>
References: <xmqqiobkdzv9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 21:25:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwF2l-0002li-Ds
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 21:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbbEWTZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 15:25:06 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37521 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932189AbbEWTZE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 15:25:04 -0400
Received: by wibt6 with SMTP id t6so16838796wib.0
        for <git@vger.kernel.org>; Sat, 23 May 2015 12:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=iJQSjtn61m4iMLmSOJcZ4KcmykfD9k4Yd3od71copBw=;
        b=QEs/Sjq2bBcT4NQ5hwru9olpFX/JG2hBWvSDHdO0hTJm5hPYAOGYcx590FfNnIbR0x
         7l9pr5mhiXE3oepRAAR9U5fAzmhOYYpZqwuDIQlcYJiJJ/NAO9BvIugI8KHKBqma9Uxr
         9vu9ABrrko/+Kj1TNeAAEi+cfTtN1ayYtqVfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=iJQSjtn61m4iMLmSOJcZ4KcmykfD9k4Yd3od71copBw=;
        b=G7xh96NrTXvH3G2/6hPSmHAeuPDdyIGwsoGYnAd2okxbT2t2/K7DewtKihdzJ+BcXE
         6bg+SKsUBA0EXaoLkIsM29/j+F9Ze/G5NAEEkvMGlYYnKCmR+jtTkWTVC34wHOSry2/f
         MaNFC1bUX5Toy/g0iVo9HvP5lfXUdYaBnqzfT6SOUo/C2D+lKEL3dzWTb402Ixd/NS6k
         MGRg5ryMWuQpNUpcBbkwzdJIns06azhrfMomqC13+0OoZQmMyd2neMg3ncI4jS3l1jBV
         9qP9YtSJ6Gn7OgyZl/FIaYTt+s7juzbLJy/SfMGzEmFgkrH2tdygD7+gyaTAPPOjedOy
         ctag==
X-Gm-Message-State: ALoCoQnTKtiLhH07eRn7gRJMPp6pQeN4D36fwOVzToDRKhzsICEMDnlDII5xzEna+V7zkNt7/ZQS
X-Received: by 10.194.200.228 with SMTP id jv4mr25434523wjc.157.1432409103069;
        Sat, 23 May 2015 12:25:03 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id ch2sm4175173wib.18.2015.05.23.12.25.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 May 2015 12:25:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <xmqqiobkdzv9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269816>

On 22/05/15 23:14, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.
>
ry_matches(): inline function
>   + is_> The fourth batch of topics have been merged to 'master'.
>

<snip>

>
>
> * ld/p4-editor-multi-words (2015-05-20) 6 commits
>   - SQUASH
>   - git-p4: tests: use test-chmtime in place of touch
>   - SQUASH
>   - git-p4: fix handling of multi-word P4EDITOR
>   - SQUASH
>   - git-p4: add failing test for P4EDITOR handling
>
>   Unlike "$EDITOR" and "$GIT_EDITOR" that can hold the path to the
>   command and initial options (e.g. "/path/to/emacs -nw"), 'git p4'
>   did not let the shell interpolate the contents of the environment
>   variable that name the editor "$P4EDITOR" (and "$EDITOR", too).
>   Make it in line with the rest of Git, as well as with Perforce.

The latest versions in the branch (with the SQUASH) all look good to me.

The other thing still missing from this series is fixing Windows builds. 
I've been attempting to get a Windows build environment going to 
actually test it (if it hasn't been tested, it doesn't work.... :-).

I'm slowly getting there, but I'm not very familiar with this particular OS.

Thanks,
Luke

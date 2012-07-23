From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 0/5] difftool: Use symlinks in dir-diff mode
Date: Sun, 22 Jul 2012 22:34:21 -0700
Message-ID: <CAJDDKr54yYXVWupDFQsx4b8UiqHRL1hsnAvpZGehDxDPYcfXpw@mail.gmail.com>
References: <1343015831-17498-1-git-send-email-davvid@gmail.com>
	<7vfw8jnjn2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 07:34:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StBHn-00069q-J5
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 07:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577Ab2GWFeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 01:34:23 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:38550 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479Ab2GWFeW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 01:34:22 -0400
Received: by vbbff1 with SMTP id ff1so4340290vbb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 22:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=r3nk7QTN8KEiUfq6qiZ9zFhqi1EjO4UK3nKSeEznE3M=;
        b=zgIShcOEwDdl7qXPQE5KNo4l0y+rOiGW6H6C7fcLWdYxSgSeQO6rs995yRV7XFnWTf
         N7cY5BO2e0XGKblr0W6dNdmHUGE7UKIv/HsoP1a1W+Qx3gnVCzeOcPnjI8BCM0q8Nlw6
         kLuBWOrUBH/z/hzJkooZJbR/l5F9AmHd8CdZpyp+H3C4k//hBLBaW94b8ViYn/Gsmsgt
         6O5+o3ovbvz4wGr7l0QsMnPRvob4Jui6Ed7m1H5UvOI/TKgooISYPU/cvjp8+qOPBC3b
         iTvteui6rCbJB4k01LLg3gpOWjWCEcczBlB5/WtO3izYeIlTBqU412yhZv+qFYumwgxt
         izNA==
Received: by 10.52.90.144 with SMTP id bw16mr9859143vdb.129.1343021661801;
 Sun, 22 Jul 2012 22:34:21 -0700 (PDT)
Received: by 10.52.114.67 with HTTP; Sun, 22 Jul 2012 22:34:21 -0700 (PDT)
In-Reply-To: <7vfw8jnjn2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201903>

On Sun, Jul 22, 2012 at 10:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> Teach the difftool script to use symlinks when doing
>> directory diffs in --dir-diff mode.
>>
>> This is v2 of the patch because I had a typo in one of the
>> commit messages and gmail ate 4/5 in the last round.
>
> FWIW, I received all including 4/5 in my inboxes (at pobox and
> gmail---I am doubly subscribed).  I still haven't figured out what
> in the original 4/5 was so special to be dropped somewhere in
> between.

I hastily blamed gmail but of course it was vger's spam filters.
The original subject said "git-difftool.XXXXX".
The exes triggered it.
-- 
David

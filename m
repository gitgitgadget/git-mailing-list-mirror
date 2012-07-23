From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/5] difftool: Eliminate global variables
Date: Sun, 22 Jul 2012 23:44:07 -0700
Message-ID: <CAJDDKr77d0vot30txya7Z0QpOj2xgV4-0ZhOuyXiJbG2OSUNQQ@mail.gmail.com>
References: <1343014940-16439-1-git-send-email-davvid@gmail.com>
	<1343014940-16439-2-git-send-email-davvid@gmail.com>
	<500CEB9F.4030406@gmail.com>
	<CAJDDKr7oDc2CxoiWqUMri93FM3WHecanCYBkezLYY1A_BZXdxw@mail.gmail.com>
	<CAHGBnuM9LgeLiOoFfny8NbF547okjQBLDXfzrbTj6vt+d=M4Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 08:44:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StCNK-0007dL-Ug
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 08:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578Ab2GWGoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 02:44:09 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:51593 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386Ab2GWGoI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 02:44:08 -0400
Received: by vbbff1 with SMTP id ff1so4370218vbb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 23:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IYTwKm5hGVKWWWOmneSHk8Wm+sXz5E0qg7pdRYMXU+I=;
        b=gxcZiHo7OYz9eSNnq5yjBf2uuCDit5riVxCEMPTyfJMq1yTysxNAGsh+0RV3+QQHPw
         BuRDMG9WaxOCPFWGGDM69FPYbxZJPfZzfM+AAR5Tb3HB7JmHwJoG6zGpOribcnwUXr5N
         vk11/rTxRtdAPedZRvHDbVd6DrTEPDDQD0Ukwx8MT5Jz9OSZw1JMVoKcsG8zgTqOHcWT
         9KlyR0CC/dH98SLHkCZ37niCOZ7i5WkOZ6Y/2gZA0VtRT4069+VZsDAR/v6XLcGgiiZ4
         SF3XTLU3a1m59jZ4xYKP9IqhS+ddiautV7T0fjEm4fprYlQaz+dt2qdHjEc+VEt7nTcd
         g8fQ==
Received: by 10.220.119.134 with SMTP id z6mr11309051vcq.62.1343025847619;
 Sun, 22 Jul 2012 23:44:07 -0700 (PDT)
Received: by 10.52.114.67 with HTTP; Sun, 22 Jul 2012 23:44:07 -0700 (PDT)
In-Reply-To: <CAHGBnuM9LgeLiOoFfny8NbF547okjQBLDXfzrbTj6vt+d=M4Eg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201911>

On Sun, Jul 22, 2012 at 11:30 PM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> On Mon, Jul 23, 2012 at 8:21 AM, David Aguilar <davvid@gmail.com> wrote:
>
>>> Funny, I just have prepared a patch along the same lines so that one can
>>> call git-difftool -h and --tool-help also outside a repository, see below.
>>> Does you patch offer the same? If so, I'll drop mine.
>>
>> It *should*. I did not consider this case but that is indeed the
>> desired behavior.
>>
>> What my patch did not offer was a test to ensure this behavior...
>
> Well, I'm not asking for a test. From my side, I'd be happy if you
> could just try it and confirm that it works, as I currently cannot
> easily apply your patch.

Heheh.. I was hoping you could provide a test ;-)

I just tried it now.  They work outside of a repository.
-- 
David

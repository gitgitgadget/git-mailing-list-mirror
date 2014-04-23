From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: How to trim the fat on my log graphs
Date: Wed, 23 Apr 2014 11:32:26 -0500
Message-ID: <CAHd499AovROt2fVAvh-ST9Vb7Hq8LpUS68i4eXWZaNszuKeUfg@mail.gmail.com>
References: <CAHd499Bq07mPTR=h-5Gj=NuEQ9WLnK2wL5nxTNMe=LFnKHmvzA@mail.gmail.com>
	<xmqqtx9l2ggp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 18:33:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd06y-0008PU-ES
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 18:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755463AbaDWQc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 12:32:57 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:37528 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754710AbaDWQc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 12:32:27 -0400
Received: by mail-vc0-f177.google.com with SMTP id if17so1444342vcb.8
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 09:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=o7xfsqhOJ8YKCqUaJsBkH/iXwGSHzGZA47mBPIEpCjQ=;
        b=wnLISODfy/9Ha3e9xpKG0pt3ZLkPlajWJlg5DUzrh0vTFeFuuBnD9n1c6m90WdLfwK
         N758BU8SBDuYnYBbfR+RGbri7DByQrU7D5dXUH2/eGEDC0fCsM7Jsoh2hI1g+AvFsFnW
         B9jQK3xkI9qvYUB+9fBAYG9L9t3BfmoMZpFBQYcrr3wcLh2ZNsvXRf9T3cd+nfKcYpjp
         bAInqM8/zG44Myysk16vZxqGazMVTovenwWsjWoYGq4fWt8JSJIx5iRFFGWt1QnzQdlK
         87iy8ZNH3g1Cfk5WoAHsQgBCF6YrwgXEnkSXZNHmbgub+Z9t6+PuT5TntiupdMPkXwS1
         n1wA==
X-Received: by 10.220.106.7 with SMTP id v7mr658373vco.46.1398270746523; Wed,
 23 Apr 2014 09:32:26 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.2.79 with HTTP; Wed, 23 Apr 2014 09:32:26 -0700 (PDT)
In-Reply-To: <xmqqtx9l2ggp.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: Oj7RjjjlrsXroyU-yRvk_11eCMU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246848>

Thanks, removing those two options did help quite a bit already.
However, the history can still get pretty crazy. Is there a way to
hide all tags from the log graph? Really I just want the LABELS to be
hidden.

On Tue, Apr 22, 2014 at 4:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Robert Dailey <rcdailey.lists@gmail.com> writes:
>
>> git log log --graph --abbrev-commit --decorate --date=relative
>> --format=format:'%C(bold blue)%h%C(reset)%x09%C(bold
>> green)(%ar)%C(reset)%C(bold yellow)%d%C(reset) %C(dim
>> white)%an%C(reset) - %C(white)%s%C(reset)' --branches --remotes
>> ...
>> The goal is to weed out the really distant and irrelevant commits. I
>> really just want to see the commits that are closely related to my
>> current branch. Thanks in advance.
>
> For a starter, how about dropping "--branches --remotes" from that
> command line?  A merge from elsewhere will show as "Merge branch foo"
> which should be sufficient without the decoration.

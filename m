From: Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Jun 2015, #06; Wed, 24)
Date: Wed, 24 Jun 2015 18:01:51 -0700
Message-ID: <CAGZ79kby0RaKiS2e4o7O7OyLGCftMYVJppvATyPxpzJUOe59jw@mail.gmail.com>
References: <xmqqwpys95bm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 03:02:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7vYR-0000QB-LT
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 03:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588AbbFYBCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 21:02:03 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:36534 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103AbbFYBBw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 21:01:52 -0400
Received: by yhjh26 with SMTP id h26so1024965yhj.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 18:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+r5aa9oehLkhaf/pttKTy5gEPshrQN0i11i1ZeDUXMI=;
        b=MYOV5vpzb/La43dPt2Odc4DTGNDrRI7dJcNRylKRcLG5Zn1WVhYu+02cOXX5XDhBz8
         +2F2hPSHfohnhJnPmjaWpXFpztOC8OHdyuFL9Wcj+GS1Waq+/y0/YgYgJPYOZvMcKUgJ
         DwekYHy01lN3fmqoV7piobaSc9uYccXlRkrwRU1zkG5I4zz6g7mrdDWtz468G/PFJdQy
         SlvIDocYUNM81VZPCJjJcT/Ncj15zbxFUu9Dl6hJjNrZPeuT9sGVjMNDhcxhnX9s4b/0
         +MG6iIhMfYW5orAkFfqXf/6iVhyr4ovjFh6vO4mHkTcXxj2tAcUdGqGzGKKm3YtAgoy8
         lsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+r5aa9oehLkhaf/pttKTy5gEPshrQN0i11i1ZeDUXMI=;
        b=SFYJgnythfkgP+NMT1C0P+uiNll1gbKDr/jFIN5lC101Teq79s81lU0dM4HtTO3jzc
         cfiaZ9O+F5rOBIbuUonw95XF/ov96cdiXLt/FZNfD0oKp0UpO9WQRcNZpYYzMrz0Q0r6
         Re4ukLZHnVU105tCG7CxhSP2IjFWexPEgQarW9nfIbdo/FGBGswG8RH1lD9ZAvzwt6Ar
         E2xzXrljDfLwt8CjlEDtsI4uP1UtcVxlew9f58Jc8hlaNxsfM6h7nHrp6bdJdkP/XWJ6
         60TEELKxAt8iXZjuFfzVYZ1R/ifOXEWMdHBIrh+Pr/Jd88+GSQ2RFkoKq/HobHevhzq0
         fW2w==
X-Gm-Message-State: ALoCoQncBgfexa0hg6i6H1I8v/hQy2gwNgv72r+bBnoXQEn5Bd1y+J+Zbw5S1qMpTRMuDrzxayWt
X-Received: by 10.129.117.5 with SMTP id q5mr29324782ywc.82.1435194111462;
 Wed, 24 Jun 2015 18:01:51 -0700 (PDT)
Received: by 10.37.81.193 with HTTP; Wed, 24 Jun 2015 18:01:51 -0700 (PDT)
In-Reply-To: <xmqqwpys95bm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272631>

> * pt/pull-builtin (2015-06-18) 19 commits
>  - pull: remove redirection to git-pull.sh
>  - pull --rebase: error on no merge candidate cases
>  - pull --rebase: exit early when the working directory is dirty
>  - pull: configure --rebase via branch.<name>.rebase or pull.rebase
>  - pull: teach git pull about --rebase
>  - pull: set reflog message
>  - pull: implement pulling into an unborn branch
>  - pull: fast-forward working tree if head is updated
>  - pull: check if in unresolved merge state
>  - pull: support pull.ff config
>  - pull: error on no merge candidates
>  - pull: pass git-fetch's options to git-fetch
>  - pull: pass git-merge's options to git-merge
>  - pull: pass verbosity, --progress flags to fetch and merge
>  - pull: implement fetch + merge
>  - pull: implement skeletal builtin pull
>  - argv-array: implement argv_array_pushv()
>  - parse-options-cb: implement parse_opt_passthru_argv()
>  - parse-options-cb: implement parse_opt_passthru()
>
>  Reimplement 'git pull' in C.
>
>  This is v4 ($gmane/271943).
>  Comments from mentors and others?

I think the series is good as is.

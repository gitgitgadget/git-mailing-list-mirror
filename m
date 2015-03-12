From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: What's cooking in git.git (Mar 2015, #04; Wed, 11)
Date: Thu, 12 Mar 2015 08:27:28 -0400
Message-ID: <CAPig+cTJfUKKV8uCriergo4QGpOY41uEof6fNtW3XfF1P7hTsw@mail.gmail.com>
References: <xmqqmw3j3vhr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 13:27:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YW2DA-0000vH-4K
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 13:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007AbbCLM1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 08:27:30 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:40885 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbbCLM13 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 08:27:29 -0400
Received: by ykq142 with SMTP id 142so7170368ykq.7
        for <git@vger.kernel.org>; Thu, 12 Mar 2015 05:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=tdGnQk1j9aFffrAvbc2rFI/LbmfnC4TNgy4IgptHOCE=;
        b=lzpAt40wBIzH8N9QTFs8yXImjOHQ6C1fFuBCCGkvp5fxvJFKH35VV8r1XsNrBNB4Ev
         s5u7yoRlUFrDoVw0NpDPbHBnSGDqixrl2OjthuIk3a76cWy0G1Hvg4hrAHT6eSXfcMNn
         2EgF6Xt5etHwyh36/6zdpVhQ3eLa8R0KkqKkBS78HUjqC/TyrIpbtVUBcTK8yrYQ8DWY
         1nC0T3MLbx9gkNxUNAE83vgZvClu5LdQZLblWwNyymiu+LSR9tXvZGXNAhnThMsGPAG1
         xGu8t0L/pI3E0Xj++gyco9lYdiafIDVWG6YfDKVtXeAxYpYG3uTERgYHhsHMqraLPq09
         KCEA==
X-Received: by 10.236.202.238 with SMTP id d74mr41529622yho.166.1426163248990;
 Thu, 12 Mar 2015 05:27:28 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Thu, 12 Mar 2015 05:27:28 -0700 (PDT)
In-Reply-To: <xmqqmw3j3vhr.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: ktEOe2IVy_6zhFkxnFc64wB09co
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265361>

On Wed, Mar 11, 2015 at 8:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/list-files (2015-02-09) 21 commits
>  - t3080: tests for git-list-files
>  - list-files: -M aka diff-cached
>  - list-files -F: show submodules with the new indicator '&'
>  - list-files: add -F/--classify
>  - list-files: show directories as well as files
>  - list-files: do not show duplicate cached entries
>  - list-files: sort output and remove duplicates
>  - list-files: add -t back
>  - list-files: add -1 short for --no-column
>  - list-files: add -R/--recursive short for --max-depth=-1
>  - list-files: -u does not imply showing stages
>  - list-files: make alias 'ls' default to 'list-files'
>  - list-files: a user friendly version of ls-files and more
>  - ls-files: support --max-depth
>  - ls-files: add --column
>  - ls-files: add --color to highlight file names
>  - ls-files: buffer full item in strbuf before printing
>  - ls_colors.c: highlight submodules like directories
>  - ls_colors.c: add a function to color a file name
>  - ls_colors.c: parse color.ls.* from config file
>  - ls_colors.c: add $LS_COLORS parsing code
>
>  A new "git list-files" Porcelain command, "ls-files" with bells and
>  whistles.
>
>  Concern was raised that this is piggybacking on ls-files codebase,
>  rather than wt-status codebase ($gmane/264258).
>
>  Waiting for further comments or a reroll.

This series has been re-rolled[1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/265142

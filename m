From: David Aguilar <davvid@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2013, #01; Fri, 1)
Date: Sun, 3 Feb 2013 04:13:22 -0800
Message-ID: <CAJDDKr6bPjKwe3NitvGCec2LyesY3yL=UtN85Bsox-bGWN=qeA@mail.gmail.com>
References: <7vwqur8z4s.fsf@alter.siamese.dyndns.org>
	<7vlib69cjh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 13:13:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1ySE-0007HH-6A
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 13:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676Ab3BCMNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 07:13:25 -0500
Received: from mail-wi0-f169.google.com ([209.85.212.169]:52991 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab3BCMNX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 07:13:23 -0500
Received: by mail-wi0-f169.google.com with SMTP id l13so1575429wie.2
        for <git@vger.kernel.org>; Sun, 03 Feb 2013 04:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=6qNP4cmbabOvJ/Yujse9rHF0B4C5J4tDRjc8RecynEQ=;
        b=SMu3Q5feqDcS6jhxJSgLIsnha7D0wXyBM+YrwlmFowX+XkSJQxMJNdWcCH4cmkr73d
         ytPhHR7Lp0+EEMYDlQDHGmWZYs6lGTCepnfu34NaZfgj+3goHLYUN0g5QqGCK1n06zqX
         92Pxvd09XOt6bYyE1Eg9cdlNMa7wCh5vxKoE9DDPaA4l+4xh9FJY5blh8a2kx+e5ZlkB
         4DaXDEIhir4x3oEHxR1boCYtdivmTa7lWbOce5IoHcTA/UJ07ajJ/NMEBNSTUMzoGhl+
         c6PsWwaCpqMSf8E7vdgipM/NyilFqqGuXX4mmtZKAllmSlmzp+yhRONE4QEppxWKQCdU
         kLWQ==
X-Received: by 10.194.122.98 with SMTP id lr2mr30242315wjb.7.1359893602269;
 Sun, 03 Feb 2013 04:13:22 -0800 (PST)
Received: by 10.194.95.7 with HTTP; Sun, 3 Feb 2013 04:13:22 -0800 (PST)
In-Reply-To: <7vlib69cjh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215306>

On Sat, Feb 2, 2013 at 9:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> Regarding these two topics....
>
>> * da/mergetool-docs (2013-01-30) 7 commits
>>  - doc: generate a list of valid merge tools
>>  - mergetool--lib: list user configured tools in '--tool-help'
>>  - fixup! doc: generate a list of valid merge tools
>>  - fixup! mergetool--lib: add functions for finding available tools
>>  - mergetool--lib: add functions for finding available tools
>>  - mergetool--lib: improve the help text in guess_merge_tool()
>>  - mergetool--lib: simplify command expressions
>>  (this branch uses jk/mergetool.)
>>
>>  Build on top of the clean-up done by jk/mergetool and automatically
>>  generate the list of mergetool and difftool backends the build
>>  supports to be included in the documentation.
>>
>>  Will merge to 'next', after squashing the fixup! commits from John
>>  Keeping.
>>
>>
>> * jk/mergetool (2013-01-28) 8 commits
>>  - mergetools: simplify how we handle "vim" and "defaults"
>>  - mergetool--lib: don't call "exit" in setup_tool
>>  - mergetool--lib: improve show_tool_help() output
>>  - mergetools/vim: remove redundant diff command
>>  - git-difftool: use git-mergetool--lib for "--tool-help"
>>  - git-mergetool: don't hardcode 'mergetool' in show_tool_help
>>  - git-mergetool: remove redundant assignment
>>  - git-mergetool: move show_tool_help to mergetool--lib
>>  (this branch is used by da/mergetool-docs.)
>>
>>  Cleans up mergetool/difftool combo.
>>
>>  This is looking ready for 'next'.
>
> Do the tips of these two topics look reasonable to both of you, or
> are there anything you sent but I missed?

It looks good to go.  The additional "|| :" in the makefile is a nice
touchup that made it more robust too.
-- 
David

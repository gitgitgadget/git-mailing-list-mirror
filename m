From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2015, #04; Mon, 27)
Date: Thu, 30 Apr 2015 08:07:00 +0700
Message-ID: <CACsJy8BYhwcewEdix1WaAY+ukeTfwkLyrcimJ2K7Rgwh0E6EDQ@mail.gmail.com>
References: <xmqqr3r5uyqg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 03:07:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yncwy-0003nJ-A3
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 03:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbbD3BHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 21:07:32 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33369 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbbD3BHb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 21:07:31 -0400
Received: by iecrt8 with SMTP id rt8so56254114iec.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 18:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=q6szWMyYHjPWn2SaV1Vl2seEdcdL68NJ372Sh1ZNtGk=;
        b=Sx8TFE6d0xIRgC43NUsn35p4NEvwJ04kgRaq8F+zcbPcbKoHA+M3ZIUQLOD4yMHxdY
         wrQZYbeux9KWH07O7JodVnwaQ+llzAg6ZZphgPVIzN9temA68a3xokcVmogTIu9m+3so
         N9QK1L8U0/qzx+TT8o1z1gPe49IsOevZobK795aAhVRQyzlfwJyj+eq6/1oXS5YVuYO8
         nQqrwLOVh6UFK0hPmmVHQTpbwM5vBlH+3SwL1u0q94HTRA379uQLHjHPVqH9eZUjvm0c
         MjzM0IDiXpZkeYBlI5TsdRpAGskai+1eCL7D3rRTkjmnt+JkSZrHhpDizOaYIWsVJ1N6
         D0zg==
X-Received: by 10.107.135.216 with SMTP id r85mr2321263ioi.84.1430356050628;
 Wed, 29 Apr 2015 18:07:30 -0700 (PDT)
Received: by 10.107.136.169 with HTTP; Wed, 29 Apr 2015 18:07:00 -0700 (PDT)
In-Reply-To: <xmqqr3r5uyqg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268042>

On Tue, Apr 28, 2015 at 3:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
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
>  Reroll to base on wt-status work ($gmane/265142) has seen some
>  positive discussions.
>
>  Waiting for a further polished reroll ($gmane/265534).

I'm a little bit busy with other things, so please drop this for now.
I'll resubmit when I address all the comments from the last round.
-- 
Duy

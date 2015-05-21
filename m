From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v11 2/5] command-list.txt: add the common groups block
Date: Thu, 21 May 2015 14:01:44 -0400
Message-ID: <CAPig+cRciCgBZyuT4fz0JZLY9SRmODaXq=gvsimVQ7sdt+AzcA@mail.gmail.com>
References: <1432229962-21405-1-git-send-email-sebastien.guimmara@gmail.com>
	<1432229962-21405-3-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 20:01:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvUn0-0005Zy-TI
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 20:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755069AbbEUSBq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2015 14:01:46 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34076 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309AbbEUSBp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 May 2015 14:01:45 -0400
Received: by ieczm2 with SMTP id zm2so14263654iec.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 11:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=JzC+zEhhY4Cpbj5HPYRFtQh5UW7lM5arkHcawKKQ8+4=;
        b=rC/a2zUFKKdxdhp1Xe+hwmtYmGUHuQtBSBMZ3fp6KOb8qJ9S2LB0MwMozWQqNCFVqa
         SlqEkfB1lu/RalOQg1+kGo2oKbefYWMDFNSHU4S67XpPUke6oZYPZYAxtBC8qGiJe6/v
         uF7XXdWYfW2ReO74r/oOSJ2x6fwMGCiJf6wJkbFSmASg8Vq61oCwtYPFcnTIiSsTDypc
         Hlmh89tJX9urP4mVe+H+H8AiFb4TuJqqRkuD+yjI3viNFn1w9ISfN8kW7yHhhh9h72AN
         s1A5vDGIL7B4Ov4t3R9zHKDTDwyoFkdgZ/gdiE/rwidt1C8Sx9rId9wL0vQJ8H3mrK5J
         2+Ww==
X-Received: by 10.107.31.134 with SMTP id f128mr5064711iof.19.1432231304523;
 Thu, 21 May 2015 11:01:44 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 21 May 2015 11:01:44 -0700 (PDT)
In-Reply-To: <1432229962-21405-3-git-send-email-sebastien.guimmara@gmail.com>
X-Google-Sender-Auth: MtzuaQnOM6j5FJhXUHZgMudRZx0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269630>

On Thu, May 21, 2015 at 1:39 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> The ultimate goal is for "git help" to display common commands in
> groups rather than alphabetically. As a first step, define the
> groups in a new block, and then assign a group to each
> common command.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by:  Emma Jane Hogbin Westby <emma.westby@gmail.com>
> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
> ---
> diff --git a/command-list.txt b/command-list.txt
> index 181a9c2..32ddab3 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -1,3 +1,14 @@
> +# common commands are grouped by themes
> +# these groups are output by 'git help' in the order declared here.
> +# map each common command in the command list to one of these groups=
=2E
> +### common groups (do not change this line)
> +init         start a working area (see also: git help tutorial)
> +worktree     work on the current change (see also: git help everyday=
)
> +info         examine the history and state (see also: git help revis=
ions)
> +history      grow, mark and tweak your common history
> +remote       collaborate (see also: git help workflows)
> +
> +# List of known git commands.

This is odd. The above line was removed in 1/5 but then re-appears
here in 2/5. I think the intent is that it should remain removed.

>  ### command list (do not change this line)
>  # command name                          category [deprecated] [commo=
n]
>  git-add                                 mainporcelain common

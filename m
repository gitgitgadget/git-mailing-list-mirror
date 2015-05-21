From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule documentation: Reorder introductory paragraphs
Date: Thu, 21 May 2015 10:24:37 -0700
Message-ID: <xmqqoaldkfmy.fsf@gitster.dls.corp.google.com>
References: <1432163517-22785-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org, pasky@suse.cz,
	hvoigt@hvoigt.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 21 19:24:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvUDG-0007j7-6Y
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 19:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492AbbEURYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 13:24:42 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36388 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326AbbEURYk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 13:24:40 -0400
Received: by igbpi8 with SMTP id pi8so15654722igb.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 10:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=EnggKTL0y5QYlPZ7N+XY8X1C7XZ7hH/TS0zP2R/IDlE=;
        b=IMDim3EVeeK0lTUIkRkQpAB4cYSrmCTDo/sByabUxekjq1QDtOYygrqWyjuS1li3gr
         UQNcDJRmoqxL81De0Z90o/a86+FnazHqT2xkBNzILbxxgfHE7505OhxF/WYCfw3F/Irs
         Cyqoa+yYVCzJA7UDqqBRMv8NeSjZJ8EPHeU+YU7zDFFoUL2XYAUJMEKIqilyE9xWpbzN
         DjrRr3PyeIZ2ax1ZVby/rQeovRdzLuzEi+n56+FuAFSE6DBIHSBMpfoMXTfLMBvf+hbo
         M/70A377p6+GY4sypNC8aLXI4Ahd6iFlPKY0xpAEI6QoLHXKP60RyPFayrph8lmH+ssu
         9auw==
X-Received: by 10.107.131.81 with SMTP id f78mr4911568iod.42.1432229079557;
        Thu, 21 May 2015 10:24:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id k186sm15318632ioe.37.2015.05.21.10.24.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 10:24:38 -0700 (PDT)
In-Reply-To: <1432163517-22785-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 20 May 2015 16:11:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269618>

Stefan Beller <sbeller@google.com> writes:

> Reorder the paragraphs such that
> the first short paragraph introduces the submodule concept,
> the second paragraph highlights the usage of the submodule command,
> the third paragraph giving background information,
> and finally the fourth paragraph discusing alternatives such
> as subtrees and remotes, which we don't want to be confused with.
>
> This ordering deepens the knowledge on submodules with each paragraph.
> First the basic questions like "How/what" will be answered, while the
> underlying concepts will be taught at a later time.

Sounds good.

> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 2c25916..6c38c0d 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -25,35 +25,12 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> -Submodules allow foreign repositories to be embedded within
> -a dedicated subdirectory of the source tree, always pointed
> -at a particular commit.
> +Submodules allow other repositories to be embedded within
> +a dedicated subdirectory of the source tree pointing
> +at a particular commit in the other repository.

Not a new problem, but I can misread this as if it requires the
top-level superproject to have one single dedicated directory D to
house all the foreign projects under it, D/project1, D/project2, ...

> -This command will manage the tree entries and contents of the
> -gitmodules file for you, as well as inspect the status of your
> -submodules and update them.
> +This command will manage the submodules for you, as well as
> +inspect the status of your submodules and update them.

Not a new problem, but does the command really "manage them for
you"?  I view it more like "You can use this command to manage,
inspect and update the submodules".

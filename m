From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH] git-submodule.sh: Add Long Usage instead of simple usage
Date: Mon, 5 May 2008 15:07:08 +0600
Message-ID: <7bfdc29a0805050207l3ef55648u9a8cbd6e57711e0c@mail.gmail.com>
References: <1209977051-25896-1-git-send-email-imyousuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com,
	"Imran M Yousuf" <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 11:08:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jswg3-00042c-1Z
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 11:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbYEEJHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 05:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754168AbYEEJHM
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 05:07:12 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:52868 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbYEEJHK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 05:07:10 -0400
Received: by mu-out-0910.google.com with SMTP id w8so734752mue.1
        for <git@vger.kernel.org>; Mon, 05 May 2008 02:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=63L1cA0Z5kWWJYRpJCU2y60/B9y/BFTqsqSoy+9HCL4=;
        b=j/T5bXpnSl31BJ05bgWsNkwRzGLTYy58Fv0j3IjFxv64E+LfRC1W5gLBNG9aJ2fjy2qxtpvOTHKMRIEoIZWYfVWXS2oOKNQ/+aj+BWYBjEHwTa2pIOvyK7HMB/z+MUTXCrgM6hIUeZ6w4ewiQk9XlbJe+BBsHaq1SZYlKuwsghc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=od73VEtZ/uKk+egTiBqwaHKQ3ymM0AHJQfRAdu+uo/Y4PuhVS/qUOkYz4zfsi+zV1Yq4+q1HV5QJS+U24M9T/JjoYr/gaUtgtegQ0NE0sS/R7n6Pg4RgwBqE/RQ+iQhL9lwDwRhUx3NnABG8gI0roIAavRzGXXyUi4CIyHyquaE=
Received: by 10.78.120.15 with SMTP id s15mr1509661huc.108.1209978428305;
        Mon, 05 May 2008 02:07:08 -0700 (PDT)
Received: by 10.78.75.8 with HTTP; Mon, 5 May 2008 02:07:08 -0700 (PDT)
In-Reply-To: <1209977051-25896-1-git-send-email-imyousuf@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81251>

Sorry for the inconvenience, but please ignore this patch as it was
not generated with -n and version number :(.

- best regards,

Imran

On Mon, May 5, 2008 at 2:44 PM,  <imyousuf@gmail.com> wrote:
> From: Imran M Yousuf <imyousuf@smartitengineering.com>
>
>  With the already available commands the synopsis is quite hard to
>  read; thus converted it to Long usage instead. In process also
>  updated the file comment.
>
>  Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
>  ---
>   git-submodule.sh |   13 +++++++++----
>   1 files changed, 9 insertions(+), 4 deletions(-)
>
>  diff --git a/git-submodule.sh b/git-submodule.sh
>  index ce0f00c..a5ee2e5 100755
>  --- a/git-submodule.sh
>  +++ b/git-submodule.sh
>  @@ -1,12 +1,17 @@
>   #!/bin/sh
>   #
>  -# git-submodules.sh: add, init, update or list git submodules
>  +# git-submodules.sh: add, init, update, summary or status git submodules
>   #
>   # Copyright (c) 2007 Lars Hjemli
>
>  -USAGE="[--quiet] [--cached] \
>  -[add <repo> [-b branch]|status|init|update|summary [-n|--summary-limit <n>] [<commit>]] \
>  -[--] [<path>...]"
>  +USAGE="<command> <options>
>  +Use $0 -h for more details"
>  +# Did not use '\' at the end of the lines to ensure that each synopsis
>  +# are in a separate line
>  +LONG_USAGE="$0 add [-q|--quiet] [-b|--branch branch] <repository> [<path>]
>  +$0 [status] [-q|--quiet] [-c|--cached] [--] [<path>...]
>  +$0 init|update [-q|--quiet] [--] [<path>...]
>  +$0 summary [--cached] [-n|--summary-limit <n>] [<commit>]"
>   OPTIONS_SPEC=
>   . git-sh-setup
>   require_work_tree
>  --
>  1.5.4.2
>
>

From: P Baker <me@retrodict.com>
Subject: Re: [PATCH 1/2] Clarify the gitmodules and submodules docs
Date: Wed, 8 Apr 2009 11:45:32 -0400
Message-ID: <526944450904080845ib87e67aga86fe1b4e42946dc@mail.gmail.com>
References: <1239204833-39795-1-git-send-email-pbaker@retrodict.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: pbaker <pbaker@retrodict.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 17:47:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrZzZ-00019H-SX
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 17:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757424AbZDHPpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 11:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756038AbZDHPpf
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 11:45:35 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:44542 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936AbZDHPpe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2009 11:45:34 -0400
Received: by qw-out-2122.google.com with SMTP id 8so174384qwh.37
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=Gtq03FVjc018R4RtMu3ZM7Kr5f9A71jsGQrcWeFqYng=;
        b=G4JZbVljWq/uP09GaqtVM+drjkoKCNCpvJQ6AMZMDbJXsQDgWLHSnKopKLl3dK0/Aq
         gZ1x/FYRiu2EIfgbAB2T16HsjMWIBL2nmT7D0MThhr8eGAi+ETMOOs5b5gmmkxFh/iNY
         PnijvEzZ5earMf7f9n4e+ferly9J12p2y25Pc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=C/wcukTSJjWq//zz91R7Ivnhc0E5ALLVmjGNvsbgbqi5/admLUG5/xeiOg8xpCqJiK
         A8+BbhXPa8ba+COnCnmJtPyOe7tjNYyWiPEGqb5MOlG2RDUPaw4qspOcdLLWBABt8IAc
         JojBBITCc8ttY/zQhNjqgs+hpuADF0oZwLkCo=
Received: by 10.220.87.4 with SMTP id u4mr2118038vcl.28.1239205532558; Wed, 08 
	Apr 2009 08:45:32 -0700 (PDT)
In-Reply-To: <1239204833-39795-1-git-send-email-pbaker@retrodict.com>
X-Google-Sender-Auth: 30f2fa2e5f6af6c3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116087>

Whoops. Sorry for the spam, trying to fix git-send-email whitespace
errors as per Junio's request. I apologize.

P Baker

On 4/8/09, pbaker <pbaker@retrodict.com> wrote:
> Added some explanation to the docs to clear up some confusing parts of git-submodules that appeared frequently on the mailing list.
>
>  Signed-off-by: pbaker <pbaker@retrodict.com>
>  ---
>
>  As I dug into the reasoning and structure of git-submodule as part of GSoC preparation, I also ran across frequently asked questions on the mailing list. From this background, I added some explanation to the docs to  clear up some confusing parts of git-submodules.
>
>  - pbaker
>
>  Documentation/git-submodule.txt |    9 ++++++---
>   Documentation/gitmodules.txt    |    8 +++++++-
>   2 files changed, 13 insertions(+), 4 deletions(-)
>
>  diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
>  index 3b8df44..1ca8184 100644
>  --- a/Documentation/git-submodule.txt
>  +++ b/Documentation/git-submodule.txt
>  @@ -50,9 +50,12 @@ This command will manage the tree entries and contents of the
>   gitmodules file for you, as well as inspect the status of your
>   submodules and update them.
>   When adding a new submodule to the tree, the 'add' subcommand
>  -is to be used.  However, when pulling a tree containing submodules,
>  -these will not be checked out by default;
>  -the 'init' and 'update' subcommands will maintain submodules
>  +is to be used. This creates a record in the gitmodules file for each
>  +submodule. When the file is committed and pulled by others it serves as an
>  +in-tree reference for where to obtain the submodule.
>  +
>  +When pulling a tree containing submodules, these will not be checked out by
>  +default; the 'init' and 'update' subcommands will maintain submodules
>   checked out and at appropriate revision in your working tree.
>   You can briefly inspect the up-to-date status of your submodules
>   using the 'status' subcommand and get a detailed overview of the
>  diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
>  index d1a17e2..8f03310 100644
>  --- a/Documentation/gitmodules.txt
>  +++ b/Documentation/gitmodules.txt
>  @@ -15,7 +15,13 @@ DESCRIPTION
>
>   The `.gitmodules` file, located in the top-level directory of a git
>   working tree, is a text file with a syntax matching the requirements
>  -of linkgit:git-config[1].
>  +of linkgit:git-config[1]. As this file is managed by Git, it tracks the
>  +records of a project's submodules. Information stored in this file is used
>  +as a hint to prime the authoritative version of the record stored in the
>  +project configuration file. User specific record changes (e.g. to account
>  +for differences in submodule URLs due to networking situations) should be
>  +made to the configuration file, while record changes to be propagated (e.g.
>  +due to a relocation of the submodule source) should be made to this file.
>
>   The file contains one subsection per submodule, and the subsection value
>   is the name of the submodule. Each submodule section also contains the
>
> --
>  1.6.2.1.316.gedbc2
>
>

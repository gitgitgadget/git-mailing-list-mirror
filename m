From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH] Documentation/git-submodule.txt: Add documentation for the recurse subcommand
Date: Mon, 5 May 2008 15:07:26 +0600
Message-ID: <7bfdc29a0805050207s69f533e8ib78e6acdf7576ef6@mail.gmail.com>
References: <1209977051-25896-1-git-send-email-imyousuf@gmail.com>
	 <1209977051-25896-2-git-send-email-imyousuf@gmail.com>
	 <1209977051-25896-3-git-send-email-imyousuf@gmail.com>
	 <1209977051-25896-4-git-send-email-imyousuf@gmail.com>
	 <1209977051-25896-5-git-send-email-imyousuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com,
	"Imran M Yousuf" <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 11:08:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JswgF-00045d-53
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 11:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292AbYEEJH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 05:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755062AbYEEJH3
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 05:07:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:60796 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168AbYEEJH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 05:07:28 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1026920nfc.21
        for <git@vger.kernel.org>; Mon, 05 May 2008 02:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KWLZ4MZdXydG6kfEYRrpLpQgDv4xXFaVdaSPoQhOCak=;
        b=ly1mxl2dwEnyiZq2NIDoQRcGXIA2oLamtoPgMpYYfvrxskVJTH4xluqa9DFrStbAXzyRu2CkxpHxoE6hbga6ETp1MIkblPyPP3x7X4qyeE+SONsSP4hjgBdyXirSiDNP1xxT6rtTYpIhCdLZuNXbhbDsFwTpZRwOrfQ/CgEhe+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gwlAUz0koQ3FADTq+DvXbP+OdNbFt/GFv4rZgtWRAt44i7MDuN/65AfQYGJqG8DaRn+1dU7nBXpkFPls19RENVaSPAVb64peJBzuWSZxxH3znVbDrLECceFBFqMYkEZdjwHrYg4Qf/YVe+bOM2JWXUb2pTQkNSr5wpHaO44VR64=
Received: by 10.78.184.14 with SMTP id h14mr1513898huf.98.1209978446735;
        Mon, 05 May 2008 02:07:26 -0700 (PDT)
Received: by 10.78.75.8 with HTTP; Mon, 5 May 2008 02:07:26 -0700 (PDT)
In-Reply-To: <1209977051-25896-5-git-send-email-imyousuf@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81252>

Sorry for the inconvenience, but please ignore this patch as it was
not generated with -n and version number :(.

- best regards,

Imran


On Mon, May 5, 2008 at 2:44 PM,  <imyousuf@gmail.com> wrote:
> From: Imran M Yousuf <imyousuf@smartitengineering.com>
>
>  Documentation with brief description is added for the recurse
>  sucommand along with its arguments and their nature.
>
>  Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
>  ---
>   Documentation/git-submodule.txt |   35 +++++++++++++++++++++++++++++++++++
>   1 files changed, 35 insertions(+), 0 deletions(-)
>
>  diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
>  index 6ffd896..9a95522 100644
>  --- a/Documentation/git-submodule.txt
>  +++ b/Documentation/git-submodule.txt
>  @@ -13,6 +13,10 @@ SYNOPSIS
>   'git-submodule' [--quiet] status [--cached] [--] [<path>...]
>   'git-submodule' [--quiet] [init|update] [--] [<path>...]
>   'git-submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
>  +'git-submodule' recurse [-q|--quiet] [-e|--exit-after-error]
>  +               [-d|--depth <recursion depth>] [-b|--breadth-first]
>  +               [-a|--customized-argument] [-p|--pre-command]
>  +               <git command> [<arg> ...]"
>
>
>   COMMANDS
>  @@ -54,6 +58,10 @@ summary::
>         in the submodule between the given super project commit and the
>         index or working tree (switched by --cached) are shown.
>
>  +recurse::
>  +       Recurse, IOW propagate, command to its submodules if they are
>  +       initialized.
>  +
>   OPTIONS
>   -------
>   -q, --quiet::
>  @@ -78,6 +86,33 @@ OPTIONS
>         Path to submodule(s). When specified this will restrict the command
>         to only operate on the submodules found at the specified paths.
>
>  +-e, --exit-after-error::
>  +       This option is only valid for the recurse command. If its provided then
>  +       then command will not be recursed into any other module once a command
>  +       has failed
>  +-d, --depth <recursion depth>::
>  +       This option is only valid for the recurse command. If its provided then
>  +       then the command will be recursed upto <recursion depth> only.
>  +-b, --breadth-first::
>  +       This option is only valid for the recurse command. If its provided then
>  +       the command will execute in the current node before traversing to its
>  +       child, else it will first traverse the children before executing in the
>  +       current node.
>  +-a, --customized-argument::
>  +       This option is only valid for the recurse command. If its provided then
>  +       user will be prompted for an argument for the <git command> specified.
>  +       Its particularly useful when one wants to supply different arguments
>  +       for the same <git command> for different submodules; for example,
>  +       checking out a branch, one might want branch to differ from submodule
>  +       to submodule
>  +-p, --pre-command::
>  +       This option is only valid for the recurse command. If its provided then
>  +       user will be prompted for a shell command, e.g. 'ls -al', 'pwd' etc.
>  +<git command> [<arg>...]::
>  +       Any git command and their argument. For example, to get the status use
>  +       'status' as <git command> and '-s' or '-o' or any other 'git status'
>  +       arguments as <arg>
>  +
>   FILES
>   -----
>   When initializing submodules, a .gitmodules file in the top-level directory
>  --
>  1.5.4.2
>
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557

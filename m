From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: [TopGit PATCH] README: Fix spelling
Date: Thu, 20 Nov 2008 14:52:13 +0100
Message-ID: <2c6b72b30811200552h46004299w881ad61134ec5555@mail.gmail.com>
References: <1227189062-11951-1-git-send-email-fonseca@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: madduck@debian.org
X-From: git-owner@vger.kernel.org Thu Nov 20 14:54:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L39yw-0007e6-8q
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 14:54:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478AbYKTNwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 08:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755470AbYKTNwQ
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 08:52:16 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:62419 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754951AbYKTNwP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 08:52:15 -0500
Received: by fg-out-1718.google.com with SMTP id 19so367556fgg.17
        for <git@vger.kernel.org>; Thu, 20 Nov 2008 05:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OMgd9UM2T3wArc88Z4wWDDoHyxFOXC5P9xzEHSmreSk=;
        b=VfSaNRiu5fH135K8FqM0G/YK83/k3GtEScvBSPcDRlpLrm1CJktwd9vQV04+jwgtYP
         dSRj6W9DPzTRrj/GIo/KCAYw/wRUO6zzm7MLKtYxaYlaMK6at3Gz+hw0/yOvbrBKdRPS
         hdIEDnZIr3q0CtpTGJ1EUoKU3s02PFj7bL8+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=I9dtceaRJbk71p9E5JGvMNCkO9nXwbaU+j1ogweOV93JGjQCWI2cB4A3Y/wzorT8vT
         d48CyazmNkWPfyg7ugGKRcUpEmLy8WvuJqatj5mEZXx517HXCLJu2RJFk4O1N1fsp+bj
         Jtffrykox86x8iVgLZFiyOUtRSLejM1OkIXzc=
Received: by 10.181.10.10 with SMTP id n10mr737622bki.68.1227189133163;
        Thu, 20 Nov 2008 05:52:13 -0800 (PST)
Received: by 10.181.195.3 with HTTP; Thu, 20 Nov 2008 05:52:13 -0800 (PST)
In-Reply-To: <1227189062-11951-1-git-send-email-fonseca@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101432>

Oops sorry about this one!!! :-/

On Thu, Nov 20, 2008 at 14:51, Jonas Fonseca <fonseca@diku.dk> wrote:
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
>
> ---
>  README [m |   11  [32m+++++ [m [31m------ [m
>  1 files changed, 5 insertions(+), 6 deletions(-) [m
>
>  [1mdiff --git a/README b/README [m
>  [1mindex 5bfe3ee..9e291da 100644 [m
>  [1m--- a/README [m
>  [1m+++ b/README [m
>  [36m@@ -22,7 +22,7 @@ version control of patches (reordering of patches is not [m
>  version-controlled at all). But there are several disadvantages - [m
>  for one, these tools (especially StGIT) do not actually fit well [m
>  with plain Git at all: it is basically impossible to take advantage [m
>  [31m-of the index efectively when using StGIT. But more importantly, [m
>  [32m+ [m [32mof the index effectively when using StGIT. But more importantly, [m
>  these tools horribly fail in the face of distributed environment. [m
>  [m
>  TopGit has been designed around three main tenets: [m
>  [36m@@ -45,7 +45,7 @@ them. [m
>  [m
>  As mentioned above, the main intended use-case for TopGit is tracking [m
>  third-party patches, where each patch is effectively a single topic [m
>  [31m-branch.  In order to flexibly accomodate even complex scenarios when [m
>  [32m+ [m [32mbranch.  In order to flexibly accommodate even complex scenarios when [m
>  you track many patches where many are independent but some depend [m
>  on others, TopGit ignores the ancient Quilt heritage of patch series [m
>  and instead allows the patches to freely form graphs (DAGs just like [m
>  [36m@@ -222,7 +222,7 @@ tg create [m
>  [m
>        After `tg create`, you should insert the patch description [m
>        to the '.topmsg' file, which will already contain some [m
>  [31m-  pre-filled bits. You can set topgit.to, topgit.cc and topgit.bcc [m
>  [32m+ [m        [32mprefilled bits. You can set topgit.to, topgit.cc and topgit.bcc [m
>        configuration variables in order to have `tg create` [m
>        add these headers with given default values to '.topmsg'. [m
>  [m
>  [36m@@ -350,7 +350,7 @@ tg export [m
>        in the cleaned up history (corresponding basically exactly [m
>        to `tg patch` output for the topic branch). [m
>  [m
>  [31m-  The command has two posible outputs now - either a Git branch [m
>  [32m+ [m        [32mThe command has two possible outputs now - either a Git branch [m
>        with the collapsed history, or a quilt series in new directory. [m
>  [m
>        In case of producing collapsed history in new branch, [m
>  [36m@@ -455,7 +455,6 @@ tg update [m
>  [m
>        TODO: tg update -a for updating all topic branches [m
>  [m
>  [31m-TODO: tg depend for adding/removing dependencies smoothly [m
>  TODO: tg rename [m
>  [m
>  [m
>  [36m@@ -485,7 +484,7 @@ whatever Cc headers you choose or the post-three-dashes message. [m
>  When mailing out your patch, basically only few extra headers [m
>  mail headers are inserted and the patch itself is appended. [m
>  Thus, as your patches evolve, you can record nuances like whether [m
>  [31m-the paricular patch should have To-list/Cc-maintainer or vice [m
>  [32m+ [m [32mthe particular patch should have To-list/Cc-maintainer or vice [m
>  versa and similar nuances, if your project is into that. [m
>  From is prefilled from your current GIT_AUTHOR_IDENT, other headers [m
>  can be prefilled from various optional topgit.* config options. [m
> --
> tg: (f17218e..) jf/readme-update (depends on: master)
>



-- 
Jonas Fonseca

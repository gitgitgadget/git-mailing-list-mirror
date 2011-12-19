From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Fix capitalization of "renamelimit" in docs to agree with code
Date: Sun, 18 Dec 2011 16:51:13 -0800 (PST)
Message-ID: <m3ty4xfkpc.fsf@localhost.localdomain>
References: <4EEE86AC.2030802@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 01:51:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcRRo-0001Ij-VW
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 01:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047Ab1LSAvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 19:51:16 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47935 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab1LSAvP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 19:51:15 -0500
Received: by eekc4 with SMTP id c4so4997713eek.19
        for <git@vger.kernel.org>; Sun, 18 Dec 2011 16:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ZzYAxYqNiwnW9qa0ZO34jyCbiblownvtxrh7qDv4BtE=;
        b=L8CoJ1jLJ1YlxdSvoli9Mw54LogdXM7GOKHQoiOyLqYpWoe+1QCEIJgk7NCLQybje7
         2n0TGDLPQl1u0A3PYh5kw+AWlPDmTMo8RX5ZAzq/wvQ4/qeYZWsMBb9tDVeceO3jQIlH
         h8wVKV91yNE9cse02g9Dp+PEodT9CmKmYlXug=
Received: by 10.213.32.195 with SMTP id e3mr4659871ebd.4.1324255873827;
        Sun, 18 Dec 2011 16:51:13 -0800 (PST)
Received: from localhost.localdomain (aehn116.neoplus.adsl.tpnet.pl. [79.186.195.116])
        by mx.google.com with ESMTPS id 76sm37646737eeh.0.2011.12.18.16.51.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Dec 2011 16:51:13 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pBJ0p7xf022014;
	Mon, 19 Dec 2011 01:51:13 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pBJ0ouuR022007;
	Mon, 19 Dec 2011 01:50:56 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4EEE86AC.2030802@pcharlan.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187430>

Pete Harlan <pgit@pcharlan.com> writes:

> Signed-off-by: Pete Harlan <pgit@pcharlan.com>
> ---
> The documentation and bash-completion have always capitalized
> "renamelimit" as "renameLimit".  The code has always lowercased the
> whole name.  Repair the docs.

Key names are *case insensitive* so we can write it in docs in a way
that is more clear, like 'renameLimit'.

Code compares with lowercased key name, so that is why it uses
'renamelimit'.

> @@ -2122,7 +2122,7 @@ _git_config ()
>  		diff.ignoreSubmodules
>  		diff.mnemonicprefix
>  		diff.noprefix
> -		diff.renameLimit
> +		diff.renamelimit
>  		diff.renames
>  		diff.suppressBlankEmpty
>  		diff.tool

Consitency - why you change diff.renameLimit but not
diff.ignoreSubmodules?

-- 
Jakub Narebski

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-show.txt: mention that object path must be relative in EXAMPLES.
Date: Sat, 07 Feb 2009 15:31:47 -0800 (PST)
Message-ID: <m3mycxvn55.fsf@localhost.localdomain>
References: <87zlgxzydw.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sun Feb 08 00:34:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVwgd-0003jk-NN
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 00:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547AbZBGXbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 18:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753388AbZBGXbv
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 18:31:51 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:28577 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbZBGXbu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 18:31:50 -0500
Received: by fg-out-1718.google.com with SMTP id 16so812764fgg.17
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 15:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=xnlgxyScaM3boBs66YWKusLUACOOAlcC15IeNkuz4XI=;
        b=vjxEB5D38oBhWlhHGqw/kQ++wDaU5I5cuolA415rcP/XfiEpY/0v2ERBUNqkGwPaut
         LJxpMxqRD8OiXV3n7OSMfHTJf49iNqumVqalc9yiabjwnM36+ri5kVyicPgi/9+Mz4RJ
         MYku3jxRmphk2i6HvlLEaXsy4bOKP9WqJzns8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=DRRFrX+uPBVwybuxb97ej7C1UEeLEJniXfoeWlaCQX9TxqhTv7+uy4H9dxmYLp+924
         0uOSdV6NMXPH3VyyjKzRCWHIVlrmUmwDqytGTs3ZkdqBk/c1zpnULJIA6SWxCtoiJCnP
         /vWSTPWme092iQ+dsy1Agy+ohnfK8FmRRKFRg=
Received: by 10.86.100.19 with SMTP id x19mr1887180fgb.29.1234049508438;
        Sat, 07 Feb 2009 15:31:48 -0800 (PST)
Received: from localhost.localdomain (abwm89.neoplus.adsl.tpnet.pl [83.8.236.89])
        by mx.google.com with ESMTPS id d4sm2866305fga.58.2009.02.07.15.31.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Feb 2009 15:31:47 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n17NWqen031825;
	Sun, 8 Feb 2009 00:32:53 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n17NWdup031821;
	Sun, 8 Feb 2009 00:32:39 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <87zlgxzydw.fsf@jondo.cante.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108900>

Jari Aalto <jari.aalto@cante.net> writes:

> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
> ---
>  Documentation/git-show.txt |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
> index 48b612e..2a014cc 100644
> --- a/Documentation/git-show.txt
> +++ b/Documentation/git-show.txt
> @@ -57,7 +57,11 @@ git show v1.0.0^\{tree\}::
>  git show next~10:Documentation/README::
>  	Shows the contents of the file `Documentation/README` as
>  	they were current in the 10th last commit of the branch
> -	`next`.
> +	`next`. *Note:* the 'object' path must always be relative to git
> +	project root. This wouldn't have worked:
> +
> +	$ cd Documentation
> +	$ git show next~10:README

Actually that is not exactly true.  In the <tree-ish>:<path> the
'object' path must be always relative to <tree-ish), in this case
to "next~10", which means relative to project root at given commit
(important in case of subtree merge).

Although in practice <tree-ish> is always commit.

>  
>  git show master:Makefile master:t/Makefile::
>  	Concatenates the contents of said Makefiles in the head
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git

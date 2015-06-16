From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] git-prompt.sh: Document GIT_PS1_STATESEPARATOR
Date: Tue, 16 Jun 2015 15:32:38 +0200
Message-ID: <20150616153238.Horde.tGSXailmVRSmoEen3NAoPw4@webmail.informatik.kit.edu>
References: <1433956764-38130-1-git-send-email-joe.cridge@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
Cc: git@vger.kernel.org, gitster@pobox.com, rhansen@bbn.com,
	felipe.contreras@gmail.com, artagnon@gmail.com
To: Joe Cridge <joe.cridge@me.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 15:32:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4qyt-0000ji-8q
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 15:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758AbbFPNcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 09:32:43 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:39715 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754173AbbFPNcm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jun 2015 09:32:42 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1Z4qyl-0008RT-7g; Tue, 16 Jun 2015 15:32:39 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1Z4qyk-00048O-VA; Tue, 16 Jun 2015 15:32:38 +0200
Received: from x590d3112.dyn.telefonica.de (x590d3112.dyn.telefonica.de
 [89.13.49.18]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Tue, 16 Jun 2015 15:32:38 +0200
In-Reply-To: <1433956764-38130-1-git-send-email-joe.cridge@me.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1434461559.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271752>


Quoting Joe Cridge <joe.cridge@me.com>:
> The environment variable GIT_PS1_STATESEPARATOR can be used to set the
> separator between the branch name and the state symbols in the prompt.
>
> At present the variable is not mentioned in the inline documentation which
> makes it difficult for the casual user to identify.

Thanks, makes sense.

> Signed-off-by: Joe Cridge <joe.cridge@me.com>
> ---
>  contrib/completion/git-prompt.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/contrib/completion/git-prompt.sh  
> b/contrib/completion/git-prompt.sh
> index f18aedc..366f0bc 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -66,6 +66,10 @@
>  #     git           always compare HEAD to @{upstream}
>  #     svn           always compare HEAD to your SVN upstream
>  #
> +# You can change the separator between the branch name and the above
> +# state symbols by setting GIT_PS1_STATESEPARATOR. The default separator
> +# is SP.

This is not a specification of a protocol or file or input/output  
format, where we formally use SP and LF.  Perhaps we could spell out  
SP as a space here, for the sake of the "casual user"?

> +#
>  # By default, __git_ps1 will compare HEAD to your SVN upstream if it can
>  # find one, or @{upstream} otherwise.  Once you have set
>  # GIT_PS1_SHOWUPSTREAM, you can override it on a per-repository basis by
> --
> 2.4.2

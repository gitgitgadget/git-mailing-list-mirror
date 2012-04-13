From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 4/4] completion: improve 'git --exec-path' completion
Date: Fri, 13 Apr 2012 01:08:45 -0500
Message-ID: <20120413060845.GA15610@burratino>
References: <1334274603-3277-1-git-send-email-felipe.contreras@gmail.com>
 <1334274603-3277-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 08:09:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIZgu-0004r4-Lv
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 08:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687Ab2DMGI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 02:08:57 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53097 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab2DMGI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 02:08:57 -0400
Received: by iagz16 with SMTP id z16so3813625iag.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 23:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KT8w0nplO6zhftN8pSFzpBjfrSyXjk+14ZLwxJX5Zg8=;
        b=z9MsVYfTeI4B6j57iczS46+nmIpF9km9xFZ//cx/BTrFQGuwSP3CfCM8TdfbbuVVIS
         E9CEXK7aPl/fsUFRDnVq/SUE0rOB8Uz7Ry7uIviOpRqmhf0Oc45SviURb8HuLYZv0c+L
         752/CRUzZBtYupbIokITNIunNbyqq9B23qEMonVPe4Q7YwM6lsaN2SubSMpbubeGSAKZ
         ISyxmDGQSvsSn6hBxhUu6sshmtTCeJYi9tXKQgo3riy6kmTvgDU6GphpOQ6hX7isfiS8
         Y/JECuc6dza0AEV99X9KGnse8hBY4ufutNHseBIdEqoELmCoe8HYBK8llM0z1/Bslc7E
         EpFg==
Received: by 10.50.88.199 with SMTP id bi7mr518015igb.15.1334297336424;
        Thu, 12 Apr 2012 23:08:56 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id zv10sm1814950igb.13.2012.04.12.23.08.54
        (version=SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 23:08:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334274603-3277-5-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195399>

Felipe Contreras wrote:

> All other options that accept an argument are completed this way, plus,
> the '--foo bar' format doesn't seem to work correctly at the moment.
[...]
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2638,7 +2638,7 @@ _git ()
>  			--git-dir=
>  			--bare
>  			--version
> -			--exec-path
> +			--exec-path=
>  			--html-path

Thanks.

"git --exec-path" means to print the name of the directory where git
stores its subcommands and other helpers.  I have no thoughts either
way about whether a user typing

	git --exec-p<TAB>

is more likely to be asking for the current exec-path or intending to
override it.

Hope that helps,
Jonathan

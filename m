From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [ANNOUNCE] Git v2.0.0-rc4
Date: Wed, 21 May 2014 17:30:45 -0400
Message-ID: <537D1B05.6030209@bbn.com>
References: <xmqqr43oq8q5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 23:30:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnE68-0001w7-De
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 23:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687AbaEUVat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 17:30:49 -0400
Received: from smtp.bbn.com ([128.33.1.81]:10114 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801AbaEUVas (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 17:30:48 -0400
Received: from socket.bbn.com ([192.1.120.102]:57766)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WnE6E-0005h2-0M; Wed, 21 May 2014 17:30:58 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 8349340320
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <xmqqr43oq8q5.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249836>

On 2014-05-20 20:24, Junio C Hamano wrote:
> Fixes since v1.9 series
> -----------------------
> 
> Unless otherwise noted, all the fixes since v1.9 in the maintenance
> track are contained in this release (see the maintenance releases'
> notes for details).
[...]
>
>  * The shell prompt script (in contrib/), when using the PROMPT_COMMAND
>    interface, used an unsafe construct when showing the branch name in
>    $PS1.
>    (merge 8976500 rh/prompt-pcmode-avoid-eval-on-refname later to maint).

That commit has been merged to maint and is in v1.9.3.

Also, 1e4119c (git-prompt.sh: don't assume the shell expands the value
of PS1) is a fix that is in v2.0.0-rc4 but not v1.9.x.  Maybe add
something like:

 * The shell prompt script (in contrib/), when using Zsh and the
   precmd() interface, printed ${__git_ps1_branch_name} in the prompt
   instead of the branch name (regression in v1.9.3).
   (merge 1e4119c rh/prompt-pcmode-avoid-eval-on-refname later to
   maint).

-Richard

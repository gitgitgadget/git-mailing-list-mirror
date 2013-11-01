From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (Nov 2013, #01; Fri, 1)
Date: Fri, 01 Nov 2013 23:12:07 +0000
Message-ID: <52743547.7020001@ramsay1.demon.co.uk>
References: <xmqqob6320rt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 02 00:18:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcNyu-0006Gr-Dp
	for gcvg-git-2@plane.gmane.org; Sat, 02 Nov 2013 00:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770Ab3KAXSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 19:18:16 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:49759 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751639Ab3KAXSP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 19:18:15 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Nov 2013 19:18:15 EDT
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id B2FE4400F9E;
	Fri,  1 Nov 2013 23:12:09 +0000 (GMT)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 7CF7C400F93;
	Fri,  1 Nov 2013 23:12:09 +0000 (GMT)
Received: from [192.168.254.2] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Fri,  1 Nov 2013 23:12:09 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqob6320rt.fsf@gitster.dls.corp.google.com>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237231>

On 01/11/13 22:52, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.
>
[ ... ]
> 
> 
> * fc/transport-helper-fixes (2013-11-01) 11 commits
>  - transport-helper: demote lack of "force" option to a warning
>  - transport-helper: add support to delete branches
>  - fast-export: add support to delete refs
>  - fast-import: add support to delete refs
>  - transport-helper: add support for old:new refspec
>  - fast-export: add new --refspec option
>  - fast-export: improve argument parsing
>  - transport-helper: check for 'forced update' message
>  - transport-helper: add 'force' to 'export' helpers
>  - transport-helper: don't update refs in dry-run
>  - transport-helper: mismerge fix
> 
>  Updates transport-helper, fast-import and fast-export to allow the
>  ref mapping and ref deletion in a way similar to the natively
>  supported transports.
> 
>  Will merge to 'next'.

Commit ad24a30ef ("fast-export: add new --refspec option", 31-10-2013)
causes sparse to complain:

      SP builtin/fast-export.c
  builtin/fast-export.c:739:55: warning: Variable length array is used.

Do we want to use this C99 feature?

ATB,
Ramsay Jones

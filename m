From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Dec 2013, #03; Thu, 12)
Date: Fri, 13 Dec 2013 08:39:34 +0100
Message-ID: <52AAB9B6.4080402@web.de>
References: <xmqqwqj9r2ig.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 13 08:40:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrNLs-0008PL-Rm
	for gcvg-git-2@plane.gmane.org; Fri, 13 Dec 2013 08:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861Ab3LMHj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Dec 2013 02:39:57 -0500
Received: from mout.web.de ([212.227.17.12]:59105 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153Ab3LMHj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Dec 2013 02:39:56 -0500
Received: from [192.168.1.103] ([194.47.242.237]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MGA7n-1Vnkrc0LvL-00FBKA for <git@vger.kernel.org>;
 Fri, 13 Dec 2013 08:39:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131104 Icedove/17.0.10
In-Reply-To: <xmqqwqj9r2ig.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:bHOgSMie50qCPD8o3L2UafWwMbvw9bzgfw12FzFAtIttkgsmoxg
 onyJFu/bz6RjNYXwNmffNQNmnBg0ymqvLItlTaZ3pFZ/YReq3CFK82ZsQjcdiw6Ak2O6TOt
 FTYfl7fCOnzkIn6IT9L7bxFQiR0nQJ1QblZnnXw1givF2guX9f/LVsvC7OnN92QvKWSRLBF
 rM/VWQLQ6rNwGkcjEem/Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239257>

On 12/13/2013 01:57 AM, Junio C Hamano wrote:
> [Cooking]
>
> * fc/transport-helper-fixes (2013-12-09) 6 commits
>   - remote-bzr: support the new 'force' option
>   - test-hg.sh: tests are now expected to pass
>   - transport-helper: check for 'forced update' message
>   - transport-helper: add 'force' to 'export' helpers
>   - transport-helper: don't update refs in dry-run
>   - transport-helper: mismerge fix
>
>   Updates transport-helper, fast-import and fast-export to allow the
>   ref mapping and ref deletion in a way similar to the natively
>   supported transports.
>
>   Will merge to 'next'.
This breaks t5541, (at least on my systems, both Linux and Mac OS)

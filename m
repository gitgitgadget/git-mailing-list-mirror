From: Keshav Kini <keshav.kini@gmail.com>
Subject: Re: [PATCH] RelNotes/1.8.5: direct script writers to "git status --porcelain"
Date: Thu, 26 Sep 2013 15:45:20 -0500
Message-ID: <87y56jl3bz.fsf@gmail.com>
References: <1380201815-14140-1-git-send-email-Matthieu.Moy@imag.fr>
	<loom.20130926T201754-563@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 26 22:45:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPIRR-00048o-GV
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 22:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473Ab3IZUpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 16:45:38 -0400
Received: from plane.gmane.org ([80.91.229.3]:40147 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753020Ab3IZUph (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 16:45:37 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VPIRJ-00043y-QG
	for git@vger.kernel.org; Thu, 26 Sep 2013 22:45:33 +0200
Received: from nat-128-62-40-141.public.utexas.edu ([128.62.40.141])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 22:45:33 +0200
Received: from keshav.kini by nat-128-62-40-141.public.utexas.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 22:45:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: nat-128-62-40-141.public.utexas.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:yJyp/O8cNnxWrET8JSqJLmdQOsY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235433>

Jakub Narebski <jnareb@gmail.com> writes:
> Matthieu Moy <Matthieu.Moy <at> imag.fr> writes:
>>   * "git status" now omits the prefix to make its output a comment in a
>>     commit log editor, which is not necessary for human consumption.
>> +   Scripts that parse the output of "git status" are advised to use
>> +   "git status --porcelain", which is both easier to parse and stable,
>> +   instead.
>
> Good addition.
>
> Perhaps "to use instead ..." would be easier to understand than
> proposed "to use ..., instead." (with "..." being one line long).

FWIW, I find "to use instead ___" slightly stilted. I'd suggest "to
instead use", but rewording it to the following is much better, IMHO:
'... are advised to use "git status --porcelain" instead, as it is both
stable and easier to parse.'

-Keshav

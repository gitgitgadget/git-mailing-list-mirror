From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git branch command is incompatible with bash
Date: Tue, 28 Jul 2015 09:28:09 +0200
Message-ID: <55B72F09.3030000@kdbg.org>
References: <20150727121253.GC17338@2vizcon.com> <55B69E68.90306@kdbg.org>
 <xmqqh9opgtjz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Anatol Rudolph <a.rudolph@2vizcon.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 09:28:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJzJH-0001mm-5d
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 09:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbbG1H2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 03:28:14 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:6626 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751176AbbG1H2N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 03:28:13 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3mgV3H0LLVz5tlb;
	Tue, 28 Jul 2015 09:28:10 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id BDD7952CB;
	Tue, 28 Jul 2015 09:28:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <xmqqh9opgtjz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274751>

Am 27.07.2015 um 23:49 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Try
>>
>>    branchName=$(git rev-parse --abbrev-ref HEAD)
>
> Hmm, interesting.
>
>      $ git checkout --orphan notyet
>      $ git rev-parse --abbrev-ref HEAD
>      $ git symbolic-ref --short HEAD
>

Please don't scare newcomers with these corner cases ;-)

I see this:

$ git rev-parse --abbrev-ref HEAD
HEAD
fatal: ambiguous argument 'HEAD': unknown revision or path not in the 
working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
$ git symbolic-ref --short HEAD
notyet

Are you trying to say that the result of 'rev-parse --abbrev-ref HEAD' 
is suboptimal and that of 'symbolic-ref --short HEAD' is OK?

-- Hannes

From: THILLOSEN Andreas <thillosen@free.fr>
Subject: Re: Git: Question about specific subtree usage
Date: Sun, 12 Jan 2014 13:18:16 +0100
Message-ID: <52D28808.9010001@free.fr>
References: <52D1E07C.1010403@free.fr> <52D26E7A.8080003@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 12 12:18:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2J4B-00073H-PT
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jan 2014 12:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbaALLSm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jan 2014 06:18:42 -0500
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:42093 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbaALLSl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jan 2014 06:18:41 -0500
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id CE9D3CA8FDE
	for <git@vger.kernel.org>; Sun, 12 Jan 2014 12:18:37 +0100 (CET)
Received: from [192.168.1.100] (unknown [88.178.152.236])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 96BBDD4805F;
	Sun, 12 Jan 2014 12:18:21 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <52D26E7A.8080003@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240346>

Well... submodules didn't seem to fit the job, because it seems that th=
e
sources of only one submodule at a time can be checked out.
And in my case, I would need to have the sources of all submodules
simultaneously.
I was talking about subtrees, because I thought it could be a better
tool for this job (and it had the reputation of being less cumbersome
than submodules).

Maybe such a job cannot be done with pure git commands.
Thanks for pointing me this "git-repo" script tool... the description
seems to fit my needs!
I will test it, and hope it will work on Windows (project is
unfortunately very Windows-oriented, for the time being).

Thanks for you help!

Andreas THILLOSEN.


Le 01/12/14 11:29, Torsten B=F6gershausen a =E9crit :
> On 2014-01-12 01.23, THILLOSEN Andreas wrote:
>> Hi,
>>
>> I have a question about a specific use case for subtrees, but I'm no=
t
> I feel a little bit confused: Are you talking about git submodules?
>
> And you may want to have a look at the repo tool:
> https://code.google.com/p/git-repo/
>
> HTH
> /Torsten
>
>
>
>

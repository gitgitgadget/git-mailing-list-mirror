From: Thorsten Jolitz <tjolitz@gmail.com>
Subject: Re: Zile as git core editor?
Date: Fri, 26 Apr 2013 10:37:50 +0200
Message-ID: <87txmt7km9.fsf@gmail.com>
References: <877gjp91w5.fsf@gmail.com>
	<CALUzUxpZ9=8aVEMBfFUH2hN5ZkwzKVX31J79MVzkCEGRX++LPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 10:38:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVeAa-0000PH-AE
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 10:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757700Ab3DZIiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 04:38:10 -0400
Received: from plane.gmane.org ([80.91.229.3]:40249 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677Ab3DZIiH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 04:38:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UVeAM-0000Aa-Ag
	for git@vger.kernel.org; Fri, 26 Apr 2013 10:38:02 +0200
Received: from g231235181.adsl.alicedsl.de ([92.231.235.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 10:38:02 +0200
Received: from tjolitz by g231235181.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 10:38:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: g231235181.adsl.alicedsl.de
User-Agent: Gnus/5.130002 (Ma Gnus v0.2) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:QeGTQ6heoPNzbTMIzosnuokQLHU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222511>

Tay Ray Chuan <rctay89@gmail.com> writes:

Hi,

> Is the GIT_EDITOR or EDITOR environment variable set? They may be
> overriding the core.editor setting.

Actually, EDITOR is set to Zile, so that should not be the problem:

[tj@hostname ~]$ echo $EDITOR
/usr/bin/zile
[tj@hostname ~]$ echo $GIT_EDITOR

[tj@hostname ~]$ 

BTW - would 'git config --global core.editor zile' or 'git config
--global core.editor /usr/bin/zile' the right way to set it (both did
not work)? I can start Zile simply with 'zile' on the command line. 

> --
> Cheers,
> Ray Chuan
>
> On Fri, Apr 26, 2013 at 3:39 PM, Thorsten Jolitz <tjolitz@gmail.com> wrote:
>>
>> Hi List,
>>
>> after experiencing one crash to many, I'm back to Standard Emacs
>> (instead of Emacsserver/Emacsclient), thus using 'emacs' (instead of
>> emacsclient) as git core editor triggers reading my huge init file and
>> is way to slow.
>>
>> I would like to use Zile (a small Emacs clone) instead, and although
>> otherwise it works alright on my system, it does not seem to work as git
>> core editor.
>>
>> Is it possible to use 'git config --global core.editor zile'?
>>
>> --
>> cheers,
>> Thorsten
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
cheers,
Thorsten

From: Thorsten Jolitz <tjolitz@gmail.com>
Subject: Re: Zile as git core editor?
Date: Fri, 26 Apr 2013 18:08:05 +0200
Message-ID: <87ppxh6zru.fsf@gmail.com>
References: <877gjp91w5.fsf@gmail.com>
	<CALUzUxpZ9=8aVEMBfFUH2hN5ZkwzKVX31J79MVzkCEGRX++LPw@mail.gmail.com>
	<87txmt7km9.fsf@gmail.com> <vpqppxhfz3i.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 18:08:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVlC8-0000c6-II
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 18:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781Ab3DZQIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 12:08:16 -0400
Received: from plane.gmane.org ([80.91.229.3]:54793 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387Ab3DZQIP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 12:08:15 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UVlC1-0000Su-VL
	for git@vger.kernel.org; Fri, 26 Apr 2013 18:08:13 +0200
Received: from g231235181.adsl.alicedsl.de ([92.231.235.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 18:08:13 +0200
Received: from tjolitz by g231235181.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 18:08:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: g231235181.adsl.alicedsl.de
User-Agent: Gnus/5.130002 (Ma Gnus v0.2) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:sreVLkBuWAAUc5YegAWl9CNLBbA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222535>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Thorsten Jolitz <tjolitz@gmail.com> writes:
>
>> BTW - would 'git config --global core.editor zile' or 'git config
>> --global core.editor /usr/bin/zile' the right way to set it (both did
>> not work)? I can start Zile simply with 'zile' on the command line. 
>
> What do you mean by "did not work"? Does the launching fail? Or is
> another editor launched?
>
> Try:
>
> GIT_TRACE=true git commit -a
>
> to see what's going on.
>
> BTW, you may also try "emacs -nw -Q" instead of zile.


Thanks for the tip, I found out that:

1. on the command-line, zile actually works as core editor, but
2. not from within Emacs (Magit) where I tried it

 "emacs -nw -Q" is a nice tip, but I think what I really would like to
 have it that, when I use GNU Emacs Magit and enter a git command 

,-----------------------------
| Run git like this: <command>
`-----------------------------

that calls an editor (e.g. commit --amend), the running Emacs instance
is (re)used and a new buffer is opened for editing (instead of starting
another Emacs instance).

-- 
cheers,
Thorsten

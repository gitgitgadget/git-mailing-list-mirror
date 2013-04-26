From: Thorsten Jolitz <tjolitz@gmail.com>
Subject: Re: Zile as git core editor?
Date: Fri, 26 Apr 2013 20:33:25 +0200
Message-ID: <87ip396t1m.fsf@gmail.com>
References: <877gjp91w5.fsf@gmail.com>
	<CALUzUxpZ9=8aVEMBfFUH2hN5ZkwzKVX31J79MVzkCEGRX++LPw@mail.gmail.com>
	<87txmt7km9.fsf@gmail.com> <vpqppxhfz3i.fsf@grenoble-inp.fr>
	<87ppxh6zru.fsf@gmail.com> <7vtxmtxm4j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 20:33:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVnSs-0000Je-Vx
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 20:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198Ab3DZSdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 14:33:39 -0400
Received: from plane.gmane.org ([80.91.229.3]:57605 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756361Ab3DZSdi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 14:33:38 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UVnSe-0008Tj-6n
	for git@vger.kernel.org; Fri, 26 Apr 2013 20:33:32 +0200
Received: from g231235181.adsl.alicedsl.de ([92.231.235.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 20:33:32 +0200
Received: from tjolitz by g231235181.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 20:33:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: g231235181.adsl.alicedsl.de
User-Agent: Gnus/5.130002 (Ma Gnus v0.2) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:NzvvqSf1MUsApWJBrfMDF2HQMi0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222547>

Junio C Hamano <gitster@pobox.com> writes:

> Thorsten Jolitz <tjolitz@gmail.com> writes:
>
>>  ... I think what I really would like to
>>  have it that, when I use GNU Emacs Magit and enter a git command 
>>
>> ,-----------------------------
>> | Run git like this: <command>
>> `-----------------------------
>>
>> that calls an editor (e.g. commit --amend), the running Emacs instance
>> is (re)used and a new buffer is opened for editing (instead of starting
>> another Emacs instance).
>
> Hmph, isn't that what "emacsclient" is for?  I have these
>
> 	(setenv "PAGER" "cat")
> 	(setenv "EDITOR" "emacsclient")
> 	(server-start)
>
> somewhere in my ~/.emacs to make commands in "M-x compile" behave.

I was a big fan of emacsclient and used it quite some time - but finally
those frequent Emacs crashes caused by it were just unbearable, so I
went back to 'normal' use of Emacs.

But maybe you are right - I should run a second Emacs instance as server
only used to popup emacsclient buffers on demand, while doing all the
serious stuff in a non-server instance of Emacs. 

-- 
cheers,
Thorsten

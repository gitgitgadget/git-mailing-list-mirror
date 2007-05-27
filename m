From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: GIT on MinGW, with tcltk for gitk
Date: Sun, 27 May 2007 19:22:08 -0300
Message-ID: <465A0490.3050303@xs4all.nl>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org> <4659D306.6030803@xs4all.nl> <f3cnm6$gda$1@sea.gmane.org> <00a601c7a09f$218c1020$0200a8c0@AMD2500> <4659F5D0.2070406@xs4all.nl> <00b901c7a0a5$77983420$0200a8c0@AMD2500> <00c401c7a0a7$8a5690a0$0200a8c0@AMD2500>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 28 00:24:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsRAG-00035G-CG
	for gcvg-git@gmane.org; Mon, 28 May 2007 00:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756523AbXE0WYe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 18:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755585AbXE0WYe
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 18:24:34 -0400
Received: from main.gmane.org ([80.91.229.2]:50602 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756523AbXE0WYd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 18:24:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HsRA3-0000Je-Ig
	for git@vger.kernel.org; Mon, 28 May 2007 00:24:27 +0200
Received: from c911deb6.bhz.virtua.com.br ([201.17.222.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 May 2007 00:24:27 +0200
Received: from hanwen by c911deb6.bhz.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 May 2007 00:24:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c911deb6.bhz.virtua.com.br
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <00c401c7a0a7$8a5690a0$0200a8c0@AMD2500>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48588>

Aaron Gray escreveu:
>>> Aaron Gray escreveu:
>>>
>>>> C:\Work\test>git init
>>>> warning: templates not found C:/Program Files/Git/usr/bin@template_dir@
>>>> Initialized empty Git repository in .git/
>>>>
>>>> Aaron
>>>
>>> Thanks for the report. Can you try again with 1.5.2-7  ? It should be
>>> available
>>> in a few minutes.
>>
>> Okay, I'm up for all the testing thats needed. Just dont know the
>> territory that well though, as I am a Windozer :)
> 
> git init appears to work fine now, the template path is found.
> 
> git clone or git-clone is still not working.
> 

clone is a shell script. None of the shell scripts work; you'll have
to install msys bash yourself for now.

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen

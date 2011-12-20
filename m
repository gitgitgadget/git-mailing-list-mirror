From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: Escape character for .gitconfig
Date: Tue, 20 Dec 2011 20:46:44 +0100
Message-ID: <4EF0E624.1090500@dirk.my1.cc>
References: <4EEC6A9D.1060005@icefield.yk.ca> <20111217105806.GB23935@sigill.intra.peff.net> <4EED9BE5.8060600@icefield.yk.ca> <20111218095120.GA2290@sigill.intra.peff.net> <4EEF5F59.8030802@dirk.my1.cc> <4EF04199.1010008@icefield.yk.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Erik Blake <erik@icefield.yk.ca>
X-From: git-owner@vger.kernel.org Tue Dec 20 20:46:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd5eG-0007Jy-5p
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 20:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826Ab1LTTqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 14:46:49 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.98]:48531 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab1LTTqr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 14:46:47 -0500
Received: from [84.176.60.213] (helo=[192.168.2.100])
	by smtprelay05.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1Rd5e9-0002un-4b; Tue, 20 Dec 2011 20:46:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EF04199.1010008@icefield.yk.ca>
X-Df-Sender: NzU3NjQ2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187521>

Am 20.12.2011 09:04 schrieb Erik Blake:
> Hi Dirk,
>
> I ended up using "'C:/Program Files (x86)/Notepad++/notepad++.exe'
> -multiInst -notabbar -nosession -noPlugin" which works nicely for me
> (note the placement of the inner quotations).
>
> It is notepad.exe (the default Windows editor) that fails on files with
> only <lf> termination. That's why I was trying to set notepad++ as the
> git editor as it is vastly superior.
>
> Cheers,
> Erik

Hi Erik,

oops, I overread that you talked about notepad (not notepad++) and the
<lf> stuff. My fault. I use the portable version of notepad++ and don't
have the "space in path" problem. But if you mainly use the git-bash (as
I do) instead of cmd.exe, then probably you could tweak your .bashrc:

export PATH="/C:/Program Files (x86)/Notepad++":$PATH

and then run notepad++ w/o giving the absolute path.

Cheers,
    Dirk

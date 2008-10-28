From: Hannu Koivisto <azure@iki.fi>
Subject: Re: git bisect view's use of DISPLAY environment variable in Cygwin
Date: Wed, 29 Oct 2008 00:37:55 +0200
Organization: NOYB
Message-ID: <83iqrccpmk.fsf@kalahari.s2.org>
References: <83wsfs1y6v.fsf@kalahari.s2.org>
	<c07716ae0810281015s47741fdqec4c3bed3313bb6a@mail.gmail.com>
	<83skqg1uc9.fsf@kalahari.s2.org>
	<c07716ae0810281213k432d82d8i468f54ae03146b88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 28 23:39:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuxDg-0000mp-FB
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 23:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbYJ1WiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 18:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbYJ1WiJ
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 18:38:09 -0400
Received: from main.gmane.org ([80.91.229.2]:38833 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752756AbYJ1WiI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 18:38:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KuxCM-0001HT-E2
	for git@vger.kernel.org; Tue, 28 Oct 2008 22:38:02 +0000
Received: from s2.org ([195.197.64.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 22:38:02 +0000
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 22:38:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:qlLEEaTgOTxKF8cmp8MWVsyszqw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99328>

"Christian Couder" <christian.couder@gmail.com> writes:

> On Tue, Oct 28, 2008 at 6:51 PM, Hannu Koivisto <azure@iki.fi> wrote:
>> "Christian Couder" <christian.couder@gmail.com> writes:

> We need at least a way to detect we are under Cygwin, because we won't
> change the current behavior for all platforms.
> Is checking for the CYGWIN environment variable enough?

No, because it may not be set.  I would probably do it at compile
time using __CYGWIN__ definition.  I don't know what's the status
of merging MSysGit with "official" git but I suppose that when that
happens, __MING32__ and/or _WIN32 or something would need to be
considered as well.

>>> You can use "git bisect view log" to use "git log" even if DISPLAY is set.
>>
>> I'd rather not use undocumented functionality ;)
>
> In this case you can use any "git log" option after "git bisect view"
> (for example: git bisect view -p).

I was implying that "log" after "git bisect view" is not documented
by git-bisect(1).  "log" is not a "git log" option.

-- 
Hannu

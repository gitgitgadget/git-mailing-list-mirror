From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 21 Jul 2008 00:58:01 +0200
Message-ID: <bd6139dc0807201558k6e3d85b8u30d214f16e1040bd@mail.gmail.com>
References: <20080718182010.6117@nanako3.lavabit.com>
	 <alpine.DEB.1.00.0807181351370.3932@eeepc-johanness>
	 <7vabge30dh.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0807191311220.3305@eeepc-johanness>
	 <20080720130407.GF10347@genesis.frugalware.org>
	 <7vd4l88l77.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0807202102370.3305@eeepc-johanness>
	 <7vd4l85nv5.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0807201303u406484e2x127b2391a9920425@mail.gmail.com>
	 <20080720203306.GO10347@genesis.frugalware.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Nanako Shiraishi" <nanako3@lavabit.com>, git@vger.kernel.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jul 21 00:59:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKhrt-0002Qz-8u
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 00:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbYGTW6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 18:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752976AbYGTW6F
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 18:58:05 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:56187 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbYGTW6C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 18:58:02 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1296364wfd.4
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 15:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=G2Zv91yTZW3iiuPAJ4NfIJOe+sCgmmbEqcPpPwWGB0s=;
        b=SCKFLHZfGXPntD/P+x7Tkcv3k9FxukhvqcMN6bFaggEVoxDsBUb5+tAYMz0PxrHmKw
         2xz24zjOIq0J1NXElTfl1N3GiEqI6y6sMKWiWsea0I7sLk++TQxFhQeG32qMmYsMxOdQ
         eskGe+o01S66OXbU3RlzY0VVu2eel7SAp3DQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=G9i3L7tgoF+pCVmU182YmxjeNvtEmobwlSccb3t/qSS8XNlx4KSoq1rNwijHXHqH/B
         BjH5+hZDViTCqsBeka6quuQUV7p22QDfsWQWhTaR0o1zhdsSujjxPyWZ/EGOsDxbP0Fj
         8q3zhxWt8BRkPLkWmoZHh5x7RL3wYZqzbsMHQ=
Received: by 10.142.204.18 with SMTP id b18mr1048224wfg.126.1216594681832;
        Sun, 20 Jul 2008 15:58:01 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Sun, 20 Jul 2008 15:58:01 -0700 (PDT)
In-Reply-To: <20080720203306.GO10347@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89258>

On Sun, Jul 20, 2008 at 10:33 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Sun, Jul 20, 2008 at 10:03:24PM +0200, Sverre Rabbelier <alturin@gmail.com> wrote:
>> Whatever happened to quotes?
>>
>>         $ git merge -s subtree -Xpath="git-gui git-gui/master"
>
> Read again what did you wrote. ;-)
>
> The current form is
>
> git merge -s subtree git-gui/master, so at most it could be
>
>        $ git merge -s subtree -Xpath="git-gui" git-gui/master

Meh, what I ofcourse mean was:
         $ git merge -s subtree -X"path=git-gui" git-gui/master

But that looks rather awkward, which is probably why I typed it the
way I did? Maybe something like....
         $ git merge -s subtree -X(--path=git-gui --foo=bar) git-gui/master

-- 
Cheers,

Sverre Rabbelier

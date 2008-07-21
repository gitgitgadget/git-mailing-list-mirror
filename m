From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 21 Jul 2008 01:47:23 -0700 (PDT)
Message-ID: <m3bq0rwrp7.fsf@localhost.localdomain>
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
	<bd6139dc0807201558k6e3d85b8u30d214f16e1040bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Miklos Vajna" <vmiklos@frugalware.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Nanako Shiraishi" <nanako3@lavabit.com>, git@vger.kernel.org
To: "Sverre Rabbelier" <sverre@rabbelier.nl>
X-From: git-owner@vger.kernel.org Mon Jul 21 10:48:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKr4H-0006US-Gf
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 10:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410AbYGUIra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 04:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755193AbYGUIra
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 04:47:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:21513 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668AbYGUIr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 04:47:28 -0400
Received: by fg-out-1718.google.com with SMTP id 19so600740fgg.17
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 01:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=4A3x8o0ZPpZdQUWbXymDSCRqr5H3LiyAdvbc3Hkiggc=;
        b=rJm9rGzNnPqqr9RYYdGQLCNcFD+0ixfUv9pkSHT9cXhD9ltKxkpVwD+hARDlHyIEOd
         KGJeUYGwwnQS9UrHwQUOPCF/cmT5IiBWwHuohMvGqfYltVHH4ujl8YvBESkCR/84AhXv
         LGaQ4q3qrVd6v4nhVI7R3LB0zf9KGks7dhvDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=br5AZfgwTEW3okHPDI8niBc+Z5E1ipjTPj7PPyST3SzaYANnDjDe8SV0x7a+03c5Vy
         8ikQZPRxYdiqMWEEQtPm7TIRUUBiIoYYC9Juz/fKxKX/2XkyyBF8f55cIOOabfdVIpK9
         Qe/4StCURjB6ue/C9inqV+jFYqLYr5dC5sCFs=
Received: by 10.86.80.5 with SMTP id d5mr4567441fgb.19.1216630045019;
        Mon, 21 Jul 2008 01:47:25 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.212.51])
        by mx.google.com with ESMTPS id 12sm2903312fgg.0.2008.07.21.01.47.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jul 2008 01:47:23 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6L8kTiK012413;
	Mon, 21 Jul 2008 10:46:40 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6L8ju1R012408;
	Mon, 21 Jul 2008 10:45:56 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <bd6139dc0807201558k6e3d85b8u30d214f16e1040bd@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89325>

"Sverre Rabbelier" <alturin@gmail.com> writes:

> On Sun, Jul 20, 2008 at 10:33 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
>> On Sun, Jul 20, 2008 at 10:03:24PM +0200, Sverre Rabbelier <alturin@gmail.com> wrote:
>>> Whatever happened to quotes?
>>>
>>>         $ git merge -s subtree -Xpath="git-gui git-gui/master"
>>
>> Read again what did you wrote. ;-)
>>
>> The current form is
>>
>> git merge -s subtree git-gui/master, so at most it could be
>>
>>        $ git merge -s subtree -Xpath="git-gui" git-gui/master
> 
> Meh, what I of course mean was:
>          $ git merge -s subtree -X"path=git-gui" git-gui/master
> 
> But that looks rather awkward, which is probably why I typed it the
> way I did? Maybe something like....
>          $ git merge -s subtree -X(--path=git-gui --foo=bar) git-gui/master

Or perhaps (following -Wx family of GCC options)

           $ git merge -s subtree -X--path=git-gui,--foo=bar git-gui/master

-- 
Jakub Narebski
Poland
ShadeHawk on #git

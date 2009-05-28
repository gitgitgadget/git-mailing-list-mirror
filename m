From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Strangely hosed git install
Date: Thu, 28 May 2009 11:34:33 +0200
Message-ID: <46a038f90905280234h35b9b90fwfc52434cd056578e@mail.gmail.com>
References: <46a038f90905280008h5510d03aj5f6e5728ca075027@mail.gmail.com>
	 <7vprdthezg.fsf@alter.siamese.dyndns.org>
	 <46a038f90905280022s1c07565bnf26335fccf7c7e94@mail.gmail.com>
	 <4A1E4B82.9040809@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 28 11:34:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9c0d-0000la-G4
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 11:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469AbZE1Jee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 05:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753133AbZE1Jee
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 05:34:34 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:55840 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbZE1Jed (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 05:34:33 -0400
Received: by fxm12 with SMTP id 12so3546946fxm.37
        for <git@vger.kernel.org>; Thu, 28 May 2009 02:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=u6LsGaWUK0DSSn6DtgtxS+MgL4XqrdkuNb7Ej3b6jYk=;
        b=xL3i8HUroFbplEQn/1DbxwYUY0lmnrEnhIc4rdpCwR76dgrfwmqtw76gIyNRHukIUE
         UgAiSuvBhDTxj2priUwgQ9AswbHdUOkg4vq1JfjXp51rx63psXFx5z9wYXi0yoea4i8x
         UkIr7LSXyayBAQWzNR1JavEDD9lK9f05TyeIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=V4kAPtvtz+EaxSYfnfPAaJwcpIokneW+ep9TNxY/+/ah1lpJSs500rVj4ZcE6HKTxz
         gTSHPDWZMpUolNyV+W2+ti3WQpJIA8Yrl4eimmpNu1TxrbnPU2gbZQ3fqgO0bdLKmxsQ
         a5Tm1BcKeJaHTl/HgX1bBpA8rDD9yiCMelZaI=
Received: by 10.223.126.203 with SMTP id d11mr1026881fas.8.1243503274000; Thu, 
	28 May 2009 02:34:34 -0700 (PDT)
In-Reply-To: <4A1E4B82.9040809@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120176>

On Thu, May 28, 2009 at 10:29 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Yes, but your shell seems to find git-diff somewhere, so what about:
>
> type --all git-diff
> echo $PATH

$ type --all git-diff
bash: type: git-diff: not found
$ echo $PATH
/home/martin/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

there is _no other_ git-diff. It's bash magic. See
http://popey.com/command_not_found

Note that all the key commands work. I clone, diff, commit, push,
merge daily on this machine.

> OTOH: The git-pack-objects usage line indicates that you clearly have
> older plumbing lying around. I suspect there are at least 2 issues on
> that box.

Might be. Maybe ~/bin got cleaned up but not libexec? Or the bisecting
back-and-forth left stray bits in ~/bin?

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff

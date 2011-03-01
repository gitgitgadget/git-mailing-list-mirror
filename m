From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git-grep to operate across who repository and not just CWD?
Date: Tue, 1 Mar 2011 16:32:24 +0700
Message-ID: <AANLkTik1_f7s0OUK9Q-BER9RkOdWiB=ZeN76HnCgmj+3@mail.gmail.com>
References: <AANLkTimnOSzF1o-fX-n7b26Qx2aLP3aU3pTMGY_f5hKy@mail.gmail.com>
 <4D6B6A8B.20709@drmicha.warpmail.net> <4D6C20F6.3070905@cisco.com>
 <4D6CA8B7.5000608@drmicha.warpmail.net> <AANLkTim78nQgS7NPXWErQyrqmt41OUXY6gzJmMwjtxo9@mail.gmail.com>
 <4D6CB45F.1030800@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <hordp@cisco.com>,
	David Chanters <david.chanters@googlemail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 10:33:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuLx0-0001bJ-2E
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 10:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756042Ab1CAJc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 04:32:56 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49314 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721Ab1CAJcz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 04:32:55 -0500
Received: by wwb22 with SMTP id 22so4204559wwb.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 01:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=THPD/bEaegkFBCxRqKotmNY7JBhcqk/gDx/+ulsXJsw=;
        b=AH5jh2E4PRVknKIxLEB61GNExtvwcK0ZRxO7NzVL5nG2Kao7b53i1YDYArKPbL69ub
         UtAsUXlkMaNVs7grAp2JzFdaEQZgSO//RY3DNTYlsSun+WYWeQ+HwD2rdWxjUhe4zIhn
         5VsCwHfUZtjMhmq/ceYxpR64RoaHVa3W1s+7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=lNr+R+gl7MsGFBVXUKdquZLtirDeoCHAKRvCXwcC/fzgPg/9pqA1hDiAtkSx2yOmYb
         QTGmbWytLDkx94qN0I/e3Pnn1NBckJuWCVHVapSW1QEDxaLWeyyvectOV9Mkw5tuRlTV
         TccZ5K3rQULx1lpOOs02FKsT1E/QuyHhF4kYU=
Received: by 10.216.186.144 with SMTP id w16mr5809941wem.13.1298971974106;
 Tue, 01 Mar 2011 01:32:54 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Tue, 1 Mar 2011 01:32:24 -0800 (PST)
In-Reply-To: <4D6CB45F.1030800@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168202>

On Tue, Mar 1, 2011 at 3:54 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>> If I remember correctly, it was dropped because of the interaction
>> with pathspecs (relative to cwd vs to worktree's root). I'd be great
>> if someone can pick it up and finish it.
>
> Rereading that thread, I don't think there was any objection against
> "--full-tree", but it suffered from DTD (discussed-to-death). To make it
> really usefull, one would need a short-cut/option/whatever, and that's
> where the discussion went astray. I have an idea, though :)

No it was in next or pu for a while, then got dropped out. I don't
remember what "what's cooking" mail though.
-- 
Duy

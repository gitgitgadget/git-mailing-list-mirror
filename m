From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: non-monotonic index error
Date: Tue, 2 Sep 2008 17:01:38 -0400
Message-ID: <9e4733910809021401s217706d0h7a313bbd66670ad9@mail.gmail.com>
References: <9e4733910809021257v3012ec89l64b2bb412ac1ebbd@mail.gmail.com>
	 <7vbpz6jmmf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Catalin Marinas" <catalin.marinas@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 23:02:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kad1S-0005un-JT
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 23:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbYIBVBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 17:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbYIBVBk
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 17:01:40 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:53691 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbYIBVBj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 17:01:39 -0400
Received: by py-out-1112.google.com with SMTP id p76so1339876pyb.10
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 14:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=jW9qbbWgKBbRoJXMeOjfZg9dYHVAgIQN7IwyGE+huJk=;
        b=D9GChKc+FTaVtYJxupKIzI04jgpDQpVV2gMj2RSPhLVpdosGsGv0x3KTSAvlrOepXW
         Q+VCcRCQTY7UgeObS5ZTJ0/IKJB095qVwwoFdagJkMtXXK1JanUT04K0QVk+GFBFB7E0
         0GVajyVbQDamwzogMgl4YsGfksbiUti/W2coU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qejus5ybx/PJiAA87BZppJvvB87yf3brwtXrNePLL+bqIXNfvgVp1b1NVWGCDiNUwp
         JBRYwJL3jbX7bgpRIb02KoPAASkrymFl7vhoWtGgW2A6iuORrfteCOZx5Qwh3JDlqxoC
         gWEsvsf5kynknQJv2ypjgbCdSCqXpW5gEgnEs=
Received: by 10.65.215.14 with SMTP id s14mr16422214qbq.18.1220389298212;
        Tue, 02 Sep 2008 14:01:38 -0700 (PDT)
Received: by 10.64.178.13 with HTTP; Tue, 2 Sep 2008 14:01:38 -0700 (PDT)
In-Reply-To: <7vbpz6jmmf.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94713>

On 9/2/08, Junio C Hamano <gitster@pobox.com> wrote:
> "Jon Smirl" <jonsmirl@gmail.com> writes:
>
>  > I pulled from linus, did stg rebase linus/master, git push digispeaker
>  > and got these errors.
>  >
>  > Where's the problem, at my local machine or the digispeaker one? How
>  > do I fix this?
>  >
>  > jonsmirl@terra:~/fs$ stg --version
>  > Stacked GIT 0.14.3.195.g36a0
>  > git version 1.5.6.GIT
>  > Python version 2.5.2 (r252:60911, Jul 31 2008, 17:31:22)
>  > [GCC 4.2.3 (Ubuntu 4.2.3-2ubuntu7)]
>  > jonsmirl@terra:~/fs$
>  >
>  > [digispeaker]$ git --version
>  > git version 1.4.4.4
>
>
> It is a bit fishy that stg reports 1.5.6.GIT; does it come with its own
>  copy of git which is newer than what you have?
>

Two different machines - terra and digispeaker



-- 
Jon Smirl
jonsmirl@gmail.com

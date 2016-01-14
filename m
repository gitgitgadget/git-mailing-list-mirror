From: pedro rijo <pedrorijo91@gmail.com>
Subject: Re: Find main branch
Date: Thu, 14 Jan 2016 18:40:15 +0000
Message-ID: <CAPMsMoBNzmK618NPP-VXP_70hTxTsa13O9f_usiCPJ-SUOUz_g@mail.gmail.com>
References: <CAPMsMoDsay7_n53HY6cxHWEtv5vyugxYUZqwi9tU4dKLv6MGBg@mail.gmail.com>
 <20160114213113.c700484c7e3acddc467d0e75@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Jan 14 19:41:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJmpQ-0004eN-3p
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 19:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756766AbcANSk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 13:40:56 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33254 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbcANSk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 13:40:56 -0500
Received: by mail-lb0-f176.google.com with SMTP id x4so45997373lbm.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 10:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:cc
         :content-type;
        bh=taKdCIwoS7At2IFgs2czGtWXAilBNc6kvt3PVy/bHfA=;
        b=neQDBhFyaQZZVfgu6Qwp0sARzHtx+Oy/axI697fLuPC/+xZpraRnFJdAVuDIsJdsTP
         XKZdyNqiQOOdm1eqDZyA3UunaLFoby7DtdQL0aZEP1XCR3vfIXl2UHrPCq7AivPX4+B+
         JLkOQL9xS6tOLQtRB2g34whaDVusWUG01pnJo444sj5klb3KpCshDT3YjJkXpOECMrUS
         BMcytNACWC6STAer9PHT59U+1NKKV4ovfs19ex1WCKw9aOD8RWje8h4dSUqkBbdoA21h
         B02AWwuWvF3uQAciYixDNezc0dxn3Q5jS+yAZgbCQZQ25xZDIMoSgWnKaFRK3+p8pllY
         u4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:cc:content-type;
        bh=taKdCIwoS7At2IFgs2czGtWXAilBNc6kvt3PVy/bHfA=;
        b=D8wUmLeQ/nYT6BiwoDRK4qZ6t524O7FQc45fAFBeY/wuhBPWQLZb2BRwSYfUcLdo66
         /s/uJbG3PDOXlhX2ogG6PXBqdmbB1f45SzvDDR8XoOTUDIZxdIu8W5vUiDM41FG/eB5C
         J5aZWvIq4DE1Aao+u0o1JmWEX+mBihbWqDRKkUfVploBPxQXjqcTCd36Qaf19FVdDbh5
         fs7HPQRRxM2UntuLySX3b6gQse1aL/N3Ayutveew93dG2cZh7X4Okq7i7k7jBIYfP05K
         z8p5k6HZBO3M2J9Y69j15I2/b9ujIs3cWC/JEas+m+58/oGz6htqF6Q8Bet5VXBe/iDb
         3luQ==
X-Gm-Message-State: ALoCoQkcT5DOFLNM8sxww35QXMiFUcev/evKrog2Dv0m1KyqU7ZeiRuNQ8Ii6sNbKGYx3kjApGgKoAwkWP3KneBNWMb/wCnP2A==
X-Received: by 10.112.142.101 with SMTP id rv5mr1485933lbb.101.1452796854598;
 Thu, 14 Jan 2016 10:40:54 -0800 (PST)
Received: by 10.112.167.2 with HTTP; Thu, 14 Jan 2016 10:40:15 -0800 (PST)
In-Reply-To: <20160114213113.c700484c7e3acddc467d0e75@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284079>

Stefan Beller solution is based on the server, which may not be very
easy to do when dealing with Github/Bitbucket/Gitlab and other God
knows which provider.

Konstantin ls-remote solution is the one I'm already using, but if I
have several branches on that commit, I will not be able to decide.

I thought that the 'main' branch information was stored in git, and
possibly with some way to access it with a git command

Thanks,
Pedro Rijo

2016-01-14 18:31 GMT+00:00 Konstantin Khomoutov <kostix+git@007spb.ru>:
> On Thu, 14 Jan 2016 18:17:48 +0000
> pedro rijo <pedrorijo91@gmail.com> wrote:
>
>> If I clone a repo, the repo will be on a specific branch, the 'main'
>> (typically 'master') branch.
>
> `git clone` checks out the branch which is pointed by by the HEAD ref in
> the source repository.
>
>> Is there any direct command to find that main branch, since that
>> information is present?
>>
>> If so, is there any way to find it without actually cloning the repo
>> (similar to git ls-remote)?
>
> Run `git ls-remote <url>` and, record the SHA1 name of the HEAD ref,
> then look that name up in the list of the remaining refs.



-- 
Obrigado,

Pedro Rijo

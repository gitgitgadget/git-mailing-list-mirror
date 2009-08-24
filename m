From: Adam Brewster <adambrewster@gmail.com>
Subject: Re: bundles with multiple branches
Date: Mon, 24 Aug 2009 17:42:21 -0400
Message-ID: <c376da900908241442t385d492cm6925fd2d8abad848@mail.gmail.com>
References: <30e395780908231336p403c2171ie383a81c3d1bb020@mail.gmail.com>
	 <c376da900908231352o5c5746c0h9e39b80adede66e8@mail.gmail.com>
	 <30e395780908231404k7240dbacu5c258d9816e35dd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeffrey Ratcliffe <jeffrey.ratcliffe@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 23:42:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfhJ9-0002q1-Cs
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 23:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbZHXVmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 17:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753184AbZHXVmV
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 17:42:21 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:41347 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbZHXVmV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 17:42:21 -0400
Received: by ewy3 with SMTP id 3so2807565ewy.18
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 14:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mvxRR6HGhQUWDc1weIfBLmfL5DxtMzs1XH0ctp7Y7UE=;
        b=DzZd7P//+BpuNknm+n6D1VE22bbiF9+g2bpofP5DAPc4b5DHlZTJ76debxuhqzTjVX
         qaWBrF2W267dqd7S7xXDkfZLxDHAXJFhsPjNkrliTpEG+k34+w8aB4lgPFPpg1NHjV8N
         zu2bzH6c1Rbvwv9YKrkmxR7dv9OZlwQfN77gU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=baHpnJDRhm24nPp+5stceFkk+LJJOIwnh8SWpGy2HwM/leIQ6+IoZqf9GIGmbRQ3c/
         0aeRpAmdsewhJa0sjHkgMwVyHgsNSstMiAvwwJIzdAmYFmyl1tvpgHxm7uHUcOCJW4wV
         vPIA24euBRQAkGJGCTlEexcIQ1Okjgtc+YlnA=
Received: by 10.216.89.16 with SMTP id b16mr1102529wef.57.1251150141984; Mon, 
	24 Aug 2009 14:42:21 -0700 (PDT)
In-Reply-To: <30e395780908231404k7240dbacu5c258d9816e35dd7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126971>

>
> 2009/8/23 Adam Brewster <adambrewster@gmail.com>:
>> git remote add bundle /media/cdrom
>> git config --replace-all remotes.bundle.fetch refs/heads/*:refs/remotes/bundle/*
>> git config --add remotes.bundle.fetch refs/remotes/*:refs/remotes/*
>
> On
>
> $ git pull bundle
>
> or
>
> $ git fetch bundle
>
> I get
>
> fatal: '/media/cdrom': unable to chdir or not a git archive
> fatal: The remote end hung up unexpectedly
>

Sorry, that's supposed to be /media/cdrom/name-of-bundle

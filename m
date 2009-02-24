From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: git bisect goes wild?
Date: Tue, 24 Feb 2009 13:59:16 -0500
Message-ID: <eaa105840902241059y70143c43s7d12b10fe35127e6@mail.gmail.com>
References: <20090224184414.GE22108@duck.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jan Kara <jack@suse.cz>
X-From: git-owner@vger.kernel.org Tue Feb 24 20:02:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc2XI-0006uc-FX
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 20:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbZBXS7U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 13:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbZBXS7T
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 13:59:19 -0500
Received: from el-out-1112.google.com ([209.85.162.183]:52603 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbZBXS7S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 13:59:18 -0500
Received: by el-out-1112.google.com with SMTP id b25so1371592elf.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 10:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=nOQ1626klzBr05FKQD2U1HbphvQBfKrpyzURGo+xZWI=;
        b=kIzZofMyxu8WJy9sj/F1t6OrIrw8FYOyztlpmzjFtePAw3YisW4qaizRvgb7r/0VGy
         ErSZnE6dOvmSGEniz2k/XCK6+T/R7WemFuzc9ko6T/kQxUpZQBnZVnrpAK3LG7uiFtOW
         rj3QwUhrqT9sO6E7Hu4AZkxUHuHI526Pr+Y5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=IgKX7bim6BSoh3EIDfPPO+9hjins62FCpoY5+31AQrn4OGIUgm8fIthQk01OBYlI6S
         caBnNi9ekUaV33NWGZgS4FqycWzW21aaBbYvAsEM4XDDnLAVsgnneIorif6WgsaS1qUF
         POvdHUqij74tFCQythm8pV1KaRIrepa0e/6mE=
Received: by 10.220.74.81 with SMTP id t17mr1111511vcj.56.1235501956300; Tue, 
	24 Feb 2009 10:59:16 -0800 (PST)
In-Reply-To: <20090224184414.GE22108@duck.suse.cz>
X-Google-Sender-Auth: 32070d5fcf16745a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111328>

2009/2/24 Jan Kara:
> =A0Hi,
>
> =A0I've been bisecting some change in Linux kernel. The output of
> "git bisect log" is:
=2E..
> git-bisect bad 419217cb1d0266f62cbea6cdc6b1d1324350bc34
=2E..
> git-bisect good 3e9830dcabdeb3656855ec1b678b6bcf3b50261c
>
> =A0But after the last command, I was sent to commit
> 9ec76fbf7d6da3e98070a7059699d0ca019b0c9b which is far outside the win=
dow
> between the last good and bad commit.

How did you determine that this commit is outside the window?

When I run "gitk 3e9830..419217" it shows that commit, as does "git
log". 9ec76fb appears to be inside the window to me.

Peter Harris

From: Dan Keder <dan.keder@gmail.com>
Subject: git-rebranch
Date: Mon, 17 Jun 2013 16:41:31 +0200
Message-ID: <CADbqzOMmETOcozVK=XkneA6j0PfLaAwMMYE+3=DeKCErrR5uLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 17 16:41:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoacl-0000ai-T7
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 16:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130Ab3FQOld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 10:41:33 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:42811 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab3FQOlc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 10:41:32 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so2559582lab.15
        for <git@vger.kernel.org>; Mon, 17 Jun 2013 07:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Afs+i03pT9RPmyAU8mE+SM2BMoMXrQNVExNyNvW5pRw=;
        b=MHFDTpf8q0jnQcdkFo6r6rMiayM5ZcKWfsJeg8k8zMTQeKR14K6cmN5ctL4DDtNfVK
         jL3naCTS4H0QzHZ6QkcISw9tH/hTGgWFLxD0qnyhz4x2nzMMO4LLBGb2FvIBgkMLjjD5
         /zg8t7fCLfXoqUPrS2fiGXbQVQ8l1apu1RQksZwFtgcsTtHllY+HmCtN2v3V1cdRQmhd
         9y9S7M+NTuoK3KruRrlItsS+S7tslH26/GaAVCIlMYH67v+Jngqsm6n5Kg22T+Ou0XCY
         eDH3slp7oh5QnrjpSPu+yutR5OpLedksBaTUq17pMmCc7nvafGP4HNp9UVDq8ygXirm5
         lItw==
X-Received: by 10.112.210.166 with SMTP id mv6mr6478509lbc.51.1371480091171;
 Mon, 17 Jun 2013 07:41:31 -0700 (PDT)
Received: by 10.114.5.6 with HTTP; Mon, 17 Jun 2013 07:41:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228075>

Hello,

I made a small script for easier rebasing of development branches. It
is useful in case you are developing in multiple (private) branches
and you want to rebase your branches onto upstream often.

You can find it here:

https://github.com/dankeder/git-rebranch

How it works:

1. Define the branch layout in a config file ".gitrebranch"
2. Run "git rebranch"

For more information see the README file.

Let me know if you find it useful. Also, feel free to create a github
issue in case you encounter any bugs or problems.

Regards,
dan

--
\o/

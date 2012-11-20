From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2012, #06; Mon, 19)
Date: Tue, 20 Nov 2012 02:41:46 +0100
Message-ID: <CAMP44s3xW1qMzNmZm6-c0bXaREut6TDJoRBZ5mu=HWndSgYCyg@mail.gmail.com>
References: <7vpq39up0m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 02:42:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tacqf-0006rD-EC
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 02:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306Ab2KTBlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 20:41:47 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:43609 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab2KTBlr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 20:41:47 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5472831oag.19
        for <git@vger.kernel.org>; Mon, 19 Nov 2012 17:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GWqFjal2nO3p7tOrE4E8pigw176hp/qikTEw4kLylNU=;
        b=PgYm8QDn1Ct1jkjrQIAWHTexC2pHWTDdG9ZK2kwTVqRCVhNUN0xgynplOLXcBTWcT7
         +R86RoX1Tr2Tzz/baTEboIO0z8ubs8J01y23p2skb/38LqOnEEuEdLGXh3fzll7K1d4X
         zbXHiSif9dXhyuATPmG5oI+nDeQnt2jF+3vc70JTrKW3xlUPf6JOQvVUHtlbct4bQmJK
         n/w70gG0gtsshPjVwLfHrlYj+c+K9jINSXWhj05G/yhpmaFRWPGoBLz2ekPm2khd8u3t
         HIq4YG+5DnxbEcYqICopWJQ8Xu8jNV+O0JJMrzWmq3VSDnNGh007cfwPn86yJP43/EEX
         mOGg==
Received: by 10.60.31.241 with SMTP id d17mr11987749oei.107.1353375706459;
 Mon, 19 Nov 2012 17:41:46 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 19 Nov 2012 17:41:46 -0800 (PST)
In-Reply-To: <7vpq39up0m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210075>

On Tue, Nov 20, 2012 at 12:55 AM, Junio C Hamano <gitster@pobox.com> wrote:

> * fc/remote-testgit-feature-done (2012-10-29) 1 commit
>  - remote-testgit: properly check for errors

Pinging Sverre again.

I now think that we need a better solution with waitpid() to check the
status of the process, so that both import and export get proper error
checks. I found that out the hard way with a buggy remote helper.

I still think this patch is good regardless, but not so big of a
priority. I'm not going to purse it more, if it gets in, good, if not,
a waitpid() patch would take care of it.

Cheers.

-- 
Felipe Contreras

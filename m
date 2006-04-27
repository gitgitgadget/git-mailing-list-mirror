From: sean <seanlkml@sympatico.ca>
Subject: Re: how to trace the patch?
Date: Thu, 27 Apr 2006 06:57:28 -0400
Message-ID: <BAYC1-PASMTP029B6CB13A6C0BA3956E17AEBD0@CEZ.ICE>
References: <6d6a94c50604270306j44c280bdo283591f2f595f74e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 27 13:01:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZ4Fz-000520-3f
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 13:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWD0LB4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 07:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWD0LB4
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 07:01:56 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:21536 "EHLO
	BAYC1-PASMTP02.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S964898AbWD0LBz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 07:01:55 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP02.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 27 Apr 2006 04:01:54 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 7AEAB644C28;
	Thu, 27 Apr 2006 07:01:53 -0400 (EDT)
To: Aubrey <aubreylee@gmail.com>
Message-Id: <20060427065728.35a4ae51.seanlkml@sympatico.ca>
In-Reply-To: <6d6a94c50604270306j44c280bdo283591f2f595f74e@mail.gmail.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Apr 2006 11:01:55.0107 (UTC) FILETIME=[FEE0A730:01C669E9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 27 Apr 2006 18:06:09 +0800
Aubrey <aubreylee@gmail.com> wrote:

> When I update the kernel git tree a few days later, you know, there
> could be a lot of patches. Then I found one file changed, how can I
> know which patch the modification belong to?
> How can I find the patch?

Hi Aubrey,

$ git log -- <filename>

To see a list of commits that affected the file you're interested in.

$ git log -p -- <filename>

Will include a diff after each commit showing you how the file was
changed.  And if you want to see what other changes happened in each
commit that modified your file, add "--full-diff" to the command above.

Note that you can also replace the <filename> with a <directory> 
to see a list of commits that affected any file below that directory.

HTH,
Sean

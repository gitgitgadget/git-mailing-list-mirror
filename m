From: Thomas Schlichter <thomas.schlichter@web.de>
Subject: Re: git http-push and MKCOL error (22/409)
Date: Mon, 17 Aug 2009 07:34:38 +0200
Message-ID: <200908170734.38838.thomas.schlichter@web.de>
References: <200908161557.26962.thomas.schlichter@web.de> <be6fef0d0908162152o54206acfge43f6ffa012bb307@mail.gmail.com> <200908170718.15423.thomas.schlichter@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sean Davis <sdavis2@mail.nih.gov>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 07:35:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McusS-0004iT-6Z
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 07:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbZHQFfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 01:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbZHQFfS
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 01:35:18 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:38190 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbZHQFfR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 01:35:17 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 2DFF4114C1997;
	Mon, 17 Aug 2009 07:34:40 +0200 (CEST)
Received: from [92.207.103.184] (helo=netbook.localnet)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1Mcurg-0005zs-00; Mon, 17 Aug 2009 07:34:40 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.28-14-generic; KDE/4.3.0; i686; ; )
In-Reply-To: <200908170718.15423.thomas.schlichter@web.de>
X-Sender: thomas.schlichter@web.de
X-Provags-ID: V01U2FsdGVkX1+tbT/ECzfxqzsAEIz2S8PElLBevHTG3Ywwv6xY
	EFFd5zd8C4bjY6z/W1an1/aZKPv0FhrfiOVDPbiVcW0evsTrt8
	1QyR7xORr4SWVU7e+Jxw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126120>

Hi,

Am Montag 17 August 2009 07:18:15 schrieb Thomas Schlichter:
> Hi,
>
> Am Montag 17 August 2009 06:52:32 schrieb Tay Ray Chuan:
> > I assume you want to commit dummy.c?
>
> Yes, indeed...
>
> > But you didn't tell git to track
> > it in the first place (git add dummy.c).
>
> I think that was not neccessary,  the parameter "-a" should do it for me...

OK, I tried it again, and the parameter "-a" was not sufficient. So I 
obviously did run a "git add dummy.c". Sorry for missing that.

Now I do also have the error message for the first commit:

schlicht@netbook:~/dummy2$ git push origin master
Fetching remote heads...
  refs
  refs/heads
  refs/tags
  refs/heads
  refs/tags
updating 'refs/heads/master'
  from 0000000000000000000000000000000000000000
  to   60157fdfdca4693f703c744fed95e1b31743bb4e
    sending 3 objects
MKCOL e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 failed, aborting (22/409)
MKCOL 4aefccd66b8e2bfa58079910045c30bc792877dc failed, aborting (22/409)
MKCOL 60157fdfdca4693f703c744fed95e1b31743bb4e failed, aborting (22/409)
Updating remote server info
error: failed to push some refs to 
'https://webdav.smartdrive.web.de/dummy2.git'

Kind regards,
Thomas Schlichter

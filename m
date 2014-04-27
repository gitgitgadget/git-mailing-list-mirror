From: James Denholm <nod.helm@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 08:31:30 +1000
Message-ID: <2c8517bf-baf8-46ae-b6f8-88d0a3106a74@email.android.com>
References: <535C47BF.2070805@game-point.net> <1748955386.11457068.1398588660139.JavaMail.zimbra@dewire.com> <535D3DF8.4020904@game-point.net> <53a594dd-cd3d-4b33-ada8-3d7e08b86ee2@email.android.com> <535D80EB.2090701@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 00:33:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeXdY-0005Sx-8S
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 00:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbaD0Wcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 18:32:50 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34633 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbaD0Wcu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 18:32:50 -0400
Received: by mail-pa0-f43.google.com with SMTP id rd3so3222681pab.16
        for <git@vger.kernel.org>; Sun, 27 Apr 2014 15:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=4PYbq8uwt+5H0dVqsFygS+nTT1c2xscZhquIv9p4GZI=;
        b=cK3vPP8529M1yn2mU5t1+1jt0U63LGEpTCCuDN/dFwyUca+/wMAtqONPsxe5xaX8it
         jbWQDsCcSPGqYkTsZmSP0tJN5dTVn0M14c+QHPCnSRMMX0H+jdDWAa9ICUIEnDER/dKd
         VWU0r2lyhe0QpQFMBWIoqZhAYwofMjiczxuk7M6XlwBCxGeUUUpzAyx+St8o9SIxwyzu
         LVm6+BbytoOj+mRhVPUqKrxD/hRC3Vpg7a3KpY1sCAnR8u9iKEpV7HGnSvpxG2v0yoD8
         Ow1PE4KsyInz6/SEBhw4M3qO4C5YeHTY5t8nCtNqbh0IHZkJJpijbkPHTjLSEW80xMu1
         kS2Q==
X-Received: by 10.66.122.36 with SMTP id lp4mr21690852pab.82.1398637969420;
        Sun, 27 Apr 2014 15:32:49 -0700 (PDT)
Received: from [10.68.103.100] ([101.119.27.95])
        by mx.google.com with ESMTPSA id ry8sm80009528pac.29.2014.04.27.15.32.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Apr 2014 15:32:48 -0700 (PDT)
User-Agent: Kaiten Mail
In-Reply-To: <535D80EB.2090701@game-point.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247230>

Jeremy Morton <admin@game-point.net> wrote:
>On 27/04/2014 22:40, James Denholm wrote:
>>> Also, you don't always have something you can link a commit to in an
>>> issue tracker.  You may just be implementing a feature that has been
>>> agreed upon, independently of any such tracker.  In that case,
>there's
>>> no bug# to link to.
>>
>> In which case, refer to whatever system you use. If you aren't
>> using a ticketing system, have the line "Relates-to: Water
>> cooler conversation with Bob on July 28th" or whatever the
>> patches relate to.
>>
>> (Arguably, though, the better solution is to use a ticketing
>> system, or anything that allows discussion to be easily
>> referenced.)
>
>Well, as I said elsewhere in this discussion, Git should provide that 
>functionality built-in, IMHO.  It would be good to be able to set a 
>one-liner in my .gitconfig to tag each commit with a "branch checked 
>into" trailer.

In that case, write something onto your post-commit hook and the
functionality would be achieved. A relates-to line doesn't need a
change to the structure of git commits.

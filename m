From: Alex Blewitt <alex.blewitt@gmail.com>
Subject: Re: [PATCH 2/2] Use NullProgressMonitor.INSTANCE and indent for loop
Date: Wed, 6 May 2009 21:50:57 +0100
Message-ID: <46FFA889-7EFA-4CF2-9493-81DF5A319B6C@gmail.com>
References: <1241642224-6914-1-git-send-email-alex.blewitt@gmail.com> <1241642224-6914-2-git-send-email-alex.blewitt@gmail.com> <20090506204849.GM30527@spearce.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 06 22:51:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1o5H-0003Su-PR
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 22:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759531AbZEFUvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 16:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759383AbZEFUvD
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 16:51:03 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:35866 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759278AbZEFUvA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 16:51:00 -0400
Received: by ey-out-2122.google.com with SMTP id 9so152509eyd.37
        for <git@vger.kernel.org>; Wed, 06 May 2009 13:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=bmmvXfkF3oz8dnbxWcEQYFdq53PFm9vcqXD5WqJb6Ow=;
        b=HXKWJL1Nb0dfFoectFGiVEGOIMkGbAMnLJiEx00xqf7YUP/bYAL2IWgaPKCCr9DrAa
         oQuFcfb2HQUU7iEaZc4mbk8jE/TUAktk3ed87/VY0BjRAtzdaKjBTnCDK3n3KXSDT+LF
         zxxZvRPvwnV1gUEaXeFexRO272kD2gkcj9Zaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=Ljq9Jifo9YqASJDZcxy0jZcqtdw0Rd196UUvIw3qP5gxC9dWF7p0sNcxe7HoTVtKA7
         EFcOzjcdHjvHAJPZoxwWneqEiRLa5m6NY9cbtrcw9vBMzKp+EXWJZt9kZrnovir/q1R9
         M1Sc/ia99hA4/TYOnDhy+ppjeHL9iNj1nimiA=
Received: by 10.211.180.10 with SMTP id h10mr4428228ebp.2.1241643060153;
        Wed, 06 May 2009 13:51:00 -0700 (PDT)
Received: from apple.int.bandlem.com (server.bandlem.com [217.155.97.60])
        by mx.google.com with ESMTPS id 7sm2313748eyg.37.2009.05.06.13.50.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 May 2009 13:50:59 -0700 (PDT)
In-Reply-To: <20090506204849.GM30527@spearce.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118388>

I've been using git send-email --format-patch, which doesn't appear to  
add the signed by line. If I do it as the commit, will it add the  
signed-by when it gets committed, and thus I can use send-email? git  
format-patch just seems to dump a load of files into the directory,  
and (as noted elsewhere) the git-rebase doesn't appear to work for me.

Alex

On 6 May 2009, at 21:48, Shawn O. Pearce wrote:

> Alex Blewitt <alex.blewitt@gmail.com> wrote:
>> ---
>> .../src/org/spearce/jgit/lib/PackWriter.java       |   25 +++++++++ 
>> +---------
>> 1 files changed, 13 insertions(+), 12 deletions(-)
>
> Also, I'd like a Signed-off-by line for your patches.  We follow
> Linux kernel tradition and use a Signed-off-by line to mean
> you agree to the "Developer's Certificate of Origin 1.1" (see
> SUBMITTING_PATCHES in the top level directory, part 5).
>
> For the 2 that you've submitted thus far (this one, and the make
> private constructor) you can just reply to the email and drop the
> SOB line into the message body.  In the future make sure you add
> it in with git commit -s or git format-patch -s prior to sending.
>
> -- 
> Shawn.

From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [EGIT PATCH 21/20] Make isBetterDeltaReuseLoader() static in
 PackWriter
Date: Thu, 19 Jun 2008 18:26:59 +0200
Message-ID: <485A88D3.9020901@gmail.com>
References: <1213566349-25395-20-git-send-email-marek.zawirski@gmail.com> <1213738134-6221-1-git-send-email-marek.zawirski@gmail.com> <200806180007.01061.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 18:30:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9N1J-0006nA-EC
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 18:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586AbYFSQ2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 12:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbYFSQ2N
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 12:28:13 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:63844 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757837AbYFSQ2B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 12:28:01 -0400
Received: by wr-out-0506.google.com with SMTP id 69so611643wri.5
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=umt1T84rI99lE2ypCiEaOiWj0CBnbt9sBibSxcUfsW0=;
        b=syYNnbHVjhN0OqYcIiE3mhqNAIyBPUCqcvoMcIh0bkLihO7SrkkQiXvzCoXuNtHiC1
         3wMz1aOB28E6DfyBypBd278l7NRIFt4RkdAWjFUtZwItHQViLfyYSJFpuAbwU+Y613XX
         FaykVDyozuOF2zr4pnV1uH/hqTiggGeEJaRhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=opZJfz4GBzSBBq3GMbElIG5hg7BbaPWB9ULzUgNYqG1tRziZy3Li9O+zbO+jkeY8Ca
         F690/80jPOsGw4ImlgHO+gRw+Tir9mUNi2bWE6CnQ/oJtPlawJrQkt4bMTuZ7Hn27zU5
         VrJ7q1rwfJ9NovaNYBnwBfnspDSfJeW6J7lAw=
Received: by 10.90.50.5 with SMTP id x5mr2857030agx.31.1213892879975;
        Thu, 19 Jun 2008 09:27:59 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id 25sm9932qbw.1.2008.06.19.09.27.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Jun 2008 09:27:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.13) Gecko/20080313 Iceape/1.1.9 (Debian-1.1.9-5)
In-Reply-To: <200806180007.01061.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85489>

Robin Rosenberg wrote:
> tisdagen den 17 juni 2008 23.28.54 skrev Marek Zawirski:
>> Implementation was already static, it's just a fix for clarity and
>> potential speed-up.
>>
>> Reported-by: Shawn O. Pearce <spearce@spearce.org>
>> Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
>> ---
>> It could be squashed with patch 19/20. I can clean up this mess, adding 
>> also Shawn's patch - just let me know what is preferred way (squash
>> commits, commits on top?).
> 
> If the code is already merged then patch on top, else squashing or rebase,
> unless you feel there is a reason not to. We can pretend it was right from
> the start :)  

So let's pretend that...
I have squashed these 2 additional patches (Shawn's improvement for 
reverse index and my minor fix) into appropriate commits. "packwriter" 
branch was updated (non fast-forward):
http://repo.or.cz/w/egit/zawir.git?a=shortlog;h=refs/heads/packwriter

 > I see no educational value in having a separate patch in this case.

The only educational value was to type Reported-by on my own ;)


-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com

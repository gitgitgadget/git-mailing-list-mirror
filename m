From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: What's cooking in git.git (Dec 2013, #05; Thu, 26)
Date: Thu, 2 Jan 2014 15:47:21 -0500
Message-ID: <CAPig+cQ79qbEDai69T7pwvdTRk9rHBE5aSAKMZuOtwCw5qKPzQ@mail.gmail.com>
References: <xmqq1u0zcoci.fsf@gitster.dls.corp.google.com>
	<CAPig+cQXsdFocFeSR8YKh8crOwBFP0ZK0td2UbP-yypRYJhREQ@mail.gmail.com>
	<7vmwjmj628.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 02 21:47:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VypAw-0003v6-B4
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jan 2014 21:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbaABUrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jan 2014 15:47:24 -0500
Received: from mail-la0-f53.google.com ([209.85.215.53]:64746 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbaABUrW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jan 2014 15:47:22 -0500
Received: by mail-la0-f53.google.com with SMTP id mc6so7511600lab.26
        for <git@vger.kernel.org>; Thu, 02 Jan 2014 12:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+f/WHO5EvCHMfY84fCdzgtg942VkfyGc4vfW6dTS8hg=;
        b=mtIgCJDVhVYmgg5Xl4c6HJjpJvbuBXeIfZ33EwxxIua2V1u+UhzEmwx8BgDdHfkn/G
         9JY2Si5Jpyu70ZtmlgfUfYLmd/l29dUSRotzObXrk3bStjG2sF/3jxNIo7WlltkMhvk1
         zaI7IufLOhUUKMpro1B+rPXK5hMxAR1+3L1lD2vLBI2YTI0MXmzmoJ+mLR+y4NJL9w+Q
         M9kMrB3QdO+Eze41IU5IOGajdKRxkzmrvLQYFuynpChdCgz9Eyrc16WSWHXMas3u850z
         MmZ0n19mFhsizMonzTIM97iQnBXOSkrnPU1cSzZSNPFYTSeWDRa+AiEKuJ6FE4DzR26b
         KAtw==
X-Received: by 10.152.1.100 with SMTP id 4mr23812lal.90.1388695641223; Thu, 02
 Jan 2014 12:47:21 -0800 (PST)
Received: by 10.114.175.130 with HTTP; Thu, 2 Jan 2014 12:47:21 -0800 (PST)
In-Reply-To: <7vmwjmj628.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: hvYsfftb90-QDonFE0dKoDm2Sv4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239876>

On Fri, Dec 27, 2013 at 5:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Thu, Dec 26, 2013 at 4:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> [New Topics]
>>
>> Would $gmane/239575 [1] be of interest for "New Topics"?
>>
>> [1]: http://article.gmane.org/gmane.comp.version-control.git/239575/
>
> Actually I was planning to scoop it up directly to master but forgot
> to do so.

Make sense.

> Running "git diff maint pu -- name-hash.c" shows that we have added
> a comment that mentions index_name_exists---that needs to be
> adjusted, too, by the way.

Oops, yes, I had noticed that too when testing atop 'pu' but then
forgot about it when preparing the patch for submission on 'master'.

I'm not sure how to move forward with this now that kb/fast-hashmap,
with which it has a textual conflict, has graduated to 'next'. Should
this become a two-patch series with one for scooping directly to
'master' and one for 'next' to sit atop kb/fast-hashmap? (But how will
the textual conflict be handled?)

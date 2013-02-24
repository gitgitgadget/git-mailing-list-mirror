From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 00/16] use a lowercase "usage:" string
Date: Sun, 24 Feb 2013 14:32:53 -0800
Message-ID: <CAJDDKr4+n3HgfWr-_eXSCOqUD1GpBVsU_2p5CfHj6kGs0OajYw@mail.gmail.com>
References: <1361667024-49776-1-git-send-email-davvid@gmail.com>
	<7vobf94c95.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 23:33:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9k8G-0007Aa-KK
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 23:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759500Ab3BXWcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 17:32:55 -0500
Received: from mail-wg0-f48.google.com ([74.125.82.48]:42210 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759494Ab3BXWcz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 17:32:55 -0500
Received: by mail-wg0-f48.google.com with SMTP id 16so1897555wgi.15
        for <git@vger.kernel.org>; Sun, 24 Feb 2013 14:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=mVabIVK65mgFo+mAK/w9PVFoFVcnr6AMBLCTDeFbzqg=;
        b=apsJwsuwRs3M8TK33lR+3veRsAp8JPwrkc6LQO1DhC9cXwQumSbSCNo7crGxK/+/CL
         ZN7i3u5Hpd7b/pCcNqPsTblDDBrXrvo2j7AD8+FjkLJ1a/XziREYugJexUSJ1CM5Z1Yt
         w1aARvo9jJEzxHViJqTw/ZaEhaaoeFTdDpFVpaF+ek/U6gLUylvdLZ0RboebaMM+QCbn
         g0wxMRJ0zqLT9dksq6c2Q4rqeBPgC6bA1qreUX6/3pALbKu5kdh5I+J5Pwomb8rWP/1k
         oZIoDS8LqIQ8greMPcsGB7JqotvXfLNc36Ne9LiX0OCi9lB1u4RyZlL5U7Dmx7aMa1He
         5TDw==
X-Received: by 10.180.83.227 with SMTP id t3mr8576522wiy.2.1361745173900; Sun,
 24 Feb 2013 14:32:53 -0800 (PST)
Received: by 10.194.13.129 with HTTP; Sun, 24 Feb 2013 14:32:53 -0800 (PST)
In-Reply-To: <7vobf94c95.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217013>

On Sun, Feb 24, 2013 at 1:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks.
>
> After applying these patches, "git grep '^[^#]*Usage:'" still shows
> a handful more hits, such as contrib/examples/git-remote.perl that
> are touched by this series.

Thanks, I'll take a look at these.

I stayed away from tests and comments in the first round so that
we could catch the user-facing strings.  That seems to have settled
in well so I can make another pass and catch these last remaining
stragglers.
-- 
David

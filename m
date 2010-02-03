From: John Tapsell <johnflux@gmail.com>
Subject: Re: faceted search interface
Date: Wed, 3 Feb 2010 15:47:43 +0000
Message-ID: <43d8ce651002030747g324a94bfy30d7abf265f93d32@mail.gmail.com>
References: <E1NceXz-0003VA-QG@mail.chiefmall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Alex Ksikes <alex.ksikes@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 16:48:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NchSM-0004fY-Ka
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 16:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757347Ab0BCPrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 10:47:47 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:53039 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756809Ab0BCPrp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 10:47:45 -0500
Received: by pxi12 with SMTP id 12so1595279pxi.33
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 07:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=4F2bigLa+99q4/PjIDom/1N/9AmTobPSHEbDEBim9NI=;
        b=h3nK9Y0bpRI3Y2H7rl8w5rPKw2E57pblmNpT/2bamJpUUvwHgbgWtT5/AYEeTQrjx0
         bcDk/4ZriVv5GQUXpgOAmHEfyTjWQB6EBKrJPWRfNCVdBtVkU4xGfTblG7QUzHYE54Y/
         4NMvM70ygvEQqfwcdlWD131RwPBdadkk3DFS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=UkQBo7u/TigD89cwPOgKzhoiNTyUj1y5dngs+Nhd1WMWVM2KXkY9m3Pt417+DpVH42
         0HDUhS3A5GWxj5T19br2Yi2eTU5RWdLMoZ4Ibt78qe66Jc/w2oRU08AnkHjIrolu5g0+
         9jA58cniut/w3tbWtU2LHTJB626XQy8jplXL4=
Received: by 10.115.87.4 with SMTP id p4mr5102746wal.202.1265212063396; Wed, 
	03 Feb 2010 07:47:43 -0800 (PST)
In-Reply-To: <E1NceXz-0003VA-QG@mail.chiefmall.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138840>

On 3 February 2010 12:41, Alex Ksikes <alex@chiefmall.com> wrote:
> Hi all,
>
> I have just put together a system to automatically build a faceted search interface and search engine from any data. Would you mind having a look at it and letting me know what you think of it?

I get vertical scrollbars for the search box.  This can be reproduced
by zooming in/out.

I think the "Powered by Cloud mining" box should be removed.

Remove "Select / remove query terms:"  - it's obvious what to do with
the big X button.  Make the red "Brad Pitt [X]" thinner - reduce the
whitespace.

Remove (Time to generate facets: 0.0 sec.).

Remove "Torrent search".  People who want to get it illegally can
search by themselves, and you do not want to be prompting illegal
behaviour.

Make the search box less thick.  You need to do this because the site
is so visually heavy, but work on cleaning up the rest of the site
instead.

I like the "Refine by GENRE" etc boxes, but it's extremely visually
noisy.  Different size fonts, no layout, different colors, etc.  I'm
not sure what to suggest - maybe making them expandable boxes that
collapsed by default.

Work on reducing the information shown for each movie.  The key is to
reduce visual noise as much as possible.  I like how you have a [+]
box to hide some information.  Can you do this more though?

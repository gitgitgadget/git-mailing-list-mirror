From: David Michael Barr <b@rr-dav.id.au>
Subject: Re: remote-testsvn: Hangs at revision
Date: Thu, 6 Dec 2012 00:28:08 +1100
Message-ID: <D435D46EAB6F419CA0608075751C351C@rr-dav.id.au>
References: <CALkWK0meveeKQe81hHyojPX0GH_WRrv7ob9-NA1Q7-TuKso+1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 14:28:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgF1c-0003Ja-Iz
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 14:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253Ab2LEN2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 08:28:17 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:40972 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462Ab2LEN2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 08:28:16 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so3581959pad.19
        for <git@vger.kernel.org>; Wed, 05 Dec 2012 05:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject:x-mailer
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:x-gm-message-state;
        bh=hVs369UIZk9k12QVFanCzoXWxwbjCHHqQpoShRP/dVA=;
        b=Nch7Nk2aAHzwXJFhtHMXjULNB2UJ4JueE/e5tqibgQ54LERpCgU96KGF/BsbCN3C2A
         cYMxdz72s+15y9UXSDU0CDY5vkTMaaVRXX6sVEpko5YdtSGbdTH8uIFjqCxeIOrSw2Gj
         7akDBSCaxV0JjGPuV6lN7To/Bkh66THPK+RMyGAdkaJHA+tUh6mYha0KsxrQ1omhCpaj
         XEIm/RD6Kv1PaKFnScwyfJX8exA4+cR5G/AY7mQCjYAqMuC1cfWPEO5gSXt1/GKiIgHM
         7afAIkcFRYLsQtaMFLJuGShcgM+JiK/yHLHdjwNU8KGhd0uSA4zY3ZIoqq2rofNU9Kvn
         bz0g==
Received: by 10.66.82.68 with SMTP id g4mr45000110pay.9.1354714093762;
        Wed, 05 Dec 2012 05:28:13 -0800 (PST)
Received: from [192.168.0.12] (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id l5sm2744713paz.14.2012.12.05.05.28.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Dec 2012 05:28:13 -0800 (PST)
In-Reply-To: <CALkWK0meveeKQe81hHyojPX0GH_WRrv7ob9-NA1Q7-TuKso+1w@mail.gmail.com>
X-Mailer: sparrow 1.6.4 (build 1176)
Content-Disposition: inline
X-Gm-Message-State: ALoCoQnRF+1vYuWMez1WdQQf79FmOg5SAccN/zLLXpzGj2h4WFejcsB8w3xkX5ussH+0Nz8mrmg8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211124>

On Wednesday, 5 December 2012 at 5:20 PM, Ramkumar Ramachandra wrote:
> Hi,
> 
> I tried out the testsvn remote helper on a simple Subversion
> repository, but it seems to hang at Revision 8 indefinitely without
> any indication of progress. I'm currently digging in to see what went
> wrong. The repository I'm cloning is:
> 
> $ git clone testsvn::http://python-lastfm.googlecode.com/svn/trunk/
I attempted to clone the same repository and was able to fetch 152 revisions.
So the issue Ram saw might have been temporal.


I did however receive a warning at the end of the clone:

    warning: remote HEAD refers to nonexistent ref, unable to checkout. 

--
David Michael Barr

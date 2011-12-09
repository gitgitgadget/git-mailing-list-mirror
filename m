From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/9] t3510 (cherry-pick-sequencer): remove malformed
 sheet 2
Date: Fri, 9 Dec 2011 14:37:30 -0600
Message-ID: <20111209203729.GL20913@elie.hsd1.il.comcast.net>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
 <1323445326-24637-7-git-send-email-artagnon@gmail.com>
 <20111209202449.GI20913@elie.hsd1.il.comcast.net>
 <CALkWK0mEP5nDgdosOiquQ_FWbNRZesi38NeCD_yGPvJ8JQxkGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 21:37:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ7CO-0006FR-8y
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 21:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716Ab1LIUhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 15:37:35 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50463 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954Ab1LIUhe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 15:37:34 -0500
Received: by ghbz2 with SMTP id z2so2856870ghb.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 12:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Die/UNEBhv3dKGNxlOC1q7DiM/8BlWsuFfv2a9Efoh4=;
        b=ug1yCFYjXv2TqRVlkL3LPXr08qKESCbbLSGcE53cxbHeC7+M8D/fJpRtp2OdTzF6MN
         wcLwJ93X+hIW2SwEP8b5jtP1dma4RAH6QlfsL6nCW8stkvEWkAtFhmRyMVwpXyYsSvOD
         elBrVGzPqVi6/fiO2A6cWGc+Btr2S+LY8pfAc=
Received: by 10.236.176.2 with SMTP id a2mr14865458yhm.12.1323463053767;
        Fri, 09 Dec 2011 12:37:33 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id j25sm16833317yhm.12.2011.12.09.12.37.32
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 12:37:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0mEP5nDgdosOiquQ_FWbNRZesi38NeCD_yGPvJ8JQxkGg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186692>

Ramkumar Ramachandra wrote:

>                                                    I've noticed that
> the diffing algorithm performs especially badly for t/*.sh -- rebasing
> tests is generally a huge pain.

No clue about this particular situation, but I suspect the general
cause for such rebasing trouble is adding tests at the end of the file
(or some other contended place).  Better to figure out a logical place
for each test and put it there from the start.

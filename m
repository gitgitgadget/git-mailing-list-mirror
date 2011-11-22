From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/3] Re: cherry-pick/revert error messages
Date: Tue, 22 Nov 2011 05:27:00 -0600
Message-ID: <20111122112700.GH7399@elie.hsd1.il.comcast.net>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111122111207.GA7399@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 12:27:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSoVL-000602-Tr
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 12:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758345Ab1KVL1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 06:27:06 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49985 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637Ab1KVL1E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 06:27:04 -0500
Received: by iage36 with SMTP id e36so45939iag.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 03:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=64DmUyQwGItypsayAXM9g6fi5SZxU8EtoSwRBy72I7Y=;
        b=Op/bXX0j8TpTDfHysm/J2RmSpcofLSnHvuIfddmg73/U/2ujUckikzTh/GrDLnMszW
         VoV2uLe1N91/lsYcWwSlqK8hVNRfJ4MxyaFd/+ChoV4JvBG+Se3GtFl+2UJ3exqMPsok
         61YKbaZJm4nzHo5RGWAN5FHksNkf/r6nGtA8Q=
Received: by 10.231.29.103 with SMTP id p39mr4557587ibc.28.1321961224093;
        Tue, 22 Nov 2011 03:27:04 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id p16sm58839326ibk.6.2011.11.22.03.27.03
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Nov 2011 03:27:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111122111207.GA7399@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185789>

Errata:

Jonathan Nieder wrote:

> May the series can provide some amusement.

"Maybe".

[...]
> Jonathan Nieder (3):
>   revert: rename --reset option to --quit
>   revert: rearrange pick_revisions() for clarity
>   revert: improve error message for cherry-pick during cherry-pick

I took these from pu before tweaking them, so in a sense it's
appropriate that Junio's sign-off is there, but I do not mean to claim
he looked at and acked the tweaked form.  I should have just left my
sign-off.

Sorry for the noise.

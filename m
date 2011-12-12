From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] test-terminal: set output terminals to raw mode
Date: Mon, 12 Dec 2011 12:23:18 -0600
Message-ID: <20111212182318.GE31793@elie.hsd1.il.comcast.net>
References: <b97d14da67bd6097e5b04f6ae3057c0f1d536a0b.1323713230.git.trast@student.ethz.ch>
 <04a77f48dd5d5afebbe625ed25ebecd57b6a8840.1323713230.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Dec 12 19:23:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaAXC-0000lz-9F
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 19:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398Ab1LLSX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 13:23:27 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58427 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab1LLSXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 13:23:25 -0500
Received: by ghbf16 with SMTP id f16so23374ghb.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 10:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=knUHVZp9oCoQulSNg2Vzyud/KOqtv+D14k0xPxtDob8=;
        b=moBrYMAXdlhtGmfVJ3rhRs1eIjBjhoU3cQBCnTQF6f+HR2PiWLD2Phz3BztjtTt369
         l/gYvtgg0ruBQbnhR+4u9h61BlP+gZ1XumOGDxIO/hI+eOUy2kIj7cmGdhCRbZhwirtN
         QyR3FtQpEZYuiEHx4EXequGHmWGdPp1ewFN1g=
Received: by 10.236.186.2 with SMTP id v2mr28408236yhm.83.1323714205187;
        Mon, 12 Dec 2011 10:23:25 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id f7sm40840863and.17.2011.12.12.10.23.23
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Dec 2011 10:23:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <04a77f48dd5d5afebbe625ed25ebecd57b6a8840.1323713230.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186927>

Thomas Rast wrote:

> Not setting them to raw mode causes funny things to happen, such as
> \n -> \r\n translation:
[...]
> To avoid this, set the (pseudo)terminal to raw mode.  Note that the
> IO::Pty docs recommend doing it on both master and slave.

Good idea, so for what it's worth,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Does this change the behavior in
<https://rt.cpan.org/Ticket/Display.html?id=65692> (oh please oh
please)?

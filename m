From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCHv2 0/5] modernize test style
Date: Sat, 3 Mar 2012 09:42:06 -0800
Message-ID: <20120303174206.GM2572@tgrennan-laptop>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
 <1330740942-25130-1-git-send-email-tmgrennan@gmail.com>
 <7vpqcu6rfd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 18:42:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3syF-0006EJ-Iq
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 18:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569Ab2CCRmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 12:42:11 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:36996 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab2CCRmK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 12:42:10 -0500
Received: by dadp12 with SMTP id p12so3175186dad.11
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 09:42:10 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.68.224.230 as permitted sender) client-ip=10.68.224.230;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.68.224.230 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.68.224.230])
        by 10.68.224.230 with SMTP id rf6mr29641579pbc.48.1330796530204 (num_hops = 1);
        Sat, 03 Mar 2012 09:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=I1KM7pxS2SwHdPJPMyV91XprSiK77mmyiRROvJkGpfE=;
        b=QYUeWqLougHGXlDdwaD19TuAv3kt93Oax6NpIdOy+mct/1UVGURJ1aq+qV0imxwgPU
         +agr7sa4XOgDfISkFxtfg92kMTf6cOCfQ5Yf8zpgnfqg+rsi/VOq/Q67FCn6bL95rjNv
         X3BmzUu/9IiMhOLkL5Z2GnbWuRiqYMwaZnx+DbKTNSE0rrFSFxwnKZgbeVnouciSBQXH
         HVzJIEXrmju2HKATAfN/GnbeRScPw3QhoiqBdYdHY1VxNtLeesB8PwozA+Pl7Pp7xbNO
         oSPVAe8+pXAS9iqK1yT/xiB2HgSv5/VdnCsYOX3SuSk/LI7WDepx2Y/p8ybDigwYabmQ
         +bvQ==
Received: by 10.68.224.230 with SMTP id rf6mr25135032pbc.48.1330796530083;
        Sat, 03 Mar 2012 09:42:10 -0800 (PST)
Received: from localhost (c-69-181-129-72.hsd1.ca.comcast.net. [69.181.129.72])
        by mx.google.com with ESMTPS id e6sm8265885pbr.74.2012.03.03.09.42.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 09:42:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vpqcu6rfd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192119>

On Sat, Mar 03, 2012 at 12:04:54AM -0800, Junio C Hamano wrote:
>
>On the other hand, we can see that 5512 has been dormant for quite a
>while.  Note that the latter diff is against 3 cycles ago:
>
>$ git diff --stat v1.7.6..pu --  t/t{7004,5512,3200,0040,6300}-*.sh
> t/t0040-parse-options.sh |   79 +++++++++++++++-
> t/t3200-branch.sh        |  236 +++++++++++++++++++++++++++++++++++++++++-----
> t/t6300-for-each-ref.sh  |  101 +++++++++++++++++++-
> t/t7004-tag.sh           |  128 +++++++++++++++++++------
> 4 files changed, 490 insertions(+), 54 deletions(-)
>
>so 5512 and possibly 6300 may be worth reviewing.

Ack, I'll hold the others until each are quiescent for a few cycles.

Thanks.
TomG

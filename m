From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCH-w 101/105] t6300 (for-each-ref): modernize style
Date: Wed, 29 Feb 2012 21:57:41 -0800
Message-ID: <20120301055741.GF2572@tgrennan-laptop>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
 <1330566326-26075-7-git-send-email-tmgrennan@gmail.com>
 <7v62epqd9a.fsf@alter.siamese.dyndns.org>
 <20120301032053.GD2572@tgrennan-laptop>
 <7vty29ovcd.fsf@alter.siamese.dyndns.org>
 <20120301051010.GE2572@tgrennan-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Amos Waterland <apw@rossby.metr.ou.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 06:57:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2z1U-0006HH-R0
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 06:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242Ab2CAF5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 00:57:47 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:41134 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653Ab2CAF5r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 00:57:47 -0500
Received: by vcqp1 with SMTP id p1so200736vcq.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 21:57:46 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.52.88.212 as permitted sender) client-ip=10.52.88.212;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.52.88.212 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.52.88.212])
        by 10.52.88.212 with SMTP id bi20mr5337130vdb.2.1330581466656 (num_hops = 1);
        Wed, 29 Feb 2012 21:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ST73ENM1KuylFJhJfks7ipG1RVP6EK1Y3h5XEIClypM=;
        b=Hk90hof036QEV/m0GcioV/3ECScVmAFRyk2UaP98gznJT7K9e63RYywYxVJKrdaXwg
         ntW5lmIS5AGxQRWiRB3T6+hiUE65nvsiflS6sfM2ZrcPWieQopLrBFQ72ajPx0eZQfs9
         NsP0BhZgs88DW7NAOAzkTfNHewJIr1YmCrTLo=
Received: by 10.52.88.212 with SMTP id bi20mr4524059vdb.2.1330581466241;
        Wed, 29 Feb 2012 21:57:46 -0800 (PST)
Received: from localhost (c-98-207-169-74.hsd1.ca.comcast.net. [98.207.169.74])
        by mx.google.com with ESMTPS id gz4sm1493200vdb.19.2012.02.29.21.57.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 21:57:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120301051010.GE2572@tgrennan-laptop>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191900>

On Wed, Feb 29, 2012 at 09:10:10PM -0800, Tom Grennan wrote:
>On Wed, Feb 29, 2012 at 07:26:10PM -0800, Junio C Hamano wrote:
>>Tom Grennan <tmgrennan@gmail.com> writes:
>>
>For example, try this w/ and w/o the above change.
>	(cd t && ./t5512-ls-remote.sh) | less

	(cd t && ./t5512-ls-remote.sh -v) | less

-- 
TomG

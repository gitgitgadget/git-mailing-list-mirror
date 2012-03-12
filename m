From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: stripping [PATCH] without losing later tags from mailed patches
 (Re: [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 13:54:40 -0500
Message-ID: <20120312185440.GA21817@burratino>
References: <20120312024948.GB4650@kroah.com>
 <20120312063027.GB8971@1wt.eu>
 <20120312064855.GB16820@burratino>
 <20120312085820.GA11569@1wt.eu>
 <20120312152004.GB9380@kroah.com>
 <20120312152453.GB12405@1wt.eu>
 <87aa3l4vqq.fsf@thomas.inf.ethz.ch>
 <20120312165703.GB18791@burratino>
 <7vvcm9snko.fsf@alter.siamese.dyndns.org>
 <20120312185008.GH12405@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, Greg KH <greg@kroah.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Willy Tarreau <w@1wt.eu>
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 12 19:55:07 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S7AOg-0007OT-Ur
	for glk-linux-kernel-3@plane.gmane.org; Mon, 12 Mar 2012 19:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756500Ab2CLSy4 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Mar 2012 14:54:56 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46362 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756448Ab2CLSyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Mar 2012 14:54:54 -0400
Received: by iagz16 with SMTP id z16so7226999iag.19
        for <multiple recipients>; Mon, 12 Mar 2012 11:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=r0XO0s9iS21PtlSlquQ5UPpq4LvP10azycLCBc7Dqtg=;
        b=ItbPiN2vTYiQaFD0D3lpU3Zn10NOdywXqHizMx31Ab1kQ3Uygef505Dep5AaMIQWBN
         r1Qg34++dFxAPX60Sm3Q/O7HaNTtbf7IGvFenqlUJ6frVaO12mlNDJ5K2uffSPqVYy+z
         EOmTprqElL5+fz3+KtwOv/Dk+jEtGuDJ/qoIYNpVc482hJe5PH0021KZdDwNLuXcyjqH
         I1bLsUhPaoEZKxc0zqpNYeRGVg1fK5FRreypuAREzwuIB+1sqThI33y7RUBT4ETzla6w
         2ztY1gIJGShC1yn2qzfi1rGBwq2k9hjpmm41dMVU00nkNi4SopgdDPAiRNVmAxw4vbZo
         mdtQ==
Received: by 10.43.126.68 with SMTP id gv4mr16932743icc.30.1331578493999;
        Mon, 12 Mar 2012 11:54:53 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id c2sm13156301igj.1.2012.03.12.11.54.53
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 11:54:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120312185008.GH12405@1wt.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192924>

Willy Tarreau wrote:

> From my user experience and what I see on a number of coworkers, users
> tend to make big jumps when they need a new feature, so in practice,
> not offering the option in a version or two would probably not affect
> most users, especially the ones still relying on the old behaviour. So
> I don't see much benefit in waiting for repurposing the option.

The benefit is that if it does turn out to be a regression, early
adopters will complain to us because their scripts have stopped
working and we get a chance to back out the change without having to
worry about others who have started to rely on the option.

Regards,
Jonathan

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 1/8] test-lib: allow negation of prerequisites
Date: Thu, 15 Nov 2012 08:49:21 -0800
Message-ID: <20121115164921.GA17173@elie.Belkin>
References: <20121115003029.GA17550@sigill.intra.peff.net>
 <20121115003325.GA17819@sigill.intra.peff.net>
 <20121115074658.GA8429@elie.Belkin>
 <20121115164228.GA18108@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 17:49:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ2dN-00085u-EC
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 17:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768417Ab2KOQtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 11:49:32 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51163 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768379Ab2KOQtb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 11:49:31 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so1193379pad.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 08:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=f6cYEZOgDp8en+ZRFYET6P0FymBh0Ezqc/0EL7AfDw8=;
        b=dDmTeY/DSlYGDG/QnvIi3Dm5RV+5YEvHetjr4IcU2yKeGdl0ShIKlLoqo2DmT1Nrky
         W1TwsVuPbPxXnZKbx9lpYCKwfuAJoux74yI1E17D+q2098ItDgPpgiJ51W70iYsrjGxZ
         5HoqdqLfmbjDfwXiP6XmAFaxl4OXiCpv/HzN8x38+zstgV3utyRr3hjwzxC5UsIobtvv
         OErl514y7TWeNI3CbLG3uwDJaE39vqqEAj/zjgtBg5JDyzcoDIPytXrgbr58X8rmlNte
         BT7JoKbEtEH7+hJlHGd/hm+XeXomkkIgpbmdQqEzM/FBcSDBhV6sa40/P8sUYpRJtU7T
         MQAg==
Received: by 10.68.136.135 with SMTP id qa7mr6269275pbb.157.1352998170917;
        Thu, 15 Nov 2012 08:49:30 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id ok8sm9754613pbb.42.2012.11.15.08.49.27
        (version=SSLv3 cipher=OTHER);
        Thu, 15 Nov 2012 08:49:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121115164228.GA18108@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209829>

Jeff King wrote:

> Yes. You can test it yourself with "bash t0000-basic.sh". The reason is
> that the "!" is part of history expansion, which is only enabled by
> default for interactive shells.

Nice to hear.  Thanks much for looking into it.

> On Wed, Nov 14, 2012 at 11:46:58PM -0800, Jonathan Nieder wrote:

>> If it works everywhere, this patch would help me conquer my fear of
>> exclamation points in git's tests, which would be a comfort to me and
>> a very good thing.

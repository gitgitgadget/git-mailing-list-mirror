From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: GSoC questions
Date: Fri, 01 Apr 2011 23:05:13 +0200
Message-ID: <4D963E09.10003@lyx.org>
References: <AANLkTinTM8hQpcahGgDyB4UJvGbdN0xyp65wL5PDQGKa@mail.gmail.com> <20110328001152.GA11294@elie> <AANLkTikGb1=Rtz-T9p=u+X32KpL2AXq0AELdSJ2NMHrW@mail.gmail.com> <AANLkTink4wVb6O+yVm=HUh_s1GhKhyL4baqYGe=XFu04@mail.gmail.com> <AANLkTinZ2zbhCRAqAYkiAa1=K8aUhcAuEe6Q_gO-v2h_@mail.gmail.com> <AANLkTi=TOYOj2HWzy62G24Kg=NZC5X1=psA3GDhaH3Hc@mail.gmail.com> <20110331192758.GD16981@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alexandru Sutii <sutii.alex@gmail.com>,
	Vicent Marti <vicent@github.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	libgit2@librelist.org
To: Jeff King <peff@github.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 23:05:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5lWs-0007FJ-21
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 23:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754986Ab1DAVFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 17:05:07 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34051 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298Ab1DAVFG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 17:05:06 -0400
Received: by ewy4 with SMTP id 4so1184333ewy.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 14:05:04 -0700 (PDT)
Received: by 10.14.135.79 with SMTP id t55mr2524080eei.14.1301691904511;
        Fri, 01 Apr 2011 14:05:04 -0700 (PDT)
Received: from [145.94.80.223] (x080223.tnw-m.tudelft.nl [145.94.80.223])
        by mx.google.com with ESMTPS id r48sm1660395eei.16.2011.04.01.14.05.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Apr 2011 14:05:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110331192758.GD16981@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170622>


>> I guess the git2 client will consist solely of non-gitcore code, as
>> all the gitcore code will be part of libgit2 eventually.
>>
> I had sort of assumed that git-core code would be taken as inspiration,
> but that it would be an entirely new implementation, based around the
> error handling and build infrastructure provided by libgit2.

Looking at the above, I think we completely agree. When I wrote that the 
gitcore code will get into libgit2, I indeed meant that it should be 
rewritten in the libgit2 style and then be added to libgit2.

There was also temporarily the idea for GSoC to let Git use the 
libgit2-library, or maybe to libify git on the road. That's why I 
thought it might be useful if we were not going to rewrite the boring 
administration code.

Thanks for thinking along,

Vincent

From: Scott Lamb <slamb@slamb.org>
Subject: Re: git-p4 fails when cloning a p4 depo.
Date: Fri, 08 Jun 2007 14:34:45 -0700
Message-ID: <4669CB75.7060009@slamb.org>
References: <1621f9fa0706080941k67d2878dud8cf06436c67aea0@mail.gmail.com> <1621f9fa0706081113w7bb765ebx74f03a7407b753cb@mail.gmail.com> <4669CAB4.5080507@slamb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Benjamin Sergeant <bsergean@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 23:34:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwm6h-0003gi-PE
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 23:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070AbXFHVey (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 17:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753573AbXFHVey
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 17:34:54 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:48156 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752915AbXFHVey (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 17:34:54 -0400
Received: from slamb-mac.dhcp.2wire.com (slamb-mac.vpn.slamb.org [172.16.0.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hobbes.slamb.org (Postfix) with ESMTP id 88A0C980D1;
	Fri,  8 Jun 2007 14:34:52 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <4669CAB4.5080507@slamb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49506>

Scott Lamb wrote:
> No need to hardcode - from Python this is 
> os.sysconf(os.sysconf_names['SC_ARG_MAX'])

In fact, just os.sysconf('SC_ARG_MAX') will do.

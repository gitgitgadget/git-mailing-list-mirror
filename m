From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 5/5] Add gitmodules(5)
Date: Tue, 12 Jun 2007 10:04:02 +0200
Message-ID: <20070612080402.GQ955MdfPADPa@greensroom.kotnet.org>
References: <20070611225918.GD4323@planck.djpig.de>
 <11816319211097-git-send-email-hjemli@gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 10:04:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy1MZ-00067C-5d
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 10:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbXFLIEG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 04:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbXFLIEG
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 04:04:06 -0400
Received: from smtp19.wxs.nl ([195.121.247.10]:63618 "EHLO smtp19.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbXFLIEE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 04:04:04 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp19.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JJI00KIPJQQEZ@smtp19.wxs.nl> for git@vger.kernel.org; Tue,
 12 Jun 2007 10:04:03 +0200 (CEST)
Received: (qmail 24819 invoked by uid 500); Tue, 12 Jun 2007 08:04:02 +0000
In-reply-to: <11816319211097-git-send-email-hjemli@gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49933>

On Tue, Jun 12, 2007 at 09:05:21AM +0200, Lars Hjemli wrote:
> +The file contains one subsection per submodule, and the subsection value
> +is the name of the submodule. Each submodule section also contains the
> +following required keys:

Your only argument for making them required was that Junio thought that
not having them might be ambiguous, but he doesn't think so anymore.

> +submodule.<name>.path::
> +	Defines the path, relative to the top-level directory of the git

Your previous patch had "_a_ path" instead of "_the_ path".
I prefer the former since it allows a module to be checkoud out
at multiple locations.

skimo

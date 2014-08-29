From: Jonas 'Sortie' Termansen <Sortie@Maxsi.org>
Subject: Re: [PATCH 8/9] autoconf: Check for timer_settime
Date: Fri, 29 Aug 2014 18:02:48 +0200
Message-ID: <5400A428.9000202@Maxsi.org>
References: <1409187862-21257-1-git-send-email-sortie@maxsi.org>	 <1409187862-21257-9-git-send-email-sortie@maxsi.org> <1409325810.18778.6.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 18:03:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNOdd-0005si-09
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 18:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbaH2QCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 12:02:50 -0400
Received: from csmtp5.one.com ([195.47.247.105]:33712 "EHLO csmtp5.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853AbaH2QCu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 12:02:50 -0400
Received: from [192.168.1.2] (0133301021.0.fullrate.dk [95.166.189.26])
	by csmtp5.one.com (Postfix) with ESMTPA id EF4C44000351D;
	Fri, 29 Aug 2014 16:02:47 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1409325810.18778.6.camel@jekeller-desk1.amr.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256151>

> Don't you mean it implies NO_TIMER_SETTIME?
> 
> It seems to me that these were all added for TIMER_SETTIME, and not
> NO_SETTIMER? Or am I just thoroughly confused?

Thanks, that's a mistake. I copy-pasted the wrong line. :P

All of those additions should just be:
# This also implies NO_TIMER_SETTIME

Jonas

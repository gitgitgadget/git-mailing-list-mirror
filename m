From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] Make run-command.c honour SHELL_PATH
Date: Mon, 26 Mar 2012 13:17:20 -0500
Message-ID: <20120326181720.GG7599@burratino>
References: <1332678696-4001-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120326011148.GA4428@burratino>
 <1332768900-sup-4533@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster <gitster@pobox.com>, peff <peff@peff.net>,
	git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Mon Mar 26 20:17:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCEU3-0006AR-9T
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 20:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932913Ab2CZSRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 14:17:30 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33021 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932830Ab2CZSR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 14:17:29 -0400
Received: by yenl12 with SMTP id l12so4064883yen.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 11:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BOx3DurEXXPPS0U8dub1sg6Wg/X6EJflI4K2HjTHMM4=;
        b=zC01+wggJaIcNuRCuLg35ivvt/5waGM2EaVyFhkugItumEAtsMJa42B3FiDWu5J1DX
         x4TQYQbIDx7Ilc1ybQaukKpXfh091MGJshpDTRLO220PV+Fa9iXt6u3f3ppP+oXdVF6k
         5vBe6+Sd9hEft8YZ9AJfatHbLYuGuhaLI4ySxfgUODU9yUE8sH5QjkB0oImMa+rc1WdK
         aafC2yIK5Qth2TS7vz8UaXtL82cg4DQxC/cSPcjxIMwpMyPxZD4qOw2kMhy536kPSkHk
         s/oxBtdAVHJ4rCnFOUwDGTBUzG7yeWYWk/ptoyD0YYB+V+0xUA/aRf/n+mZPNi7joMCt
         iH8Q==
Received: by 10.50.161.232 with SMTP id xv8mr6591279igb.9.1332785848775;
        Mon, 26 Mar 2012 11:17:28 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id zv10sm10690526igb.13.2012.03.26.11.17.27
        (version=SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 11:17:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1332768900-sup-4533@pinkfloyd.chass.utoronto.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193946>

Ben Walton wrote:
> Excerpts from Jonathan Nieder's message of Sun Mar 25 21:11:48 -0400 2012:

[...]
>>                                          at least in the short term
>> while we require a POSIX-style shell elsewhere in git.
>
> I'm unclear what you're meaning by this.  Are you implying that the
> requirement for a POSIX-style shell should be relaxes to the point
> where things don't rely on that base set of functionality?

Currently git uses bash on Windows by necessity.  I suspect we could
make a lot of people happy by dropping that dependency some day and
using cmd.exe or something like powershell in places the user provides
a script.

Context: [1]

Of course that's far in the future and not certain at all. ;-)

Ciao,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/164656/focus=164716

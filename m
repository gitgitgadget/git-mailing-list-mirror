From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 8/8] trace: give repo_setup trace its own key
Date: Thu, 24 Feb 2011 16:59:50 +0100
Message-ID: <4D668076.7020000@op5.se>
References: <20110224142308.GA15356@sigill.intra.peff.net> <20110224143030.GH15477@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 17:00:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psdbr-0005i6-JJ
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 17:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756067Ab1BXQAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 11:00:01 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37560 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755588Ab1BXQAA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 11:00:00 -0500
Received: by bwz15 with SMTP id 15so1143627bwz.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 07:59:59 -0800 (PST)
Received: by 10.204.55.65 with SMTP id t1mr975751bkg.140.1298563194455;
        Thu, 24 Feb 2011 07:59:54 -0800 (PST)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id v25sm6222294bkt.18.2011.02.24.07.59.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 07:59:52 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Thunderbird/3.1.7 ThunderGit/0.1a
In-Reply-To: <20110224143030.GH15477@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167826>

On 02/24/2011 03:30 PM, Jeff King wrote:
> You no longer get this output with GIT_TRACE=1; instead, you
> can do GIT_TRACE_SETUP=1.
> 

It would be beneficial if GIT_TRACE still turned on tracing globally
so one doesn't have to know all flags to start tracing for errors.

I also imagine running GIT_TRACE=1 <command> as the first step would
be quite useful for when one's not entirely certain where the problem
lies and then use the specific tracing flag when trying to fix it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.

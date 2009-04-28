From: Andreas Ericsson <ae@op5.se>
Subject: Re: How is git used as other than the project's version control?
Date: Tue, 28 Apr 2009 09:02:12 +0200
Message-ID: <49F6A9F4.8040408@op5.se>
References: <450196A1AAAE4B42A00A8B27A59278E70AE3EC48@EXCHANGE.trad.tradestation.com> <20090428014434.GA6462@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 28 09:02:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyhKj-0008OF-NI
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 09:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757649AbZD1HCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 03:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757345AbZD1HCQ
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 03:02:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:33922 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757297AbZD1HCP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 03:02:15 -0400
Received: by fg-out-1718.google.com with SMTP id d23so702298fga.17
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 00:02:13 -0700 (PDT)
Received: by 10.86.91.3 with SMTP id o3mr4080282fgb.20.1240902133534;
        Tue, 28 Apr 2009 00:02:13 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id l19sm2535956fgb.12.2009.04.28.00.02.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Apr 2009 00:02:13 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090428014434.GA6462@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117748>

Jeff King wrote:
> On Mon, Apr 27, 2009 at 06:55:38PM -0400, John Dlugosz wrote:
> 
>> I'm interested in finding out how people use git "on the side", when it
>> is not the project's actual version control system.
> 
> One of the nice things about git (and other distributed VCS's) is that
> creating a repo is very lightweight. If I am going to write a patch for
> some other software, the first thing I'll do after untarring it is "git
> init; git add .; git commit -m import". So it kind of blurs the concept
> of "what is the project's actual version control system" as you wrote
> above. If you consider the project to be my patch, it _is_ the VCS. Even
> though upstream may not be using it.
> 

This...

> And of course, if I am going to do multiple patches, then I may convert
> and track upstream's history via git.
> 

... although I usually *always* do this, even if it's only one patch.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.

From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] move get_merge_bases() to core lib; use it in merge-recursive
Date: Fri, 30 Jun 2006 02:27:13 +0200
Message-ID: <20060630002713.GD7216@steel.home>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com> <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de> <20060627223249.GA8177@steel.home> <Pine.LNX.4.63.0606291517010.29667@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0606290714v66a32976j531e2077ce6c1d77@mail.gmail.com> <Pine.LNX.4.63.0606291814200.29667@wbgn013.biozentrum.uni-wuerzburg.de> <7vmzbvrela.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0606292050380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 02:27:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw6r5-0002AN-Ie
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 02:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWF3A11 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 20:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWF3A11
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 20:27:27 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:53903 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S964810AbWF3A10 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 20:27:26 -0400
Received: from fwd30.aul.t-online.de 
	by mailout08.sul.t-online.com with smtp 
	id 1Fw6qv-00015Y-00; Fri, 30 Jun 2006 02:27:21 +0200
Received: from tigra.home (EY224yZZoeO3yqREyjdRKv32qFlnK6ijTZ5-000ytggJIdUOOvREQH@[84.160.88.232]) by fwd30.sul.t-online.de
	with esmtp id 1Fw6qo-0n4P6u0; Fri, 30 Jun 2006 02:27:14 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E51D8277B5;
	Fri, 30 Jun 2006 02:27:13 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Fw6qn-0007g9-QA; Fri, 30 Jun 2006 02:27:13 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606292050380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.6i
X-ID: EY224yZZoeO3yqREyjdRKv32qFlnK6ijTZ5-000ytggJIdUOOvREQH
X-TOI-MSGID: f09d8a83-efcc-429a-bf65-cc02a58dfdbf
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22930>

Johannes Schindelin, Thu, Jun 29, 2006 21:06:56 +0200:
> 
> Okay. Convinced.
> 
> I tested my patch again, and like Alex said, a test fails. But I tested on 
> top of Alex's latest merge-recursive patch, which has that nasty 
> update-index bug, and that is the reason for the test to fail.
> 
> So, a few tests later, I am pretty sure that my patches do not break 
> git-merge-base. I'll prepare another patch series which builds-in 
> merge-base.
> 

Just for reference, I'll repost all my patches again, somewhat
consolidated. Your merge_base patches can be applied on top of that
series.

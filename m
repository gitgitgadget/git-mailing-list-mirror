X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Marko Macek <marko.macek@gmx.net>
Subject: Re: [RFC] Introduce "git stage" (along with some heresy)
Date: Fri, 01 Dec 2006 21:44:28 +0100
Message-ID: <4570942C.406@gmx.net>
References: <87slfzfri7.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 20:50:02 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 14
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: bsn-77-250-193.dial-up.dsl.siol.net
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
In-Reply-To: <87slfzfri7.wl%cworth@cworth.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32965>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqFKF-0004rk-6U for gcvg-git@gmane.org; Fri, 01 Dec
 2006 21:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936560AbWLAUtg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 15:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936563AbWLAUtf
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 15:49:35 -0500
Received: from main.gmane.org ([80.91.229.2]:33511 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S936560AbWLAUtf (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 15:49:35 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GqFJs-0004mV-Kn for git@vger.kernel.org; Fri, 01 Dec 2006 21:49:16 +0100
Received: from bsn-77-250-193.dial-up.dsl.siol.net ([193.77.250.193]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 21:49:16 +0100
Received: from marko.macek by bsn-77-250-193.dial-up.dsl.siol.net with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 01
 Dec 2006 21:49:16 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Carl Worth wrote:
> [This message, (yes,another long one from me), proposes 3 changes. The
> first should be uncontroversial I think, while the second and third
> are clear heresy, (and the second would require some amount of
> re-training or re-configuration by existing git user). Pick and choose
> as you see fit. I don't think they actually depend on each other,
> though I'll present them here as parts of a whole.]

/me likes (both emails).

Q: should git-commit require either -a or --staged when there is a
staged commit?

Mark

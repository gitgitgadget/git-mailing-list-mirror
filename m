X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jon Masters <jcm@redhat.com>
Subject: Re: error: Can't lock ref
Date: Mon, 11 Dec 2006 11:35:59 -0500
Message-ID: <1165854959.13260.27.camel@jcm.boston.redhat.com>
References: <457D0F97.6050801@jonmasters.org>  <457D2013.4060908@op5.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 16:31:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <457D2013.4060908@op5.se>
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34013>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gto4D-0005C7-9I for gcvg-git@gmane.org; Mon, 11 Dec
 2006 17:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937105AbWLKQbp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 11:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936365AbWLKQbp
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 11:31:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41343 "EHLO mx1.redhat.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937105AbWLKQbo
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 11:31:44 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
 [172.16.52.254]) by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id
 kBBGVf9o013336; Mon, 11 Dec 2006 11:31:41 -0500
Received: from pobox.surrey.redhat.com (pobox.surrey.redhat.com
 [172.16.10.17]) by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id
 kBBGVeO6031725; Mon, 11 Dec 2006 11:31:40 -0500
Received: from [172.16.81.77] (jcm.boston.redhat.com [172.16.81.77]) by
 pobox.surrey.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id
 kBBGVdlI009982; Mon, 11 Dec 2006 16:31:39 GMT
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

On Mon, 2006-12-11 at 10:08 +0100, Andreas Ericsson wrote:
> Jon Masters wrote:
> > Hi folks,
> > 
> > I've just pushed up a packed git repo:
> > 
> > http://www.kerneltools.org/pub/downloads/module-init-tools/devel/module-init-tools.git 
> > 
> > 
> > Attempting to clone this repo using http generates the error in 
> > $subject. Brief searching via Google suggests this is an appache 
> > permissions problem - anyone got a trivially obvious apache config fix 
> > before I go trawling through to figure out what's up?

> What does your apache error log say?

That's just the thing - nothing. I get what looks like a good access in
the access log, but then that error - I can play around, but I know
others have discovered this to be some "known" apache problem. So, I'm
hoping someone knows what that is, before I start debugging it.

Jon.


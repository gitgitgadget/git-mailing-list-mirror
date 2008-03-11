From: Jeff King <peff@peff.net>
Subject: Re: Solaris test failure for git-1.5.4.4 -- t1300-repo-config.sh
	seg fault
Date: Tue, 11 Mar 2008 14:14:43 -0400
Message-ID: <20080311181443.GA16196@sigill.intra.peff.net>
References: <8ec76080803111106w26e074eal35915ec634816cc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 19:16:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ90a-0004Rl-RN
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 19:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbYCKSOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 14:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbYCKSOq
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 14:14:46 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1494 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135AbYCKSOp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 14:14:45 -0400
Received: (qmail 19006 invoked by uid 111); 11 Mar 2008 18:14:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 11 Mar 2008 14:14:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Mar 2008 14:14:43 -0400
Content-Disposition: inline
In-Reply-To: <8ec76080803111106w26e074eal35915ec634816cc7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76891>

On Tue, Mar 11, 2008 at 02:06:54PM -0400, Whit Armstrong wrote:

> * expecting failure:
> 
>         git config --bool bool.nobool foobar
> t1300-repo-config.sh: line -186:   319 Segmentation Fault      (core
> dumped) git config --bool bool.nobool foobar
> * FAIL 61: invalid bool (set)

IIRC, I already fixed this in c1867cea, which is in master but not
v1.5.4.4.

I think this was one of several Solaris fixes that I posted a while ago,
and the others are probably just in master, too. If you are going to try
to run the testsuite, please try with the current 'master'.

-Peff

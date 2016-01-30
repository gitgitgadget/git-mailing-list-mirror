From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/1] support -4 and -6 switches for remote operations
Date: Sat, 30 Jan 2016 13:28:13 +0000
Message-ID: <20160130132813.GA12933@dcvr.yhbt.net>
References: <20160128225123.GA20045@dcvr.yhbt.net>
 <xmqqegd1l13l.fsf@gitster.mtv.corp.google.com>
 <20160130085056.GA20118@dcvr.yhbt.net>
 <20160130131353.GA20429@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 14:29:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPVaP-0007dn-BE
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 14:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427AbcA3N2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 08:28:53 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:53802 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756595AbcA3N2O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 08:28:14 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94DC01F736;
	Sat, 30 Jan 2016 13:28:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160130131353.GA20429@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285111>

Eric Wong <normalperson@yhbt.net> wrote:
> rsync support is untouched for now since it is deprecated
> and scheduled to be removed.

I forgot add I'm not sure how to actually go about testing these changes
automatically since they involve DNS setups.  And the test suite seems
really slow nowadays, I guess/hope our test coverage has improved much
in the past few years?

I did test the ssh push case manually and all the fetch/clone cases,
including rsync (where I encountered the breakage from 2007).  So I
reverted my rsync change for now to avoid conflicting with its removal.

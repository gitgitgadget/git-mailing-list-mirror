From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git push vs. slow connection times - local commit resolution is too late
Date: Sat, 16 Jul 2011 14:52:06 +0200
Message-ID: <m2oc0uz8uh.fsf@igel.home>
References: <4E1EEDAA.1000204@redhat.com> <4E2115D5.4010002@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Blake <eblake@redhat.com>,
	Git Mailing List <git@vger.kernel.org>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Sat Jul 16 14:53:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi4Nb-0000TH-F7
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 14:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520Ab1GPMwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 08:52:11 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:44139 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab1GPMwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 08:52:09 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 200D01C01ABC;
	Sat, 16 Jul 2011 14:52:06 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id EF18B1C000A3;
	Sat, 16 Jul 2011 14:52:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id GPBhhGxwM+wS; Sat, 16 Jul 2011 14:52:06 +0200 (CEST)
Received: from igel.home (ppp-93-104-132-93.dynamic.mnet-online.de [93.104.132.93])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sat, 16 Jul 2011 14:52:06 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 1BCC8CA293; Sat, 16 Jul 2011 14:52:06 +0200 (CEST)
X-Yow: I can't think about that.  It doesn't go with HEDGES in the shape of
 LITTLE LULU -- or ROBOTS making BRICKS...
In-Reply-To: <4E2115D5.4010002@cisco.com> (Phil Hord's message of "Sat, 16 Jul
	2011 00:38:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177253>

Phil Hord <hordp@cisco.com> writes:

> I agree with your suggestion.  But as a quick fix, can you do this?
>   git push remote $(cat .git/HEAD):master

You mean $(git rev-parse HEAD), don't you?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

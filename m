From: Alex Tomlinson <alex@aivor.com>
Subject: Re: is git-p4 compatible with p4/linux?
Date: Fri, 19 Apr 2013 10:20:56 -0500
Message-ID: <517160D8.4060207@aivor.com>
References: <7BF81DF9-941D-400B-8304-6DA5F5C82D4F@aivor.com> <20130419000947.GB9048@padd.com> <14D98038-C656-47B9-ABF2-CC12914F0C75@aivor.com> <20130419115513.GA7966@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 17:21:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTD7f-0001yW-2O
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 17:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030616Ab3DSPVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 11:21:06 -0400
Received: from smtp-out2.electric.net ([72.35.23.38]:54078 "EHLO
	smtp-out2.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030512Ab3DSPVE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 11:21:04 -0400
Received: from 1UTD7S-0005CV-Ur by bean.electric.net with emc1-ok (Exim 4.77)
	(envelope-from <alex@aivor.com>)
	id 1UTD7S-0005D1-Vd; Fri, 19 Apr 2013 08:20:58 -0700
Received: by emcmailer; Fri, 19 Apr 2013 08:20:58 -0700
Received: from [10.86.10.81] (helo=fuseout2a.electric.net)
	by bean.electric.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77)
	(envelope-from <alex@aivor.com>)
	id 1UTD7S-0005CV-Ur; Fri, 19 Apr 2013 08:20:58 -0700
Received: from mailanyone.net
	by fuseout2a.electric.net with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(MailAnyone extSMTP aivort)
	id 1UTD7S-0002G9-37; Fri, 19 Apr 2013 08:20:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <20130419115513.GA7966@padd.com>
X-Outbound-IP: 10.86.10.81
X-Env-From: alex@aivor.com
X-PolicySMART: 1102869
X-Virus-Status: Scanned by VirusSMART (c)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221763>

I found some symlinks in our depot that have the newline and
others that do not.  It looks like p4 print just dumps whatever
is in the depot file, which of course is what you would expect
it to do.  So the question (for me) is, how did some of my symlink
targets end up without the newline?  Note: that's not a question
for git-p4 because git-p4 was not involved in the creation of
this p4 depot (or the symlink).

git-p4 is off the hook since it appears to be an issue with
the depot itself.

Thanks for your time!
--Alex

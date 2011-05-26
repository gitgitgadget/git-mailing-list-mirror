From: Markus Duft <mduft@gentoo.org>
Subject: Re: [PATCH 1/2] Add additional build options for Interix, and remove
 obsolete ones.
Date: Thu, 26 May 2011 08:29:13 +0200
Message-ID: <4DDDF339.4000703@gentoo.org>
References: <1306332924-28587-1-git-send-email-mduft@gentoo.org> <1306332924-28587-2-git-send-email-mduft@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 08:29:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPU4P-00015I-Re
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 08:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037Ab1EZG3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 02:29:16 -0400
Received: from smtp.salomon.at ([193.186.16.13]:51046 "EHLO sauxb.salomon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751165Ab1EZG3P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 02:29:15 -0400
Received: from servex01.wamas.com (servex01.salomon.at [172.28.2.2])
	by sauxb.salomon.at (8.12.10/8.12.10) with ESMTP id p4Q6TBJR019348;
	Thu, 26 May 2011 08:29:11 +0200 (METDST)
Received: from [172.28.8.166] ([172.28.8.166]) by servex01.wamas.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 26 May 2011 08:29:11 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110506 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <1306332924-28587-2-git-send-email-mduft@gentoo.org>
X-OriginalArrivalTime: 26 May 2011 06:29:11.0086 (UTC) FILETIME=[396F74E0:01CC1B6E]
X-Scanned-By: MIMEDefang 2.54 on 172.28.2.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174498>

On 05/25/11 16:15, mduft@gentoo.org wrote:

(sorry for actually replying to the wrong mail - wasn't subscribed to the list (but am now.))

>> The removed options are obsolete, because interix support now
>> depends on libsuacomp.
>
> and linkage with -lsuacomp happens automatically without any change in the
> Makefile for anybody?  Just asking, as I do not have an access to (nor any
> particular desire to get an access to) an Interix to figure it out myself,
> and the only think I care about in this patch is if it helps only your
> installation or it will help everybody who has Interix but not necessarily
> with the same set of additional configuration as you have.

Yes. suacomp installs itself as libc.{a,so}. Of course the path to the suacomp prefix needs to be told to the compiler. Without it, interix (at least the newer versions) are near unusable, because of a whole lot of bugs M$ won't fix (as usual...). Suacomp can be installed manually by whoever likes to, and is included in the Gentoo Prefix project automatically (which is my target). I guess without Gentoo Prefix there'd be another whole lot of things missing to build git anyway (haven't tried). Gentoo Prefix also automatically get's all paths right, etc.

Currently, suacomp is already required for things like coreutils, perl, python, openssh, findutils, etc., etc. to work correctly, if not build at all...

Hope that explains some, sorry for not doing so at first :)

Regards, Markus

>
>> Signed-off-by: Markus Duft <mduft <at> gentoo.org>

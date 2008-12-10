From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Recovering from epic fail (deleted .git/objects/pack)
Date: Wed, 10 Dec 2008 12:39:06 +0100
Message-ID: <493FAA5A.8070801@viscovery.net>
References: <1228867861.14165.19.camel@starfruit.local>	 <7vd4g051ax.fsf@gitster.siamese.dyndns.org> <1228903606.4445.53.camel@starfruit.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 12:40:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LANQh-0002qX-WB
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 12:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbYLJLjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 06:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbYLJLjO
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 06:39:14 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:12275 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbYLJLjN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 06:39:13 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LANPH-0004LN-BQ; Wed, 10 Dec 2008 12:39:07 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 085C64FB; Wed, 10 Dec 2008 12:39:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <1228903606.4445.53.camel@starfruit.local>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "lilzmailsa03.liwest.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  R. Tyler Ballance schrieb: > On Tue, 2008-12-09 at 16:19 -0800,
	Junio C Hamano wrote: >> See if "fsck --full" complains after that. If the
	repository was not >> repacked during that period, all objects created by
	the activity by the >> unfortunate developer would be loose, so ... > > tyler@ccnet:~/source/slide/brian_main>
	time git fsck --full > Segmentation fault [...] 
	Content analysis details:   (-1.4 points, 7.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102681>

R. Tyler Ballance schrieb:
> On Tue, 2008-12-09 at 16:19 -0800, Junio C Hamano wrote:
>> See if "fsck --full" complains after that.  If the repository was not
>> repacked during that period, all objects created by the activity by the
>> unfortunate developer would be loose, so ...
> 
> tyler@ccnet:~/source/slide/brian_main> time git fsck --full
> Segmentation fault

Please make a backup (tarball) of the repository that shows this segfault.
'git fsck' is not supposed to segfault, no matter what garbage is thrown
at it.

Can you make a backtrace of this failing 'git fsck --full' invocation?

-- Hannes

From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 04/15] Set _O_BINARY as default fmode for both MinGW and
 MSVC
Date: Thu, 17 Sep 2009 10:10:54 +0200
Message-ID: <4AB1EF0E.5010600@viscovery.net>
References: <cover.1253088099.git.mstormo@gmail.com>	 <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com>	 <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com>	 <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com>	 <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com>	 <4AB10F01.9010703@viscovery.net> <e2480c70909161300o3db4b416k8f33ccce2f987c55@mail.gmail.com> <4AB1E118.70504@viscovery.net> <4AB1E4C5.80102@gmail.com> <4AB1E6E4.1040100@viscovery.net> <4AB1EB02.2090308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Alexey Borzenkov <snaury@gmail.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com,
	raa.lkml@gmail.com,
	Marius Storm-Olsen <marius.storm-olsen@nokia.com>
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 10:11:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoC53-00078r-7C
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 10:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbZIQIKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 04:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbZIQIKy
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 04:10:54 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:7396 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbZIQIKx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 04:10:53 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MoC4s-0004Sf-O7; Thu, 17 Sep 2009 10:10:54 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 76227BC81; Thu, 17 Sep 2009 10:10:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4AB1EB02.2090308@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128730>

Marius Storm-Olsen schrieb:
> BTW, I ran all the tests (make /k test) before and after the
> whole series, with msysgit 'devel' branch + plain git.git 'next',
> and it turns out that 2 more tests pass after this series :)

Sorry to disappoint you: these 2 tests only passed by chance. For a
work-around see e95a73ef in mingw.git (it papers over an undetected
racily-clean index).

-- Hannes

From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 14/15] Add scripts to generate projects for other buildsystems
   (MSVC vcproj, QMake)
Date: Fri, 18 Sep 2009 10:21:12 +0200
Message-ID: <4AB342F8.7080504@viscovery.net>
References: <cover.1253088099.git.mstormo@gmail.com> <260603a54845df34659d605fadaf663d0094c8cb.1253088099.git.mstormo@gmail.com> <aa80ad559c731ca73179956e34b2743d903fbbec.1253088099.git.mstormo@gmail.com> <200909172228.28174.j6t@kdbg.org> <4AB32FE2.1060604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com
To: Marius Storm-Olsen <mstormo@gmail.com>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 18 10:21:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoYie-0006Ap-RL
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 10:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbZIRIVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 04:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbZIRIVT
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 04:21:19 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:15696 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbZIRIVR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 04:21:17 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MoYiQ-0002G7-Lq; Fri, 18 Sep 2009 10:21:14 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6B2A04E9; Fri, 18 Sep 2009 10:21:13 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
Newsgroups: gmane.comp.version-control.git,gmane.comp.version-control.msysgit
In-Reply-To: <4AB32FE2.1060604@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128791>

Marius Storm-Olsen schrieb:
> Johannes Sixt said the following on 17.09.2009 22:28:
>> why do
>> you need entries for *.obj, *.idb, and *.pdb?
> 
> When using only the vcproj generator, you are correct. However, if you
> use the qmake generator, and create vcprojs from those, the *.idb and
> *.pdb files are located in the project directory itself, and not under
> Debug/. I'm not too worried about this case though, so for me, the three
> entries *.obj, *.idb and *.pdb can go.

Fair enough.

> Junio, you want me to push a new patch?

That's not necessary. I just wanted to make sure that you added the
entries deliberately.

With these questions answered, and the most recent change to 04/15 that
adjust test-genrandom.c, the MinGW aspect of this series is

Acked-by: Johannes Sixt <j6t@kdbg.org>

Thank you very much for your work and persistency!

-- Hannes

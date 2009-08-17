From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: sparse support in pu
Date: Mon, 17 Aug 2009 14:00:54 +0200
Message-ID: <4A894676.1090803@viscovery.net>
References: <2729632a0908162309ma6e7d41kc3bafe4575120630@mail.gmail.com> 	<fcaeb9bf0908170117v67e9f8b1ga56edcda14821e91@mail.gmail.com> 	<2729632a0908170149o425544dcw52aeb6ac6ee1437d@mail.gmail.com> 	<fcaeb9bf0908170321o43fa4a6bv95dd78ff7889686f@mail.gmail.com> 	<4A8932BB.7030002@viscovery.net> <fcaeb9bf0908170441o30005085nb0d4e08f333b6146@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: skillzero@gmail.com, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 14:01:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md0tg-000585-N9
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 14:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbZHQMA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 08:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757869AbZHQMA7
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 08:00:59 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:56489 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbZHQMA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 08:00:58 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Md0tV-0006gp-D9; Mon, 17 Aug 2009 14:00:57 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 009ECC6C2; Mon, 17 Aug 2009 14:00:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <fcaeb9bf0908170441o30005085nb0d4e08f333b6146@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126161>

Nguyen Thai Ngoc Duy schrieb:
> On Mon, Aug 17, 2009 at 5:36 PM, Johannes Sixt<j.sixt@viscovery.net> wrote:
>> In order to advocate my earlier proposal: Name the file
>> .git/info/phantoms, then it's clear: "The files mentioned here are
>> phantoms" - they exist in the index, but not in the worktree; no phantoms
>> means that everything is checked out.
> 
> OK. Phantom checkout, must be unique in VCS world ;-) If no one
> objects my next series will use this name as it's better than "sparse"
> and "assume-unchanged" is just too vague. Would option names to
> enable/disable this be --with[out]-phantoms?

--phantoms vs. --no-phantoms?

-- Hannes

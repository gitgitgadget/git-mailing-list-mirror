From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [msysGit] Re: [PATCH 02/11] Fix declare variable at mid of  
  function
Date: Wed, 19 Aug 2009 17:21:29 +0200
Message-ID: <4A8C1879.2070807@viscovery.net>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>  <1250524872-5148-2-git-send-email-lznuaa@gmail.com>  <alpine.DEB.1.00.0908171827040.4991@intel-tinevez-2-302>  <3f4fd2640908170934w4c48ada1o66745f845ecb7d49@mail.gmail.com>  <alpine.DEB.1.00.0908172134150.8306@pacific.mpi-cbg.de>  <4A8A3ADE.9010703@gmail.com>  <alpine.DEB.1.00.0908181132470.4680@intel-tinevez-2-302> <1976ea660908180911m7469ac20w48a28b90262d25f6@mail.gmail.com> <alpine.DEB.1.00.0908191158310.5594@intel-tinevez-2-302> <4A8BDA2A.9030105@viscovery.net> <alpine.DEB.1.00.0908191514020.5594@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Frank Li <lznuaa@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Reece Dunn <msclrhd@googlemail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 17:21:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdmys-0002pi-6d
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 17:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbZHSPVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 11:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbZHSPVd
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 11:21:33 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:58910 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbZHSPVd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 11:21:33 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mdmyf-00014s-Qk; Wed, 19 Aug 2009 17:21:30 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 84B2D4E4; Wed, 19 Aug 2009 17:21:29 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <alpine.DEB.1.00.0908191514020.5594@intel-tinevez-2-302>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126550>

Johannes Schindelin schrieb:
> On Wed, 19 Aug 2009, Johannes Sixt wrote:
>> Johannes Schindelin schrieb:
>>> On Wed, 19 Aug 2009, Frank Li wrote:
>>>> I have push my change to tgit
>>>> git://repo.or.cz/tgit.git
>>>> branch vcpatch2
>>>>
>>>> How do I know if patch has been applied main line?
>>> I applied them to 4msysgit.git's devel.  Note that I had a strange 
>>> merge conflict in pager.c: you replaced and #ifndef __MINGW32__ with 
>>> an #ifndef WIN32, but I don't have that #ifndef at all.
>> 4msysgit has my "Windows: Better support PAGER settings with spaces in 
>> the path", which removes the #ifndefs, Frank's version doesn't have it. 
>> Therefore, you should not rebase Frank's patches on top of 4msysgit's 
>> master or devel before they are merged into git.git.
> 
> Well, I wanted to give them a little bit more visibility by putting them 
> into 4msysgit.git, as I think the best way to get Microsoft Visual C++ 
> support into git.git _is_ via 4msysgit.git.

Even more so should you keep the original patches (in this case at least),
not rebased ones. It is unlikely that "Windows: Better support PAGER..."
will be in git.git _before_ Frank's MINGW32->WIN32 conversion patch.

-- Hannes

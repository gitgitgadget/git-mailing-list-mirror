From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
   state
Date: Thu, 15 Jan 2009 08:35:43 +0100
Message-ID: <496EE74F.6000205@viscovery.net>
References: <87ab9th0rh.fsf@cup.kalibalik.dk> <alpine.DEB.1.00.0901150149130.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 08:37:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNMmt-0007VG-AK
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 08:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756659AbZAOHfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 02:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756546AbZAOHfr
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 02:35:47 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:24479 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756544AbZAOHfr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 02:35:47 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LNMlU-00041s-7q; Thu, 15 Jan 2009 08:35:44 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id EA5124FB; Thu, 15 Jan 2009 08:35:43 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <alpine.DEB.1.00.0901150149130.3586@pacific.mpi-cbg.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105770>

Johannes Schindelin schrieb:
> On Thu, 15 Jan 2009, Anders Melchiorsen wrote:
>> Previously, the interactive rebase edit mode placed the user after the 
>> commit in question. That was awkward because a commit is supposedly 
>> immutable. Thus, she was forced to use "git commit --amend" for her 
>> changes.
> 
> Maybe, maybe not.  I frequently rebase with "edit" when I actually mean 
> "stop" (but "s" was taken from "squash" already).  Then I test things, 
> possibly fixing them.
> 
> So in that case, I do not want a git reset --soft HEAD^.

Absolutely! I use "edit" for this purpose as well quite frequently.

-- Hannes

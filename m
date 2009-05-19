From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] gitk: Handle msysGit version during version   comparisons
Date: Tue, 19 May 2009 10:51:18 +0200
Message-ID: <4A127306.6040904@drmicha.warpmail.net>
References: <87hbzirso6.fsf@users.sourceforge.net> <alpine.DEB.1.00.0905191043320.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 19 10:51:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6L2q-00039D-2f
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 10:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbZESIvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 04:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbZESIvX
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 04:51:23 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39485 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750778AbZESIvX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 04:51:23 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id C779F3461DC;
	Tue, 19 May 2009 04:51:23 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 19 May 2009 04:51:23 -0400
X-Sasl-enc: MIXkIjDKTRlg0YM0jKYG2vMjRP37ZtF06bgL/UMZXr+d 1242723083
Received: from localhost.localdomain (p548599BC.dip0.t-ipconnect.de [84.133.153.188])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C2B1B2B960;
	Tue, 19 May 2009 04:51:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090519 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <alpine.DEB.1.00.0905191043320.26154@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119508>

Johannes Schindelin venit, vidit, dixit 19.05.2009 10:43:
> Hi,
> 
> On Mon, 18 May 2009, Pat Thoyts wrote:
> 
>>
>>   msysGit generates version strings with text appended which cannot
>>   be used with vcompare. Limit git_version to the first three digits
>>   which are the real git version.
>>
>> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> 
> Is that indent intentional?
> 
> Ciao,
> Dscho

It is clearly indentional :)

[During my git beginnings, the standard output format of git log made me
believe I should format commit message bodies like that, too.]

Michael

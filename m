From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: msysGit on FAT32
Date: Tue, 04 Dec 2007 14:48:14 +0100
Message-ID: <47555A9E.3090902@viscovery.net>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org> <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org> <7vfxz89x9q.fsf@gitster.siamese.dyndns.org> <7vabpctx3b.fsf@gitster.siamese.dyndns.org> <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org> <7v4pfakr4j.fsf@gitster.siamese.dyndns.org> <7vzlwv6sxr.fsf@gitster.siamese.dyndns.org> <7vy7ca6ea9.fsf@gitster.siamese.dyndns.org> <47552084.3070601@viscovery.net> <m3hciyvklt.fsf_-_@roke.D-201> <Pine.LNX.4.64.0712041329230.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 04 14:48:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzY8g-000401-OX
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 14:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbXLDNsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 08:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753093AbXLDNsS
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 08:48:18 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:19001 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbXLDNsR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 08:48:17 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IzY7U-00084C-A6; Tue, 04 Dec 2007 14:47:28 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E5FAD4E4; Tue,  4 Dec 2007 14:48:14 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0712041329230.27959@racer.site>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67046>

Johannes Schindelin schrieb:
> On Tue, 4 Dec 2007, Jakub Narebski wrote:
> 
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>
>>> BTW, we do use hardlinks on Windows; even the MsysGit installer 
>>> creates them (as long as the filesystem is NTFS). So, the fallout you 
>>> are expecting/hoping for will not be in the first round of MinGW port 
>>> patches. ;)
>> Would it be possible to add option to an installer to _not_ install 
>> git-cmd form for builtins when installing on FAT28^W FAT32?
> 
> It is the InnoSetup based installer that does that.  MSys has no way (yet) 
> to create hard links (at least that's the state of my knowledge).

I don't know about MSys, the runtime, but MSys's 'ln' and 'cp -l' both 
create hardlinks on NTFS. And for this reason, 'git clone -l' does, too.

-- Hannes

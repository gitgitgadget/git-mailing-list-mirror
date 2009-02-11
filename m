From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Make 'remote show' distinguish between merged and rebased
    remote branches
Date: Wed, 11 Feb 2009 18:12:23 +0100
Message-ID: <499306F7.8050404@viscovery.net>
References: <20090210202046.8EBEC3360AC@rincewind>	 <7v3aemm1po.fsf@gitster.siamese.dyndns.org>	 <4991FA18.1040200@xiplink.com> <76718490902101513i504e515ocb4a2d789ba520f0@mail.gmail.com> <499303E8.6030000@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 18:14:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXIes-0002F0-DW
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 18:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756043AbZBKRM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 12:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755643AbZBKRM3
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 12:12:29 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8647 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337AbZBKRM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 12:12:29 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LXIdM-00088t-16; Wed, 11 Feb 2009 18:12:24 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CCF4B6EF; Wed, 11 Feb 2009 18:12:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <499303E8.6030000@xiplink.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109448>

Marc Branchaud schrieb:
> Jay Soffian wrote:
>> * remote origin
>>   URL: git://git.kernel.org/pub/scm/git/git.git
>>   Remote branches:
>>     html      Not tracked
>>     maint     Tracked
>>     man       Tracked
>>     master    Tracked
>>     next      Tracked
>>     pu        Tracked
>>     todo      Not tracked
>>     old-next  Stale (would prune)
>>   Local branches configured to pull from this remote:
>>     master           upstream is master (merges)
>>     wip/remote-HEAD  upstream is next   (rebases)

I find this form more useful than the one below because of the clear
separation into remote an local branchs.

> How about something a bit tighter, merging the local branch list with the remote branch list:
> 
> * remote origin
>   URL: git://git.kernel.org/pub/scm/git/git.git
>   Remote branches:
>     html      Not tracked
>     master    Tracked by local branches:
>                 master (merges)
>                 mywork (rebases)
>     next      Tracked by local branch:
>                 wip/remote-HEAD (rebases)
>     pu        Tracked by local branch:
>                 pu (merges)
>     todo      Not tracked
>     old-next  Stale (would prune)

-- Hannes

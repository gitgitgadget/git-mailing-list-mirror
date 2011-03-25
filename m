From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] warn use of "git diff A..B"
Date: Fri, 25 Mar 2011 09:27:58 +0100
Message-ID: <4D8C520E.1090409@viscovery.net>
References: <7voc51cydw.fsf@alter.siamese.dyndns.org>	<7vei5xcxzm.fsf@alter.siamese.dyndns.org> <m3tyesv7zh.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 09:28:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q32NS-0007z8-Od
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 09:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933242Ab1CYI2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 04:28:08 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:38358 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755666Ab1CYI2G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 04:28:06 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Q32ND-0002P9-3f; Fri, 25 Mar 2011 09:28:02 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id CFDEA1660F;
	Fri, 25 Mar 2011 09:27:58 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <m3tyesv7zh.fsf@localhost.localdomain>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169966>

Am 3/24/2011 16:44, schrieb Jakub Narebski:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> "git diff" (and "diff-tree") accepts a range notation "A..B" from the
>> command line to specify the two endpoints to be compared; the right way to
>> spell this would be "git diff A B".  This is merely a historical accident
>> that comes from the fact that "git log" family of commands and "git diff"
>> happens to share some code in their command line parsers.
> 
> I think it is quite useful to acept this notation to allow for
> copy'n'paste from e.g. "git fetch" output:
> 
>      5e839c8..cd3065f  master     -> origin
> 
> On can simply paste "git diff 5e839c8..cd3065f".
>                               ^^^^^^^^^^^^^^^^

Good point! Of the inconsistencies that still remain in git, IMO, this is
the most bearable one, because it's very easy to explain.

-- Hannes

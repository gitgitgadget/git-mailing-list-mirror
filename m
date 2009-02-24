From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-gui: Fix file name pattern in .gitattributes.
Date: Tue, 24 Feb 2009 10:25:57 +0100
Message-ID: <49A3BD25.3000706@viscovery.net>
References: <1235462493-8761-1-git-send-email-j6t@kdbg.org> <7vskm4jkbk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 10:28:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbtaF-0002ho-IL
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192AbZBXJ0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754124AbZBXJ0o
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:26:44 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:46830 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079AbZBXJ0n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:26:43 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LbtYB-0007OG-A0; Tue, 24 Feb 2009 10:26:37 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 442A74E4; Tue, 24 Feb 2009 10:25:57 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7vskm4jkbk.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111250>

Junio C Hamano schrieb:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> The pattern for the *.po files was anchored at the repository's root, but
>> this would match the files only in the git-gui repository itself, but
>> not in the version that is subtree-merged into git.git.
>>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ---
>>  .gitattributes |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/.gitattributes b/.gitattributes
>> index f96112d..c69f4a0 100644
>> --- a/.gitattributes
>> +++ b/.gitattributes
>> @@ -1,3 +1,3 @@
>>  *           encoding=US-ASCII
>>  git-gui.sh  encoding=UTF-8
>> -/po/*.po    encoding=UTF-8
>> +po/*.po     encoding=UTF-8
> 
> Hmm, really?

No, not really. =:{

I observed some strangeness with gitk. But it turned out that this was an
old development version that got accidentally installed somewhere in $PATH.

Sorry for the noise.

-- Hannes

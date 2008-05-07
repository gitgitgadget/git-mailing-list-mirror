From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Makefile: update the default build options for AIX
Date: Wed, 07 May 2008 17:39:10 +0200
Message-ID: <4821CD1E.80603@viscovery.net>
References: <1210149355875-git-send-email-mike@abacus.co.uk>	 <4821992F.4060201@viscovery.net>	 <e2b179460805070551x7a0072e0w4d406ef4112849ce@mail.gmail.com>	 <4821AB32.8090700@viscovery.net> <4821BECA.8020509@nrlssc.navy.mil> <e2b179460805070815u6cc627feo6137084fe7c5a635@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 17:40:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtlko-00020k-ML
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 17:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763266AbYEGPjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 11:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759621AbYEGPjT
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 11:39:19 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29946 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763182AbYEGPjP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 11:39:15 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jtlja-0008K6-RW; Wed, 07 May 2008 17:39:11 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A44B169F; Wed,  7 May 2008 17:39:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <e2b179460805070815u6cc627feo6137084fe7c5a635@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81450>

Mike Ralphson schrieb:
> 2008/5/7 Brandon Casey <casey@nrlssc.navy.mil>:
>>  How about something like this?
>>
>>  diff --git a/compat/fopen.c b/compat/fopen.c
>>  index ccb9e89..70b0d4d 100644
>>  --- a/compat/fopen.c
>>  +++ b/compat/fopen.c
>>  @@ -1,5 +1,5 @@
>>  +#undef FREAD_READS_DIRECTORIES
>>   #include "../git-compat-util.h"
>>  -#undef fopen
>>   FILE *git_fopen(const char *path, const char *mode)
>>   {
>>         FILE *fp;
>>
>>
>>  -brandon
>>
> 
> Ta. I still get all the warnings with that, was that what you were
> trying to solve? The 64 bit specific tests in t5302 do still pass.

You should get one less warning (the one from compat/fopen.c), but this
time they *are* harmless. ;)

-- Hannes

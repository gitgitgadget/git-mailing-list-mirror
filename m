From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [regression?] "git status -a" reports modified for empty   submodule
 directory
Date: Wed, 30 Apr 2008 08:39:56 +0200
Message-ID: <4818143C.6050206@viscovery.net>
References: <46dff0320804220401h26d2f2ebg1748a4a310acc0f5@mail.gmail.com> <46dff0320804290831u7ef1a78ag2988d5d12f782bdb@mail.gmail.com> <7v4p9k7326.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ping Yin <pkufranky@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 08:40:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr5zp-00051M-9c
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 08:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845AbYD3GkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 02:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755747AbYD3GkE
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 02:40:04 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:14680 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512AbYD3GkE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 02:40:04 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jr5yw-0005MH-1r; Wed, 30 Apr 2008 08:40:00 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8CA266B7; Wed, 30 Apr 2008 08:39:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v4p9k7326.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80800>

Junio C Hamano schrieb:
> "Ping Yin" <pkufranky@gmail.com> writes:
> 
>> In the super project super with empty submodule directory sub
>> $ git diff
>> diff --git a/sub b/sub
>> deleted file mode 160000
>> index f2c0d45..0000000
>> --- a/sub
>> +++ /dev/null
>> @@ -1 +0,0 @@
>> -Subproject commit f2c0d4509a3178c...
> 
> The repository used to have a subproject and now it doesn't.  Why
> shouldn't it report the removal?

Because you are not required to have a subproject checked out?

-- Hannes

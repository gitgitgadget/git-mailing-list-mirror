From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH (GIT-GUI,GITK) 6/8] gitk: Port new encoding logic from
 git-gui.
Date: Mon, 22 Sep 2008 10:20:28 +0200
Message-ID: <48D7554C.4020601@viscovery.net>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com> <200809212252.35769.angavrilov@gmail.com> <48D74877.9050607@viscovery.net> <200809221201.35507.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 10:22:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khggk-00045A-MY
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 10:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbYIVIUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 04:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751717AbYIVIUc
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 04:20:32 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:32541 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbYIVIUc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 04:20:32 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Khgej-00042q-IL; Mon, 22 Sep 2008 10:20:30 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 503C36EF; Mon, 22 Sep 2008 10:20:29 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200809221201.35507.angavrilov@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96457>

Alexander Gavrilov schrieb:
> On Monday 22 September 2008 11:25:43 Johannes Sixt wrote:
>> Alexander Gavrilov schrieb:
>>> Subject: [PATCH] gitk: Implement batch lookup and caching of encoding attrs.
>>>
>>> When the diff contains thousands of files, calling git-check-attr
>>> once per file is very slow. With this patch gitk does attribute
>>> lookup in batches of 30 files while reading the diff file list,
>>> which leads to a very noticeable speedup.
>> This one does not work for me: The correct is not picked up anymore,
>> neither in Patch mode nor Tree mode. (It works as expected without this
>> patch.)
>>
> 
> OOPS, I forgot to copy the line that removes leading whitespace:

Thanks, with this it works now. The delay for a 1000 file patch is
bearable (on Windows, but y'know, Windows types are masochists :-).

Feel free to add:

Tested-by: Johannes Sixt <johannes.sixt@telecom.at>

to the patches in the series when you resend it - and I hope you do resend
it after addressing Paul's concerns.

-- Hannes

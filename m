From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: rebase, file permissions and removed file
Date: Mon, 27 Oct 2008 16:21:52 +0100
Message-ID: <4905DC90.6050503@viscovery.net>
References: <a2633edd0810270702x416bb659ke183b0cc6266071@mail.gmail.com>	 <4905D276.9020308@viscovery.net> <a2633edd0810270809w7fec93b2rc314cc025f41d41f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Mon Oct 27 16:23:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuTw3-0005ap-8x
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 16:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbYJ0PV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 11:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbYJ0PVz
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 11:21:55 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:50022 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbYJ0PVz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 11:21:55 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KuTui-0003Ri-Le; Mon, 27 Oct 2008 16:21:52 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4F2676EF; Mon, 27 Oct 2008 16:21:52 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <a2633edd0810270809w7fec93b2rc314cc025f41d41f@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99237>

Pascal Obry schrieb:
> On Mon, Oct 27, 2008 at 3:38 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Since you don't have any content to lose, you can always just
>>
>>  $ touch file1
>>  $ git add file1
>>  $ git rm file1
> 
> Does not work:

Yes, it did! ;)

> $ git rebase --continue
> Applying: Fix perm file1
> No changes - did you forget to use 'git add'?

This is an entirely different matter. My interpretation is that the
permission change of file1 was the only change in this commit. Since this
is no longer needed, you should run 'git rebase --skip'.

-- Hannes

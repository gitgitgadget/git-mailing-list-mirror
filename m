From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Fixing a broken GIT repo
Date: Mon, 21 Nov 2011 17:45:10 +0100
Message-ID: <4ECA8016.8070108@viscovery.net>
References: <ja5dgo$nlf$1@dough.gmane.org> <4EC6625B.2070301@viscovery.net> <CABPQNSaJVYqLw+JuOWg2wqa-Sig6+W_W-id7yRFLzZ0kTr73hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Bart van den Burg <bart@burgov.nl>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Nov 21 17:45:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSWzx-0004zs-2J
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 17:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030Ab1KUQpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 11:45:18 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:18328 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756028Ab1KUQpP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 11:45:15 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RSWzX-0004Iv-Cy; Mon, 21 Nov 2011 17:45:11 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2079C1660F;
	Mon, 21 Nov 2011 17:45:10 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.24) Gecko/20111103 Thunderbird/3.1.16
In-Reply-To: <CABPQNSaJVYqLw+JuOWg2wqa-Sig6+W_W-id7yRFLzZ0kTr73hw@mail.gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185751>

Am 11/21/2011 17:37, schrieb Erik Faye-Lund:
> On Fri, Nov 18, 2011 at 2:49 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Am 11/18/2011 11:54, schrieb Bart van den Burg:
>>> To git@git.samson-it.nl:/home/git/shifter_rai
>>>    cc5693a..85d1ee9  master -> master
>>
>> It looks like you are pushing via git protocol from Windows
>> (Git-for-Windows). This is known to dead-lock in most cases, and even
>> though it did not here, I would not be surprised if it had other issues.
>>
>> Do not do it. Push via ssh instead.
>>
> 
> Does it? Doesn't the "To git@git.samson-it.nl:/home/git/shifter_rai"
> line suggests ssh?

Oops, you are right.

-- Hannes

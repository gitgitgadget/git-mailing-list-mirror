From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v0 3/3] Build in git-rebase.sh
Date: Mon, 25 May 2009 08:47:18 +0200
Message-ID: <4A1A3EF6.1050405@viscovery.net>
References: <1242899229-27603-1-git-send-email-pclouds@gmail.com> 	<1242899229-27603-2-git-send-email-pclouds@gmail.com> <1242899229-27603-3-git-send-email-pclouds@gmail.com> 	<4A164C85.3000703@viscovery.net> <fcaeb9bf0905220030l45e1b7dfqd30f35b7c8e43b51@mail.gmail.com> 	<20090523092603.GA7420@dektop> <20090523145042.GA13139@dektop> 	<4A1A37AD.4080309@viscovery.net> <fcaeb9bf0905242334q37ef9a05xa05315639af4daf3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 08:47:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8TyC-0003Pi-6H
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 08:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbZEYGr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 02:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbZEYGr1
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 02:47:27 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:51245 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbZEYGr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 02:47:27 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M8Txu-0002LZ-He; Mon, 25 May 2009 08:47:25 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 650BD54D; Mon, 25 May 2009 08:47:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <fcaeb9bf0905242334q37ef9a05xa05315639af4daf3@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119889>

Nguyen Thai Ngoc Duy schrieb:
> On Mon, May 25, 2009 at 4:16 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Nguyen Thai Ngoc Duy schrieb:
>>> Someone with better Windows knowledge than me should explain how this works. Windows'
>>> snprintf() just cuts out the last character in this statement:
>>>
>>> snprintf(buf, 8, "--%s", "onto"); // result: '--ont', expected: '--onto'
>> This doesn't happen for me: neither with Windows's original snprintf nor
>> with the version from compat/. Are you using the latest msysgit
>> environment to compile, i.e. gcc 4.4? There was a change regarding
>> SNPRINTF_SIZE_CORR; perhaps that's the culprit?
> 
> It could be. I used git.git's next branch, not msys4git or mingw.git
> repositories.

OK. Assuming you are using the latest msysgit compiler, which is gcc 4.4,
then you need the SNPRINTF_SIZE_CORR related patch from 4msysgit.git.

-- Hannes

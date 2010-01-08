From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] mingw: disable Python
Date: Fri, 08 Jan 2010 14:52:47 +0100
Message-ID: <4B4738AF.9020101@viscovery.net>
References: <40aa078e1001071400j21900ed1n415394491d469b8c@mail.gmail.com> <1262902037-4420-1-git-send-email-kusmabite@gmail.com> <4B46E7D6.3080702@viscovery.net> <alpine.DEB.1.00.1001081135180.4272@intel-tinevez-2-302> <40aa078e1001080249t16b0ee01i5ceb8e7ad2426e70@mail.gmail.com> <7vpr5kpvmh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: kusmabite@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 14:52:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTFGr-0007vU-9N
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 14:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418Ab0AHNwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 08:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753405Ab0AHNwx
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 08:52:53 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8511 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393Ab0AHNwx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 08:52:53 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NTFGi-00039U-E7; Fri, 08 Jan 2010 14:52:48 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2C9861660F;
	Fri,  8 Jan 2010 14:52:48 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vpr5kpvmh.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136437>

Junio C Hamano schrieb:
> Erik Faye-Lund <kusmabite@googlemail.com> writes:
>>> On Fri, 8 Jan 2010, Johannes Sixt wrote:
>>>> (how do you undefine a Makefile variable?);
>>> How about
>>>
>>>        NO_PYTHON=
>>>
>>> in config.mak?
>> That doesn't work for me, at least not out of the box. NO_PYTHON is
>> still defined, it's just defined to an empty string.
> 
> I think Dscho is right.  "ifdef FOO" yields (and should yield) false if
> FOO is set to empty.

Indeed. Strange. It didn't work when I tested it a few hours ago, but no
it works as you say. According to the docs, 'ifdef' actually does not test
defined-ness, but emptyness. So, Erik's original version is fine:

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes

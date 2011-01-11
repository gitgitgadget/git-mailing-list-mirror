From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] t/README: hint about using $(pwd) rather than $PWD
 in tests
Date: Tue, 11 Jan 2011 09:54:06 +0100
Message-ID: <4D2C1AAE.1040002@viscovery.net>
References: <201012302205.13728.j6t@kdbg.org> <201012311711.06989.j6t@kdbg.org> <20101231203019.GC5898@burratino> <201012312321.31294.j6t@kdbg.org> <7v62u8hz01.fsf@alter.siamese.dyndns.org> <4D2C09D7.3070700@viscovery.net> <4D2C0A5E.7090708@viscovery.net> <20110111075441.GB9445@burratino> <4D2C11A5.4050709@viscovery.net> <20110111083729.GD9445@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 09:54:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcZzh-0005mz-00
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 09:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470Ab1AKIyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 03:54:13 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:24924 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501Ab1AKIyL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 03:54:11 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PcZzT-0004Om-0m; Tue, 11 Jan 2011 09:54:07 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BDCE51660F;
	Tue, 11 Jan 2011 09:54:06 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110111083729.GD9445@burratino>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164921>

Am 1/11/2011 9:37, schrieb Jonathan Nieder:
> I suspect that the reader will end up wondering "why does this have to
> be so complicated" no matter what.

Unfortunately, yes. Therefore, I'd like to keep the paragraph minimal,
focused on how expected values should be constructed, which is where
errors will happen primarily.

>>>       It makes a difference on Windows, where
>>>
>>> 	 - $(pwd) is a Windows-style path such as git might output, and
>>> 	 - $PWD is a Unix-style path that the shell (MSYS bash) will
>>> 	   mangle before passing to native apps like git.
>>
>> This information is already included by reference to 4114156ae9.
> 
> ... but if we can summarize it nicely, we can save the reader a
> step, no?

I don't think so: it's not complete enough. Readers will ask: "So what?"
Digging archives or a three paragraph follow-up explanation on the ML will
be required anyway.

> Anyway, what you have already written is useful; clearing up these
> details would just be icing on the top.

OK, thanks for a review.

-- Hannes

From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] t/README: hint about using $(pwd) rather than $PWD
 in tests
Date: Tue, 11 Jan 2011 09:15:33 +0100
Message-ID: <4D2C11A5.4050709@viscovery.net>
References: <201012302205.13728.j6t@kdbg.org> <201012311711.06989.j6t@kdbg.org> <20101231203019.GC5898@burratino> <201012312321.31294.j6t@kdbg.org> <7v62u8hz01.fsf@alter.siamese.dyndns.org> <4D2C09D7.3070700@viscovery.net> <4D2C0A5E.7090708@viscovery.net> <20110111075441.GB9445@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 09:15:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcZOI-0005QR-Ee
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 09:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435Ab1AKIPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 03:15:38 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:49160 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041Ab1AKIPg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 03:15:36 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PcZO9-0002kB-Iq; Tue, 11 Jan 2011 09:15:33 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4CC851660F;
	Tue, 11 Jan 2011 09:15:33 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110111075441.GB9445@burratino>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164919>

Am 1/11/2011 8:54, schrieb Jonathan Nieder:
> Perhaps it is also worth explaining the cases where $PWD is needed?
>
> 	By contrast, when a passing a path to git or constructing a URL,
> 	use $PWD.

The first part of the "or" is not true: you can pass the result of $(pwd)
to a command, and it means the same as $PWD; I would even recommend
against $PWD so that a reader does not have to wonder "why pass $PWD, but
check for $(pwd)?"

The second part I don't know whether it is true: I haven't noticed a
pattern where people did it the wrong way, therefore, I'don't even know
whether $PWD is really *always* required. Do *you* know?

>       It makes a difference on Windows, where
> 
> 	 - $(pwd) is a Windows-style path such as git might output, and
> 	 - $PWD is a Unix-style path that the shell (MSYS bash) will
> 	   mangle before passing to native apps like git.

This information is already included by reference to 4114156ae9.

-- Hannes

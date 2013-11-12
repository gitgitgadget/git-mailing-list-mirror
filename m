From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Bug? diff.submodule=log adds text to commit -v message
Date: Tue, 12 Nov 2013 23:17:46 +0100
Message-ID: <5282A90A.4030900@web.de>
References: <loom.20131110T222043-57@post.gmane.org> <528140F5.6090700@web.de> <loom.20131111T214646-550@post.gmane.org> <52814C35.6040205@web.de> <5281DCC5.2000209@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>, Ari Pollak <ari@debian.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 12 23:17:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgMHW-0001fd-0C
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 23:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883Ab3KLWRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 17:17:55 -0500
Received: from mout.web.de ([212.227.15.3]:58650 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757236Ab3KLWRx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 17:17:53 -0500
Received: from [192.168.178.41] ([91.3.130.121]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0M5wzV-1VVZcy2xvl-00xrpm for <git@vger.kernel.org>;
 Tue, 12 Nov 2013 23:17:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <5281DCC5.2000209@kdbg.org>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:4fDLkiUFDCXvcUYUOgmHatJS5C56uZlKCKbSalwoc5zG138z5Eb
 kUssl+7jgtvat3b/MeQpO5Lva8I6WIIzwGgNnBQ/uRI0IZhbeYoQx9/e63zyZBCuwsuBoI3
 DXTIE7KUvlgTIJfU9DP3wIF8a1V6vGUOb63VcYADhRvbuVdznnZ74Vfb2rOF0TxFxEcPMF8
 affr1NRYGHXO5yDddFkCg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237761>

Am 12.11.2013 08:46, schrieb Johannes Sixt:
> Am 11.11.2013 22:29, schrieb Jens Lehmann:
>> The diff below fixes the problem you describe for me. (But I do not
>> consider it a worthwhile fix in its current form because a line
>> starting with "Submodule " might appear in a perfectly normal commit
>> message, while "diff --git " most probably won't).
> 
> And on top of that, "Submodule " originates from a translatable string,
> doesn't it?

This would also be true for the marker line that Peff proposed:

  # Everything below this line is a diff that will be removed.

But I suspect that would be ok if the marker would be both added
and searched for in its translated form. Or is it possible that
the locale changes between those two steps?

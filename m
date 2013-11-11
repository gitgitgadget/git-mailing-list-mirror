From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-remote-mediawiki: do not remove installed files in "clean" target
Date: Mon, 11 Nov 2013 22:26:13 +0100
Message-ID: <vpq4n7ieikq.fsf@anie.imag.fr>
References: <20131109022239.GI10302@google.com> <vpqli0xstcw.fsf@anie.imag.fr>
	<20131111204504.GM10302@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Thorsten Glaser <t.glaser@tarent.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 22:26:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfz0A-0005Bz-6l
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 22:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663Ab3KKV00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 16:26:26 -0500
Received: from mx1.imag.fr ([129.88.30.5]:35501 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752349Ab3KKV0X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 16:26:23 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id rABLQBu0015462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Nov 2013 22:26:12 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id rABLQEHM022868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 11 Nov 2013 22:26:14 +0100
In-Reply-To: <20131111204504.GM10302@google.com> (Jonathan Nieder's message of
	"Mon, 11 Nov 2013 12:45:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 11 Nov 2013 22:26:12 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: rABLQBu0015462
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1384809976.04829@P/NboFAnjjfuP1eTqzwkfA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237657>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Matthieu Moy wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> Running "make clean" after a successful "make install" should not
>>> result in a broken mediawiki remote helper.
>>
>> Acked-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>
> Thanks for looking it over.  Here are a few more makefile tweaks on
> top of that one.

All look good to me. Is it intentional that you didn't Cc Junio?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

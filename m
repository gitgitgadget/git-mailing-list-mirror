From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] merge: make merge state available to prepare-commit-msg hook
Date: Thu, 09 Jan 2014 14:25:06 +0100
Message-ID: <vpq4n5dmgnh.fsf@anie.imag.fr>
References: <6B177FFA-1797-45FE-9EF1-2C9E6EE8A234@yaauie.com>
	<DA9E6645-82DC-4714-845F-423726F96A40@yaauie.com>
	<vpqr48ip7bm.fsf@anie.imag.fr>
	<B19C65C1-C2D9-486F-AEA7-1497A3B5C5B4@yaauie.com>
	<vpqtxdenoug.fsf@anie.imag.fr> <20140108220119.GN3881@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ryan Biesemeyer <ryan@yaauie.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?=C6var?= =?iso-8859-1?Q?_Arnfj=F6r=F0?= Bjarmason 
	<avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 09 14:25:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1Fbz-0007xG-5O
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 14:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbaAINZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 08:25:24 -0500
Received: from mx1.imag.fr ([129.88.30.5]:46954 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060AbaAINZW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 08:25:22 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s09DP5d5014705
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Jan 2014 14:25:05 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id s09DP6hg006104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 9 Jan 2014 14:25:06 +0100
In-Reply-To: <20140108220119.GN3881@google.com> (Jonathan Nieder's message of
	"Wed, 8 Jan 2014 14:01:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 09 Jan 2014 14:25:06 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s09DP5d5014705
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1389878709.66923@2PFbIk60LQPrFBSW4aI+pg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240255>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Matthieu Moy wrote:
>
>> Jonathan's answer is an option. Another one is
> [...]
>> So if the cleanup goes wrong, one can notice.
>
> test_when_finished also makes the test fail if the cleanup failed.

Yes, I was mentionning it as opposed to "throwing the code at the
toplevel of the shell", not as opposed to test_when_finished.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

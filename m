From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 2/4] t7505: ensure cleanup after hook blocks merge
Date: Thu, 09 Jan 2014 14:00:06 +0100
Message-ID: <vpq61ptnwdl.fsf@anie.imag.fr>
References: <6B177FFA-1797-45FE-9EF1-2C9E6EE8A234@yaauie.com>
	<1389228344-38813-1-git-send-email-ryan@yaauie.com>
	<1389228344-38813-3-git-send-email-ryan@yaauie.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?=C6var?= =?iso-8859-1?Q?_Arnfj=F6r=F0?= Bjarmason 
	<avarab@gmail.com>
To: Ryan Biesemeyer <ryan@yaauie.com>
X-From: git-owner@vger.kernel.org Thu Jan 09 14:00:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1FDv-000648-3g
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 14:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbaAINA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 08:00:28 -0500
Received: from mx2.imag.fr ([129.88.30.17]:46995 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402AbaAINA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 08:00:27 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s09D07N4011857
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Jan 2014 14:00:08 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id s09D06AM005679
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 9 Jan 2014 14:00:09 +0100
In-Reply-To: <1389228344-38813-3-git-send-email-ryan@yaauie.com> (Ryan
	Biesemeyer's message of "Thu, 9 Jan 2014 00:45:42 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 09 Jan 2014 14:00:08 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s09D07N4011857
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1389877210.70829@SSOOor/oqfqIHTy+9zIoqg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240254>

Ryan Biesemeyer <ryan@yaauie.com> writes:

> +  test_when_finished "git merge --abort" &&
> +  (
> +		git checkout -B other HEAD@{1} &&

Weird indentation (space/tab mix).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

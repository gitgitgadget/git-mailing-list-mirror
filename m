From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3] upload-pack.c: use of parse-options API
Date: Mon, 23 May 2016 20:03:26 +0200
Message-ID: <vpqy470fy8h.fsf@anie.imag.fr>
References: <20160519153903.22104-1-Antoine.Queru@ensimag.grenoble-inp.fr>
	<20160523130231.8725-1-Antoine.Queru@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, william.duclot@ensimag.grenoble-inp.fr,
	simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, gitster@pobox.com,
	peff@peff.net
To: Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 23 20:03:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4uCq-0000HZ-Iu
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 20:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbcEWSDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 14:03:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59786 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859AbcEWSDw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 14:03:52 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4NI3ON2014050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 23 May 2016 20:03:24 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4NI3Q1V025555;
	Mon, 23 May 2016 20:03:26 +0200
In-Reply-To: <20160523130231.8725-1-Antoine.Queru@ensimag.grenoble-inp.fr>
	(Antoine Queru's message of "Mon, 23 May 2016 15:02:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 23 May 2016 20:03:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4NI3ON2014050
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1464631406.14712@iCebeFSQz1MBgkydmR7hWg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295344>

Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr> writes:

> Option parsing now uses the parser API instead of a local parser.
> Code is now more compact.
> Description for -stateless-rpc and --advertise-refs
> come from the commit 42526b4 (Add stateless RPC options to upload-pack, receive-pack, 2009-10-30).

We usually wrap commit messages before 80 columns, and separate
paragraphs with blank lines. Have a look at "git log --no-merges" and
compare with your message.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

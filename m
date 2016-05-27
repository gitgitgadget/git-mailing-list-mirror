From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4] upload-pack.c: use of parse-options API
Date: Fri, 27 May 2016 16:52:49 +0200
Message-ID: <vpqpos7o8n2.fsf@anie.imag.fr>
References: <20160523130231.8725-1-Antoine.Queru@ensimag.grenoble-inp.fr>
	<20160527141628.1677-1-Antoine.Queru@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, william.duclot@ensimag.grenoble-inp.fr,
	simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, gitster@pobox.com,
	peff@peff.net
To: Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 27 16:53:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6J8V-00019r-4i
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 16:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274AbcE0OxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 10:53:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57685 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753979AbcE0OxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 10:53:09 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4REqlJW011523
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 27 May 2016 16:52:48 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4REqnfZ011858;
	Fri, 27 May 2016 16:52:49 +0200
In-Reply-To: <20160527141628.1677-1-Antoine.Queru@ensimag.grenoble-inp.fr>
	(Antoine Queru's message of "Fri, 27 May 2016 16:16:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Fri, 27 May 2016 16:52:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4REqlJW011523
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1464965572.01315@MZ8dJvOXLY2r3S6raLC8Ng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295759>

> Subject: [PATCH v4] upload-pack.c: use of parse-options API

I'd drop the "of" and say just "use parse-options API"

Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr> writes:

> Description for --stateless-rpc and --advertise-refs come from
> the commit 42526b4 (Add stateless RPC options to upload-pack,

Nit: s/the//

> +--advertise-refs::
> +	When --advertise-refs is passed as a command line parameter only
> +    	the initial ref advertisement is output, and the program exits
> +    	immediately.  This fits with the HTTP GET request model, where
> +    	no request content is received but a response must be produced.

Another nit: mix space/tab in indentation (renders badly on some
configurations).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

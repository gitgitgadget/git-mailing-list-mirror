From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH V2 2/3] pretty.c: rename strbuf_wrap() function
Date: Mon, 06 Jun 2016 18:12:55 +0200
Message-ID: <vpq37oqgut4.fsf@anie.imag.fr>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160606151340.22424-3-william.duclot@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, mhagger@alum.mit.edu,
	Johannes.Schindelin@gmx.de, peff@peff.net, mh@glandium.org,
	gitster@pobox.com,
	Simon Rabourg <simon.rabourg@ensimag.grenoble-inp.fr>
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 06 18:13:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9x9U-0003X9-3D
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 18:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbcFFQNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 12:13:11 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46435 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974AbcFFQNK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 12:13:10 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u56GCrHi029043
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 6 Jun 2016 18:12:53 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u56GCtKu003423;
	Mon, 6 Jun 2016 18:12:55 +0200
In-Reply-To: <20160606151340.22424-3-william.duclot@ensimag.grenoble-inp.fr>
	(William Duclot's message of "Mon, 6 Jun 2016 17:13:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 06 Jun 2016 18:12:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u56GCrHi029043
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465834374.74916@LO/GZsG040jP7/5ZJtsC6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296524>

William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:

> The function strbuf_wrap() is not part of the strbuf API, yet prevent to
> extend the API to include wrapping functions. Renaming it to something
> more specific allow to use "strbuf_wrap" for the strbut API.

s/strbut/strbuf/

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

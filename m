From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] push: deny policy to prevent pushes to unwanted remotes.
Date: Mon, 06 Jun 2016 18:37:06 +0200
Message-ID: <vpqd1nue0jx.fsf@anie.imag.fr>
References: <20160604145101.21928-1-Antoine.Queru@grenoble-inp.org>
	<vpq37oqjqgn.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, william.duclot@ensimag.grenoble-inp.fr,
	simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, larsxschneider@gmail.com,
	rsbecker@nexbridge.com, aaron@schrab.com, peff@peff.net
To: Antoine Queru <Antoine.Queru@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 18:37:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9xX5-0005Xd-Cy
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 18:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbcFFQhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 12:37:40 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37629 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497AbcFFQhi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 12:37:38 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u56Gb4kN013139
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 6 Jun 2016 18:37:04 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u56Gb6Rn004144;
	Mon, 6 Jun 2016 18:37:06 +0200
In-Reply-To: <vpq37oqjqgn.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	06 Jun 2016 17:18:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Mon, 06 Jun 2016 18:37:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u56Gb4kN013139
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465835827.72252@BL2wkeS8aoXwTD+VAdo/Cg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296534>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> + *easier and avoid confusion with a distant repo like 'github.com'

Forgotten nit in previous message: s/distant/remote/.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

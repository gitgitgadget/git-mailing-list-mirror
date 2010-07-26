From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: URL decoding changed semantics of + in URLs
Date: Mon, 26 Jul 2010 20:30:05 +0200
Message-ID: <vpq7hkif64y.fsf@bauges.imag.fr>
References: <201007231518.31071.trast@student.ethz.ch>
	<20100726154041.GA18762@coredump.intra.peff.net>
	<AANLkTikmFVHeMVEgj_G5h8VMNaw0zIm0Ol-vC1ffc45v@mail.gmail.com>
	<AANLkTimRrpiv7cu=j598K3x4h3UGW7-Hik6-6jA8R_5J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org
To: "Jasper St. Pierre" <jstpierre@mecheye.net>
X-From: git-owner@vger.kernel.org Mon Jul 26 20:30:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdSRa-0004cx-OO
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 20:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754994Ab0GZSaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 14:30:22 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44181 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754983Ab0GZSaS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 14:30:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o6QIK1af004905
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 26 Jul 2010 20:20:01 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OdSRB-0002TZ-Ro; Mon, 26 Jul 2010 20:30:05 +0200
In-Reply-To: <AANLkTimRrpiv7cu=j598K3x4h3UGW7-Hik6-6jA8R_5J@mail.gmail.com> (Jasper St. Pierre's message of "Mon\, 26 Jul 2010 14\:22\:42 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 26 Jul 2010 20:20:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6QIK1af004905
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1280773201.79267@L/axazVYdmomAkfdEYA5+Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151875>

"Jasper St. Pierre" <jstpierre@mecheye.net> writes:

> I don't think we should do anything about the '+' case, except where used in
> formencoded parameters (aka the "query string"), where it is used.

This is what the latest version of the patch does, AIUI, yes.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

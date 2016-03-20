From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC Project | Improvise git bisect
Date: Sun, 20 Mar 2016 19:08:15 +0100
Message-ID: <vpqoaa9c99s.fsf@anie.imag.fr>
References: <CAFZEwPN-oUDNnc_PBeP2Q4msJAHenkiLtE+Oo75R+uTTwUKpYQ@mail.gmail.com>
	<vpqoaaahbvi.fsf@anie.imag.fr>
	<CAP8UFD2fudNtGpUHTYjZKXCErocuRS65E=5tH_+_tsNFbmHCBA@mail.gmail.com>
	<CAFZEwPMeejJEMjYbx1sJsH0UNygDEdtNazceOePo81Abi0dHHQ@mail.gmail.com>
	<CAFZEwPP2OLOQanazPXxK1u5GVHzFWqx8GuRad7tLUyHrWR_+Tw@mail.gmail.com>
	<alpine.DEB.2.20.1603201628590.4690@virtualbox>
	<CAFZEwPMEDnzv3mLpULOY=7CQZgULx5QsAb_4Pz40iJWzt9HRGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jeff King <peff@peff.net>, Troy Moure <troy.moure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kevin Daudt <me@ikke.info>,
	Philip Oakley <philipoakley@iee.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 19:11:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahhpL-0001Oz-RJ
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 19:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbcCTSLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 14:11:44 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47858 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826AbcCTSLn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 14:11:43 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u2KI8Dn8020605
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 20 Mar 2016 19:08:13 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u2KI8FxP015804;
	Sun, 20 Mar 2016 19:08:15 +0100
In-Reply-To: <CAFZEwPMEDnzv3mLpULOY=7CQZgULx5QsAb_4Pz40iJWzt9HRGg@mail.gmail.com>
	(Pranit Bauva's message of "Sun, 20 Mar 2016 21:56:54 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Sun, 20 Mar 2016 19:08:13 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u2KI8Dn8020605
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1459102094.42435@lU0nwunxnztWW+bL65A00Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289373>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> When I am writing
> functions, I am thinking to make some tests which will be copied
> contents of t/t6030-bisect-porcelain.sh with s/bisect/bisect--helper/g
> uncommenting tests as I implement more functions.

I don't think you need that. When you write a new function, you are
removing pieces of shell and adding pieces of C as replacement. If the
testsuite is complete, it covers the shell implementation today and will
cover the C implementation when it replaces the shell.

The existing tests should be usable without modification.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

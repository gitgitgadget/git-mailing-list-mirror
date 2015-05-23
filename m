From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [Announce] submitGit for patch submission (was "Diffing
 submodule does not yield complete logs")
Date: Sat, 23 May 2015 11:06:55 +0200
Organization: gmx
Message-ID: <696c665281fa2abd35c519e0947fef98@www.dscho.org>
References: <CAFY1edY3+Wt-p2iQ5k64Fg-nMk2PmRSvhVkQSVNw94R18uPV2Q@mail.gmail.com>
 <73db761f3c737965f64ac45005f7a716@www.dscho.org>
 <5b4bab2727a9fcee3a07724c64752cf9@www.dscho.org>
 <0B3203305DF54249930E5903864B4988@PhilipOakley>
 <93994cca5e27388aee7e7c5fd4508816@www.dscho.org>
 <BACC0468FBD24DA584507676EC4E6A5A@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Roberto Tyley <roberto.tyley@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Robert Dailey <rcdailey.lists@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	emma@gitforteams.com
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat May 23 11:07:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yw5Oq-0002zy-4f
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 11:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756455AbbEWJHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 05:07:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:56055 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbbEWJHB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 05:07:01 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MC8iq-1YnJx24BXM-008sjA; Sat, 23 May 2015 11:06:57
 +0200
In-Reply-To: <BACC0468FBD24DA584507676EC4E6A5A@PhilipOakley>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:5J9MuqXpKXw8Dd0xAMEhjOz18rzXsjDX30McuND0Clrv2/UOGRI
 wzJTll29Gi08uzpLKoEOlFQuCPWI5lmWkZwzeTZ7rD40vNnt2X+OvNa0KXnCy68CGxSBTSZ
 hZt5e5NfKr7Slqa13+VbiDZWfZCfSA5E5LP2FBSei77EiZ77r2GJbXfNw18ZfL4f5soee09
 KZ+pNMXiJggN1OZJo9p6Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269796>

Hi Philip,

On 2015-05-22 23:35, Philip Oakley wrote:

> Do I read you right.. That it's necessary to create a PR on git/git
> before submitGit can be used.

Yep.

> And that if I already have a PR which goes back to an alternate fork
> (e.g. my example), then I must move or duplicate that PR onto git/git
> before it can be used.

Yep, the rationale being that you most likely have to rebase your PR to git/git's `master` branch, anyway.

Ciao,
Dscho

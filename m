From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 3/3] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Thu, 26 Mar 2015 14:27:38 +0100
Message-ID: <vpq384r7ut1.fsf@anie.imag.fr>
References: <1427174429-5876-1-git-send-email-pyokagan@gmail.com>
	<1427174429-5876-3-git-send-email-pyokagan@gmail.com>
	<vpqbnjivi2n.fsf@anie.imag.fr>
	<CAPig+cQ-yLnjrsB1E-7=UXfGzuJHat6YtfS8EVRNP2dcjj_6TA@mail.gmail.com>
	<xmqqwq252grl.fsf@gitster.dls.corp.google.com>
	<xmqqr3sc25b0.fsf@gitster.dls.corp.google.com>
	<20150326052042.GA20689@yoshi.chippynet.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 14:28:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yb7pV-000708-7J
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 14:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbbCZN2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 09:28:07 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51363 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752364AbbCZN2C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 09:28:02 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t2QDRbP6013986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 Mar 2015 14:27:37 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t2QDRci6021484;
	Thu, 26 Mar 2015 14:27:38 +0100
In-Reply-To: <20150326052042.GA20689@yoshi.chippynet.com> (Paul Tan's message
	of "Thu, 26 Mar 2015 13:20:42 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 26 Mar 2015 14:27:38 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t2QDRbP6013986
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1427981262.43827@7MAGOBGlK/z61JuEWQo47Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266327>

Paul Tan <pyokagan@gmail.com> writes:

> On Wed, Mar 25, 2015 at 01:25:07PM -0700, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> I've already queued the following and merged it to 'next'.
>
> Thanks Matthieu and Eric for your reviews, and Johannes for following up
> on this.
>
> Will keep in view XDG support for ~/.git-credential-cache next because I
> don't like to leave things unfinished, unless we want to keep it around
> as a microproject. Perhaps home_config_paths() can also be
> simplified/removed because it hardcodes '~/.gitconfig'.

I may be able to get some students to work on it in May-June (I teach in
Ensimag, a french computer-science school and offer "contribute to
open-source" as an end-of-year project), but no guarantee. If you want
to do it before, just do it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

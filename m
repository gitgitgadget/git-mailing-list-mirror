From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/1] Documentation: config: typo fixed
Date: Thu, 18 Dec 2014 14:40:13 +0100
Message-ID: <vpqsigd5b5u.fsf@anie.imag.fr>
References: <1418902079-27794-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 14:40:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1bJi-0005a9-H6
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 14:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbaLRNk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 08:40:27 -0500
Received: from mx2.imag.fr ([129.88.30.17]:52110 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752458AbaLRNkY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 08:40:24 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id sBIDeBZb023742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Dec 2014 14:40:11 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id sBIDeDSA012689;
	Thu, 18 Dec 2014 14:40:13 +0100
In-Reply-To: <1418902079-27794-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Thu, 18 Dec 2014 17:27:59 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 18 Dec 2014 14:40:11 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: sBIDeBZb023742
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1419514815.86772@GRZudT5/RTM2JYPCYZtfgw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261524>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> -core.fileMode::
> +core.filemode::
>  	Tells Git if the executable bit of files in the working tree
>  	is to be honored.

I do not think that this is a good change: config variable names are
case insensitive, so filemode and fileMode are both correct. The
convention used elsewhere in the documentation is CamelCasing, so the
old version seems better to me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

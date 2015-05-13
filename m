From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/2] teach git pull to handle --log=<n>
Date: Wed, 13 May 2015 11:40:55 +0200
Message-ID: <vpqd224zufs.fsf@anie.imag.fr>
References: <1431508661-21729-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 11:41:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsTA6-00081V-QT
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889AbbEMJlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:41:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40196 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933306AbbEMJlE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:41:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4D9esri029518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 May 2015 11:40:54 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4D9etpT021886;
	Wed, 13 May 2015 11:40:55 +0200
In-Reply-To: <1431508661-21729-1-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Wed, 13 May 2015 17:17:39 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 13 May 2015 11:40:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4D9esri029518
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1432114858.5759@kvRGSfC98FC82/cP5QcbuA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268968>

Paul Tan <pyokagan@gmail.com> writes:

> Paul Tan (2):
>   t5524: test --log=1 limits shortlog length
>   pull: handle --log=<n>
>
>  git-pull.sh         |  4 ++--
>  t/t5524-pull-msg.sh | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+), 2 deletions(-)

I thought you forgot to update the documentation, but by the magic of
ascidoc includes, the feature was already documented even though it was
not implemented ;-).

Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

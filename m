From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v1 0/4] hashmap improvements
Date: Thu, 03 Jul 2014 09:23:16 +0200
Message-ID: <vpqk37uc3dn.fsf@anie.imag.fr>
References: <53B48540.5070600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Tanay Abhra <tanayabh@gmail.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 09:23:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2bMe-0004sx-N0
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 09:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919AbaGCHXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 03:23:25 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51702 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951AbaGCHXY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 03:23:24 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s637NFxr030551
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 3 Jul 2014 09:23:15 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s637NGCW011349;
	Thu, 3 Jul 2014 09:23:16 +0200
In-Reply-To: <53B48540.5070600@gmail.com> (Karsten Blees's message of "Thu, 03
	Jul 2014 00:18:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 03 Jul 2014 09:23:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s637NFxr030551
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1404977000.46298@ndZA+TrFk6a5rfaDubCQng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252857>

Karsten Blees <karsten.blees@gmail.com> writes:

> Here are a few small hashmap improvements, partly resulting from recent
> discussion of the config-cache topic.
>
> Karsten Blees (4):
>   hashmap: factor out getting an int hash code from a SHA1
>   hashmap: improve struct hashmap member documentation
>   hashmap: add simplified hashmap_get_from_hash() API
>   hashmap: add string interning API

The patch series look good to me (but that's not a detailed review,
just a moderately quick look).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

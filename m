From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v14 5/8] bisect: introduce --no-checkout support into porcelain.
Date: Wed, 3 Aug 2011 07:17:46 +0200
Message-ID: <201108030717.46817.chriscool@tuxfamily.org>
References: <1312323362-20096-1-git-send-email-jon.seymour@gmail.com> <1312323362-20096-6-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 07:18:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoTqE-0006mA-8G
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 07:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437Ab1HCFR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 01:17:57 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:46273 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754405Ab1HCFR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 01:17:56 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8446AA620D;
	Wed,  3 Aug 2011 07:17:48 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <1312323362-20096-6-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178540>

On Wednesday 03 August 2011 00:15:59 Jon Seymour wrote:
> @@ -291,7 +304,7 @@ bisect_next() {
>  	bisect_next_check good
> 
>  	# Perform all bisection computation, display and checkout
> -	git bisect--helper --next-all
> +	git bisect--helper --next-all ${BISECT_MODE}

Style, please use $BISECT_MODE instead of ${BISECT_MODE}

Thanks,
Christian.

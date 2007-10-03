From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add test case for ls-files --with-head
Date: Wed, 03 Oct 2007 14:09:13 +0200
Message-ID: <47038669.30302@viscovery.net>
References: <1191390255.16292.2.camel@koto.keithp.com>	<7vtzp8g2s2.fsf@gitster.siamese.dyndns.org> <87y7ekr86e.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 14:09:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id32g-0001h1-0C
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 14:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbXJCMJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 08:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754870AbXJCMJU
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 08:09:20 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:55163 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754267AbXJCMJU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 08:09:20 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Id32N-0000wy-DA; Wed, 03 Oct 2007 14:09:11 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3CCE269F; Wed,  3 Oct 2007 14:09:13 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <87y7ekr86e.wl%cworth@cworth.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59831>

Carl Worth schrieb:
> +for num in $(seq -f%04g 1 50); do
> +	touch sub/file-$num
> +	echo file-$num >> expected
> +done

seq is not universally available. Can we have that as

for i in 0 1 2 3 4; do
	for j in 0 1 2 3 4 5 6 7 8 9; do
		> sub/file-$i$j
		echo file-$i$j >> expected
	done
done

-- Hannes

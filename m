From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: "make quick-install-man" broke recently
Date: Mon, 17 Aug 2009 10:00:09 +0200
Message-ID: <4A890E09.9010507@viscovery.net>
References: <86my5z8cjd.fsf@blue.stonehenge.com> <7vy6pj449g.fsf@alter.siamese.dyndns.org> <86iqgn8brv.fsf@blue.stonehenge.com> <7vd46v3tp1.fsf@alter.siamese.dyndns.org> <8c9a060908162258ua50e34ah53c1ada9dbcd4aa0@mail.gmail.com> <7vhbw72ap3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jacob Helwig <jacob.helwig@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kjetil Barvik <barvik@broadpark.no>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 10:00:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcx8i-0006Dk-5V
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 10:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757155AbZHQIAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 04:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753583AbZHQIAN
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 04:00:13 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:34454 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144AbZHQIAM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 04:00:12 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mcx8T-0002oA-Ct; Mon, 17 Aug 2009 10:00:09 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 254ECC6C2; Mon, 17 Aug 2009 10:00:09 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7vhbw72ap3.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano schrieb:
> check_path(): allow symlinked directories to checkout-index --prefix

> +test_expect_success 'checkout-index -f twice with --prefix' '

Please add SYMLINKS prerequisite before you publish this test case.

> +	mkdir -p tar/get &&
> +	ln -s tar/get there &&
> +	echo first &&
> +	git checkout-index -a -f --prefix=there/ &&
> +	echo second &&
> +	git checkout-index -a -f --prefix=there/
> +'

Thanks,
-- Hannes

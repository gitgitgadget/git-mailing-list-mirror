From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 3/7] t/t2012-checkout-last: test "checkout -" after
 a rebase
Date: Wed, 19 Jun 2013 11:10:03 +0200
Message-ID: <51C1756B.2000907@viscovery.net>
References: <1371629089-27008-1-git-send-email-artagnon@gmail.com> <1371629089-27008-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 11:10:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpEPc-0000cu-Km
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 11:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934440Ab3FSJKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 05:10:11 -0400
Received: from so.liwest.at ([212.33.55.13]:16943 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933862Ab3FSJKI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 05:10:08 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UpEOx-0007o9-OR; Wed, 19 Jun 2013 11:10:03 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7C1571660F;
	Wed, 19 Jun 2013 11:10:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <1371629089-27008-4-git-send-email-artagnon@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228381>

Am 6/19/2013 10:04, schrieb Ramkumar Ramachandra:
> +test_expect_failure '"checkout -" works after a rebase -i A B' '
> +	git branch foodle master~1 &&
> +	git checkout master &&
> +	git checkout other &&
> +	git rebase master foodle &&

	git rebase -i master foodle &&

> +	git checkout - &&
> +	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
> +'
> +
>  test_done

-- Hannes

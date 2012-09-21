From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 14/14] Add git-check-ignore sub-command
Date: Fri, 21 Sep 2012 07:44:55 +0200
Message-ID: <505BFED7.5030203@viscovery.net>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org> <1348170383-15751-1-git-send-email-git@adamspiers.org> <1348170383-15751-15-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 07:45:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEw38-0002UO-BC
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 07:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344Ab2IUFpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 01:45:03 -0400
Received: from lilzmailso03.liwest.at ([212.33.55.24]:23535 "EHLO
	so01.liwestmail.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754198Ab2IUFpC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 01:45:02 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so01.liwestmail.local with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TEw2q-0000w8-5R; Fri, 21 Sep 2012 07:44:56 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B89201660F;
	Fri, 21 Sep 2012 07:44:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <1348170383-15751-15-git-send-email-git@adamspiers.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206109>

Am 9/20/2012 21:46, schrieb Adam Spiers:
>  test_expect_success 'general options plus command' '
> -	test_completion "git --version check" "checkout " &&
> -	test_completion "git --paginate check" "checkout " &&
> -	test_completion "git --git-dir=foo check" "checkout " &&
> -	test_completion "git --bare check" "checkout " &&
> +	test_completion "git --version checko" "checkout " &&
> +	test_completion "git --paginate checko" "checkout " &&
> +	test_completion "git --git-dir=foo checko" "checkout " &&
> +	test_completion "git --bare checko" "checkout " &&
> ...

I find this worrysome. Is check-ignore, being a debugging aid, so
important that it must be autocompleted?

-- Hannes

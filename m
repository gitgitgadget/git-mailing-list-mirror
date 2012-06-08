From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCHv3 2/2] rebase [-i --exec | -ix] <CMD>...
Date: Fri, 08 Jun 2012 19:02:57 +0200
Message-ID: <4FD23041.90908@kdbg.org>
References: <1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1339167235-2009-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1339167235-2009-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 08 19:03:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd2aa-00014q-5N
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 19:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761535Ab2FHRDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 13:03:03 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:16458 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758198Ab2FHRDB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 13:03:01 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C613FCDF88;
	Fri,  8 Jun 2012 19:04:12 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4249219F6E9;
	Fri,  8 Jun 2012 19:02:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1339167235-2009-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199512>

Am 08.06.2012 16:53, schrieb Lucien Kong:
> +if test -n "$cmd" &&
> +   test "$interactive_rebase" != explicit
> +then
> +	die "--exec option must be used with --interactive option\n"
> +fi

Is the \n really necessary?

> +	sed -e "1,9d" expect >expected &&

Good. But I said "Here and everywhere else". So I wonder about these
lines ;)

> +	sed '1,9d' expect >expected &&
> +	sed '1,9d' expect >expected &&
> +	sed '1,9d' expect >expected &&
> +	sed '1,11d' expect >expected &&
> +	sed '1,13d' expect >expected &&
> +	sed '1d' actual >tmp &&

-- Hannes

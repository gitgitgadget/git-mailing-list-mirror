From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] git init: optionally allow a directory argument
Date: Sat, 25 Jul 2009 09:45:18 +0200
Message-ID: <200907250945.18398.j6t@kdbg.org>
References: <20090725065928.6117@nanako3.lavabit.com> <7v7hxxz2lt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 09:46:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUbxX-0002D9-KX
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 09:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbZGYHpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 03:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbZGYHpW
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 03:45:22 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:62453 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbZGYHpW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 03:45:22 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D1C47CDF8B;
	Sat, 25 Jul 2009 09:45:19 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D5732435F0;
	Sat, 25 Jul 2009 09:45:18 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7v7hxxz2lt.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123994>

On Samstag, 25. Juli 2009, Junio C Hamano wrote:
> +test_expect_success 'init notices EPERM' '
> +	rm -fr newdir &&
> +	(
> +		mkdir newdir &&
> +		chmod -w newdir &&
> +		test_must_fail git init newdir/a/b
> +	)
> +'

This test will require POSIXPERM prerequisite.

-- Hannes

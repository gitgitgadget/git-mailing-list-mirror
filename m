From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: jn/apply-filename-with-sp (Re: What's cooking in git.git (Aug 2010, #02; Wed, 11))
Date: Sat, 14 Aug 2010 20:37:50 +0200
Message-ID: <201008142037.50833.j6t@kdbg.org>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org> <4C65BCD2.6000701@kdbg.org> <20100814022625.GA4199@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Greg Brockman <gdb@mit.edu>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 20:38:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkLcI-0007ih-EW
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 20:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573Ab0HNSh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Aug 2010 14:37:56 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:40396 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753051Ab0HNShz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 14:37:55 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id A615D2C4007;
	Sat, 14 Aug 2010 20:37:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id E627E19F5FD;
	Sat, 14 Aug 2010 20:37:50 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20100814022625.GA4199@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153568>

On Samstag, 14. August 2010, Jonathan Nieder wrote:
> @@ -20,6 +20,44 @@ test_expect_success 'setup: clean-up functions' '
>  	reset_subdirs() {
>  		rm -fr a b &&
>  		mkdir a b
> +	} &&
> +
> +	cat <<-\EOF >expand.sed &&
...

Why not just write an explicit test vector? The result of expand will be 
constant, no?

-- Hannes

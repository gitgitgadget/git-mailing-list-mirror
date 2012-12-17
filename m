From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] Documentation/git-checkout.txt: clarify usage
Date: Mon, 17 Dec 2012 09:59:54 +0100
Message-ID: <50CEDF0A.7040603@viscovery.net>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com> <1355726702-27974-2-git-send-email-chris@rorvick.com> <7vhanlnnz7.fsf@alter.siamese.dyndns.org> <50CED5D4.5040705@viscovery.net> <7vk3shm5d5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chris Rorvick <chris@rorvick.com>, git@vger.kernel.org,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Woody Wu <narkewoody@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 10:00:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkWYb-00013O-VH
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 10:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366Ab2LQJAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 04:00:00 -0500
Received: from so.liwest.at ([212.33.55.24]:49029 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805Ab2LQI77 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 03:59:59 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TkWYE-0004mS-HR; Mon, 17 Dec 2012 09:59:54 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 414981660F;
	Mon, 17 Dec 2012 09:59:54 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vk3shm5d5.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211665>

Am 12/17/2012 9:48, schrieb Junio C Hamano:
> Here is what I tentatively have ...

Thanks!

> -'git checkout' [--detach] [<commit>]::
> +'git checkout' --detach [<commit>]::
> +'git checkout' <commit>::
>  
> -	Update the index and working tree to reflect the specified
> -	commit and set HEAD to point directly to <commit> (see
> -	"DETACHED HEAD" section.)  Passing `--detach` forces this
> -	behavior even if <commit> is a branch.
> +	Prepare to work on building new history on top of <commit>,
> +	by detaching HEAD at the commit (see "DETACHED HEAD"
> +	section), and updating the index and the files in the
> +	working tree.  Local modifications to the files in the
> +	working tree are kept, so that they can be committed on the
> +	<branch>.

The last half-sentence should better be removed.

> ++
> +Passing `--detach` forces this behavior even if <commit> is a branch.
>  
>  'git checkout' [-p|--patch] [<tree-ish>] [--] <pathspec>...::

-- Hannes

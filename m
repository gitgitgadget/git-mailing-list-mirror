From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: use single-parameter --cacheinfo in example
Date: Thu, 11 Sep 2014 10:35:30 -0700
Message-ID: <xmqqppf2dpr1.fsf@gitster.dls.corp.google.com>
References: <1410448791-31514-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Sep 11 19:35:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS8HS-0004gf-Gg
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 19:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbaIKRfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 13:35:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57479 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbaIKRfe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 13:35:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4422C38B5C;
	Thu, 11 Sep 2014 13:35:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7PjDVD8pcoiBpKvjxDepIXBNPTw=; b=GV68st
	ck0O+vnzU9B+ZLltpAHKmYq9M+6PvvrBuS6XImfuyAY+lK43Ie5aWUCo/Xv3e1Y8
	l2EgEHtCfCxDkmniyGk5MgEjLB6cNnAKCcTx0gZCbAPM775gurt3vfxENYhhDHrZ
	cr830+lUa9Q244pob8ekI8lftZyA88F6T5Wbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rL5II1vyxa1CUAPFdICpZOU0F23Rn9i1
	U7osEHhvJMebos3cLgJN3Bm6nMZCmr9xqUCAoGgWDom5qs3hHPe8VDQVDUE8gbCQ
	Vcd170pZQmetE5dpNEJyYWltUTc5q0beDCJ76rKqM3BHD7yCN/5QSNIlLHYZsem4
	NqriynhK4OY=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BF73538B59;
	Thu, 11 Sep 2014 13:35:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A865238B54;
	Thu, 11 Sep 2014 13:35:31 -0400 (EDT)
In-Reply-To: <1410448791-31514-1-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Thu, 11 Sep 2014 17:19:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 075AB1C0-39DA-11E4-B207-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256858>

Steffen Prohaska <prohaska@zib.de> writes:

> The single-parameter form is described as the preferred way.  Separate
> arguments are only supported for backward compatibility.  Update the
> example to the recommended form.
>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---

My fault.  Thanks for catching.

>  Documentation/git-update-index.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> index dfc09d9..82eca6f 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -202,7 +202,7 @@ merging.
>  To pretend you have a file with mode and sha1 at path, say:
>  
>  ----------------
> -$ git update-index --cacheinfo mode sha1 path
> +$ git update-index --cacheinfo <mode>,<sha1>,<path>
>  ----------------
>  
>  '--info-only' is used to register files without placing them in the object

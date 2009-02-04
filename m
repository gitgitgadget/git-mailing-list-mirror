From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] urls.txt: document optional port specification in git
 URLS
Date: Wed, 04 Feb 2009 12:53:34 -0800
Message-ID: <7vvdrpore9.fsf@gitster.siamese.dyndns.org>
References: <7vr62et6p4.fsf@gitster.siamese.dyndns.org>
 <1233780575-20125-1-git-send-email-stefan.naewe+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Stefan Naewe <stefan.naewe+git@gmail.com>
To: Stefan Naewe <stefan.naewe@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 21:55:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUom6-0007uW-A6
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 21:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849AbZBDUxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 15:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753240AbZBDUxo
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 15:53:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43815 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbZBDUxn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 15:53:43 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1C64D2A70D;
	Wed,  4 Feb 2009 15:53:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 632DD2A709; Wed, 
 4 Feb 2009 15:53:36 -0500 (EST)
In-Reply-To: <1233780575-20125-1-git-send-email-stefan.naewe+git@gmail.com>
 (Stefan Naewe's message of "Wed, 4 Feb 2009 21:49:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E7D31974-F2FD-11DD-AD3A-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108432>

Stefan Naewe <stefan.naewe@googlemail.com> writes:

> Signed-off-by: Stefan Naewe <stefan.naewe+git@gmail.com>
> ---
>  Documentation/urls.txt |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/urls.txt b/Documentation/urls.txt
> index fa34c67..5355ebc 100644
> --- a/Documentation/urls.txt
> +++ b/Documentation/urls.txt
> @@ -6,10 +6,10 @@ to name the remote repository:
>  
>  ===============================================================
>  - rsync://host.xz/path/to/repo.git/
> -- http://host.xz/path/to/repo.git/
> -- https://host.xz/path/to/repo.git/
> -- git://host.xz/path/to/repo.git/
> -- git://host.xz/~user/path/to/repo.git/
> +- http://host.xz{startsb}:port{endsb}/path/to/repo.git/
> +- https://host.xz{startsb}:port{endsb}/path/to/repo.git/
> +- git://host.xz{startsb}:port{endsb}/path/to/repo.git/
> +- git://host.xz{startsb}:port{endsb}/~user/path/to/repo.git/
>  - ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git/
>  - ssh://{startsb}user@{endsb}host.xz/path/to/repo.git/
>  - ssh://{startsb}user@{endsb}host.xz/~user/path/to/repo.git/

Do you know if these port specifications do actually work?  Just double
checking.

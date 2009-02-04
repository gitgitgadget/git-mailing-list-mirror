From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] urls.txt: document optional port specification in git
 URLS
Date: Wed, 04 Feb 2009 10:09:27 -0800
Message-ID: <7vr62et6p4.fsf@gitster.siamese.dyndns.org>
References: <1233748295-4554-1-git-send-email-stefan.naewe@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 19:11:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUmDF-0002R4-9a
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 19:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbZBDSJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 13:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752338AbZBDSJe
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 13:09:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64701 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbZBDSJe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 13:09:34 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2F7782A6E9;
	Wed,  4 Feb 2009 13:09:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 615552A6E5; Wed, 
 4 Feb 2009 13:09:29 -0500 (EST)
In-Reply-To: <1233748295-4554-1-git-send-email-stefan.naewe@atlas-elektronik.com> (Stefan
 Naewe's message of "Wed, 4 Feb 2009 12:51:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F968E70C-F2E6-11DD-9731-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108404>

Stefan Naewe <stefan.naewe@atlas-elektronik.com> writes:

> Signed-off-by: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
> ---
>  Documentation/urls.txt |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/urls.txt b/Documentation/urls.txt
> index fa34c67..c74f00b 100644
> --- a/Documentation/urls.txt
> +++ b/Documentation/urls.txt
> @@ -8,8 +8,8 @@ to name the remote repository:
>  - rsync://host.xz/path/to/repo.git/
>  - http://host.xz/path/to/repo.git/
>  - https://host.xz/path/to/repo.git/
> -- git://host.xz/path/to/repo.git/
> -- git://host.xz/~user/path/to/repo.git/
> +- git://host.xz{startsb}:port{endsb}/path/to/repo.git/
> +- git://host.xz{startsb}:port{endsb}/~user/path/to/repo.git/
>  - ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git/
>  - ssh://{startsb}user@{endsb}host.xz/path/to/repo.git/
>  - ssh://{startsb}user@{endsb}host.xz/~user/path/to/repo.git/

Hmph, I wonder if we want that for http:// and https://, too.

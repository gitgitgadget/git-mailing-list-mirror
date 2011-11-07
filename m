From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote: fix remote set-url usage
Date: Sun, 06 Nov 2011 21:12:10 -0800
Message-ID: <7vfwi04itx.fsf@alter.siamese.dyndns.org>
References: <1320637017-30863-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 06:12:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNHVN-0006rC-Ua
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 06:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819Ab1KGFMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 00:12:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36089 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761Ab1KGFMN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 00:12:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F19D11C6;
	Mon,  7 Nov 2011 00:12:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TA6BQoGTTpNkGzVBuXgS9QkX9ps=; b=mQ4gi3
	5Bm3B+PYkgI2yYEOPbS5LO9VrjWyX6rryrREWXb2nI/cWLF7Dn6EmVhjU/iF5AyB
	f+NIzMV4Hcs/cyAgWbiF29TX5NKk0Tp5oksdAkp3Jt3SZHBGG202TFbeXt7i47ws
	EmJ8SLokZsZbqTPfPzpEBrtzkJPKCGJ7oU+x4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wrc7mf7MrUAD41BmEu/6EtLe2PjKVnax
	i/G0hs7mnCDosDd/h9beNLRiuPAZemObzGx8MGNS2iCQ2daZQx5EhvFUHm6rOkFL
	+kEZ1p/Sl+lcDik//B7xQmIWqWDXgscl6rYn1HbSGaZsNqq847IJ150bf8cH6xNo
	ZPPhH/Hhsbg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4331D11AD;
	Mon,  7 Nov 2011 00:12:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CBC31131; Mon,  7 Nov 2011
 00:12:11 -0500 (EST)
In-Reply-To: <1320637017-30863-1-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Mon, 7 Nov 2011 05:36:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C757262-08FF-11E1-8235-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184948>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Bad copy-paste.
>
> Otherwise the help would be for a different command:
>  git remote set-url --help
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

Doesn't the same thing apply to set-branches?

 builtin/remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index c4d17b5..06741ec 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1336,7 +1336,7 @@ static int set_branches(int argc, const char **argv)
 			     builtin_remote_setbranches_usage, 0);
 	if (argc == 0) {
 		error("no remote specified");
-		usage_with_options(builtin_remote_seturl_usage, options);
+		usage_with_options(builtin_remote_setbranches_usage, options);
 	}
 	argv[argc] = NULL;
 

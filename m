From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Strbuf documentation: document most functions
Date: Mon, 02 Jun 2008 16:39:26 -0700
Message-ID: <7vk5h75rv5.fsf@gitster.siamese.dyndns.org>
References: <1212447591-4870-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jun 03 01:40:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Jdj-0003tq-A6
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 01:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369AbYFBXjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 19:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754548AbYFBXjn
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 19:39:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54561 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbYFBXjm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 19:39:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F4552DF5;
	Mon,  2 Jun 2008 19:39:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6AB862DEE; Mon,  2 Jun 2008 19:39:36 -0400 (EDT)
In-Reply-To: <1212447591-4870-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Tue, 3 Jun 2008 00:59:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2B628F44-30FD-11DD-B641-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83596>

Miklos Vajna <vmiklos@frugalware.org> writes:

> All functions in strbuf.h are documented, except strbuf_expand() and
> launch_editor().
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> Actually this is a bit of request for help,...

In that case,...

> diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
> index a52e4f3..3879e0e 100644
> --- a/Documentation/technical/api-strbuf.txt
> +++ b/Documentation/technical/api-strbuf.txt
> @@ -1,6 +1,175 @@
>  strbuf API
>  ==========
>  
> -Talk about <strbuf.h>
> +strbuf's can be use in many ways: as a byte array, or to store arbitrary
> +long, overflow safe strings.
>  
> -(Pierre, JC)

I expected somebody who touches this file to take hints from these names
before removing them ;-)

I'm still at work so I won't be commenting on them in this message but
I'll take a look at it later.  Pierre Cc'ed.

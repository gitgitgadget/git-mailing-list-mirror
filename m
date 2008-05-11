From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 2/5] Make mktag a builtin.
Date: Sun, 11 May 2008 10:28:09 -0700
Message-ID: <7v63tk6992.fsf@gitster.siamese.dyndns.org>
References: <1210299589-10448-1-git-send-email-drafnel@example.com>
 <1210299589-10448-2-git-send-email-drafnel@example.com>
 <7689656.1210299528037.JavaMail.teamon@b301.teamon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: drafnel@gmail.com
X-From: git-owner@vger.kernel.org Sun May 11 19:29:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvFMC-0005bT-E1
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 19:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689AbYEKR2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 13:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754603AbYEKR2T
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 13:28:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680AbYEKR2S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 13:28:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 050E72BF7;
	Sun, 11 May 2008 13:28:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 592F12BF6; Sun, 11 May 2008 13:28:12 -0400 (EDT)
In-Reply-To: <7689656.1210299528037.JavaMail.teamon@b301.teamon.com>
 (drafnel@gmail.com's message of "Thu, 8 May 2008 21:19:46 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A46088A4-1F7F-11DD-86C4-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81800>

drafnel@gmail.com writes:

> From: Brandon Casey <drafnel@gmail.com>
>
> Signed-off-by: Brandon Casey <drafnel@gmail.com>

> @@ -306,6 +305,7 @@ BUILT_INS += git-fsck-objects$X
>  BUILT_INS += git-get-tar-commit-id$X
>  BUILT_INS += git-init$X
>  BUILT_INS += git-merge-subtree$X
> +BUILT_INS += git-mktag$X
>  BUILT_INS += git-peek-remote$X
>  BUILT_INS += git-repo-config$X
>  BUILT_INS += git-show$X
> @@ -423,6 +423,7 @@ LIB_OBJS += log-tree.o
>  LIB_OBJS += mailmap.o
>  LIB_OBJS += match-trees.o
>  LIB_OBJS += merge-file.o
> +LIB_OBJS += mktag.o

This is unusual for a builtin.  Why didn't it migrate to builtin-mktag?

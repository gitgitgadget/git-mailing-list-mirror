From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash: add 'merge --ff' and '--no-ff' options
Date: Sat, 14 Feb 2009 21:34:55 -0800
Message-ID: <7v7i3sp8jk.fsf@gitster.siamese.dyndns.org>
References: <1234628576-4686-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 06:36:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYZgN-00005m-4S
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 06:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbZBOFfR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Feb 2009 00:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbZBOFfR
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 00:35:17 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbZBOFfQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Feb 2009 00:35:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6448F2B28D;
	Sun, 15 Feb 2009 00:35:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C723D2B285; Sun,
 15 Feb 2009 00:35:03 -0500 (EST)
In-Reply-To: <1234628576-4686-1-git-send-email-szeder@ira.uka.de> (SZEDER
 =?utf-8?Q?G=C3=A1bor's?= message of "Sat, 14 Feb 2009 17:22:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6B6FDD72-FB22-11DD-8A1E-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109964>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
>  contrib/completion/git-completion.bash |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index e848d5d..ad45717 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1037,6 +1037,7 @@ _git_merge ()
>  	--*)
>  		__gitcomp "
>  			--no-commit --no-stat --log --no-log --squash --strategy
> +			--ff --no-ff
>  			"
>  		return
>  	esac

I do not have objections to the patch per-se, but it made me stop think=
ing
for 2 minutes why there is --no-ff listed but not --no-squash, and I ga=
ve
up, not being able to figure out why.

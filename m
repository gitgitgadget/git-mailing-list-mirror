From: Junio C Hamano <gitster@pobox.com>
Subject: Re: summaries in git add --patch
Date: Thu, 27 Nov 2008 16:34:56 -0800
Message-ID: <7viqq8adsf.fsf@gitster.siamese.dyndns.org>
References: <492F0CAD.3010101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 01:36:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5rLg-000602-1f
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 01:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118AbYK1AfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 19:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753034AbYK1AfK
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 19:35:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52991 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548AbYK1AfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 19:35:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 886AD17A08;
	Thu, 27 Nov 2008 19:35:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8C5DF17A07; Thu,
 27 Nov 2008 19:34:58 -0500 (EST)
In-Reply-To: <492F0CAD.3010101@gmail.com> (William Pursell's message of "Thu,
 27 Nov 2008 21:10:05 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 68A9264C-BCE4-11DD-B30B-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101850>

William Pursell <bill.pursell@gmail.com> writes:

> Stage this hunk [y,n,a,l,d,k,K,j,J,e,?]? l
> '*' indicates current hunk.  '+' stage, '-' don't stage
>  0+: @@ -8,9 +8,9 @@ Aani
>  1 : @@ -48,7 +48,7 @@ abandonable
> *2 : @@ -88,7 +88,7 @@ abaton
>  3 : @@ -128,7 +128,7 @@ abdest
>  4-: @@ -81192,9 +81192,9 @@ gyrous
>  5 : @@ -234925,7 +234925,7 @@ zymotic
> @@ -88,7 +88,7 @@ abaton
>  abator
>  abattoir
>  Abatua
> -abature
> +agature
>  abave
>  abaxial
>  abaxile

Machines count from zero but humans count from one.

What is your plans to limit the output of this when there are dozens of
hunks?

A hunk can and often is quite long which would make this list scroll off
the screen.  Together with the previous point, I suspect it would be
better to make this not part of the "Stage this one?" question, but an
action that (1) does not do anything to the hunk we have currently focus
on, and (2) does not move the focus after it does its thing.  In other
words, a new "status" action.  I think 'S' is not taken yet although 's'
is taken for 'split'.

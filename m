From: Tim Haga <timhaga@ebene6.org>
Subject: Re: [PATCH] git-latexdiff: new command in contrib, to use latexdiff
 and Git
Date: Thu, 16 Feb 2012 00:33:00 +0100
Message-ID: <20120216003300.17228570@sirion>
References: <1329320987-15203-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Feb 16 00:33:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxoLZ-0005EX-LI
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 00:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755980Ab2BOXdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 18:33:09 -0500
Received: from tamara.ebene6.org ([78.46.96.189]:52878 "EHLO ebene6.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457Ab2BOXdG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 18:33:06 -0500
Received: from sirion (sirion.me-ix.net [IPv6:2a02:2918:1002:3:e478:59ff:fee7:3a5b])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ebene6.org (Postfix) with ESMTPSA id 8AD575383B8;
	Thu, 16 Feb 2012 00:29:48 +0100 (CET)
In-Reply-To: <1329320987-15203-1-git-send-email-Matthieu.Moy@imag.fr>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.6; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190865>

While testing your script on my office machine i discovered that the
following might be a problem:

> +if [ "$view" = 1 ] || [ "$view" = maybe ] && [ "$output" = "" ]; then
> +    xpdf "$pdffile"
> +fi

Xpdf is not installed on all machines (e.g. it's not installed on my
office machine), so maybe it would be a good idea to use a environment
variable instead?


Tim

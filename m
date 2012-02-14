From: Tim Haga <timhaga@ebene6.org>
Subject: Re: git-latexdiff: Git and Latexdiff working together
Date: Tue, 14 Feb 2012 21:19:17 +0100
Message-ID: <20120214211917.53ef9df6@sirion>
References: <vpq7gzph7mi.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 14 21:29:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxP0A-000397-0Q
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 21:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760873Ab2BNU3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 15:29:22 -0500
Received: from tamara.ebene6.org ([78.46.96.189]:45139 "EHLO ebene6.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757199Ab2BNU3V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 15:29:21 -0500
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Feb 2012 15:29:21 EST
Received: from sirion (sirion.me-ix.net [IPv6:2a02:2918:1002:3:e478:59ff:fee7:3a5b])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ebene6.org (Postfix) with ESMTPSA id D57E5538396;
	Tue, 14 Feb 2012 21:16:08 +0100 (CET)
In-Reply-To: <vpq7gzph7mi.fsf@bauges.imag.fr>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.6; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190750>

Hi,

your tool seems very useful for LaTeX users, especially in scientific
work. I could not test it in detail until now, but i had two or
three runs with an article draft and it seems to work.

Long story short, i would appreciate it if your tool would be
integrated in git.

T.


Am Tue, 14 Feb 2012 14:22:45 +0100
schrieb Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:

> Hi,
> 
> You may know latexdiff, a neat tool to visualize differences between
> LaTeX files (it annotates your .tex file with colors for removed/added
> parts, producing another compilable .tex file).
> 
> I wrote a little shell-script that allows one to use latexdiff on files
> versionned by Git, with e.g.
> 
>   git latexdiff HEAD^ --main foo.tex --output foo.pdf
> 
> Essentially, it does a checkout of the old and new revisions, and calls
> latexdiff + pdflatex for you.
> 
> The result is attached in case anyone is interested.
> 
> It may be relevant to add this to contrib/ in git.git. If anyone's
> interested, let me know, and I'll resend the code in the form of a
> patch doing that.
> 
> Regards,
> 

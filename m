From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH 1/2] War on whitespace: first, a bit of retreat.
Date: Fri, 2 Nov 2007 21:14:23 +1100
Message-ID: <ee77f5c20711020314h43290dbs8141cb3905c867@mail.gmail.com>
References: <7vwst15ceq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Brian Downing" <bdowning@lavos.net>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 11:14:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IntXz-0003RQ-F1
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 11:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbXKBKOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 06:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752984AbXKBKOZ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 06:14:25 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:10498 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbXKBKOY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 06:14:24 -0400
Received: by rv-out-0910.google.com with SMTP id k20so763748rvb
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 03:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+J3vfV8vu1jYspSncKJutJsNEY7gCTv/+zYvqro8VDo=;
        b=Fz78zyPPqVIooL2SPr9SZHuvF3N3CMbtAnkjKxD28wSY5dOXkRIjoj+JO6/wnaniPZgiK0wLOpeqOzGrfFY127rvLRNfFz2pqi39FzyFohcmCWg4/mM+b0rDxejed49k6lDurhxGRlWOpdQP7PKXdJmdIf7QSB1hD49KgFjRvjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W4IxOdY4Z2iT/gk6I5H8LlUehphcstMLFb2a1Ng+QDFs+SafqeNld3y3/d/GEA522IMpgO4ueCkUoLBwScsjvFrodDmEWKMy0SZPAQJHQM+vHHrnozDEh9r6Ckh0iOiSZoFFCtIlOq9QGh6EXo8OsW/20wY/bReuO8EdAHAXANA=
Received: by 10.141.178.5 with SMTP id f5mr781401rvp.1193998463947;
        Fri, 02 Nov 2007 03:14:23 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Fri, 2 Nov 2007 03:14:23 -0700 (PDT)
In-Reply-To: <7vwst15ceq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63095>

On 11/2/07, Junio C Hamano <gitster@pobox.com> wrote:
> This introduces core.whitespace configuration variable that lets
> you specify the definition of "whitespace error".
>
> Currently there are two kinds of whitespace errors defined:
>
>  * trailing-space: trailing whitespaces at the end of the line.
>
>  * space-before-tab: a SP appears immediately before HT in the
>    indent part of the line.

>         [core]
>                 whitespace = -trailing-space

Could I suggest naming the option 'whitespaceError', so it's clearer
that it's a negative setting?


Dave.

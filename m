From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [new tool] git-project-version.sh
Date: Tue, 15 Apr 2008 14:01:06 +0200
Message-ID: <8aa486160804150501p2f55a3e9g33df94c1d4274e48@mail.gmail.com>
References: <20080415113629.GA17459@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nico -telmich- Schottelius" <nico-git-20080415@schottelius.org>
X-From: git-owner@vger.kernel.org Tue Apr 15 14:02:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JljrN-0004SO-Tq
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 14:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760570AbYDOMBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 08:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758696AbYDOMBQ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 08:01:16 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:62399 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbYDOMBP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 08:01:15 -0400
Received: by yw-out-2324.google.com with SMTP id 5so962966ywb.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6t0dJ6rnbX4Y2cnigXQSeWKX1e3DzoOHN3Vo1eaKxcg=;
        b=j0k8kYGdaUthHPHGxO0R3xRdT0sst0XW3kf6ZwnLInCCg5/YH+y6+C4xbMAMW3oWJUxSeJeApZFndfN6ynmc99NtOx1Ap4CTu70pxDGe3gHGYJ1NrWoXB+eqN0+KjSV7I1daQY8xE0LBxTE9ajUKnYG96fjjWUExbEzhyRPi6Rk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oQ51nK+dZ8+ssusKWuxDx//hOWun5FymGjzaG4r2apU3hIrW1EVz3Rr6AtdeAbG3Jr73Aj0I+8XyNihV5YQDYu0IyS6XCmPID23rvWz5jrapP7SpzgdUte49xZRSi3nhK3DUUjBjbHQ/jvnsRRdVH9TAkWv9yuaUoqidvWA+r/0=
Received: by 10.150.53.2 with SMTP id b2mr7636294yba.110.1208260866368;
        Tue, 15 Apr 2008 05:01:06 -0700 (PDT)
Received: by 10.151.14.14 with HTTP; Tue, 15 Apr 2008 05:01:06 -0700 (PDT)
In-Reply-To: <20080415113629.GA17459@denkbrett.schottelius.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79593>

On Tue, Apr 15, 2008 at 1:36 PM, Nico -telmich- Schottelius
<nico-git-20080415@schottelius.org> wrote:
> Hello!
>
>  As I want to use the latest commit id in all my projects, so I know
>  which commit the version is based on, I wrote an extremly simple script
>  that is based on git-show to display only the version named
>  git-project-version.sh.

an equivalent simpler version is:

git rev-parse [--short] HEAD

Also "git show" is a porcelain command, that means it is for humans,
not for scripts. The output of "git show" can change while the output
of "git rev-parse" (and the plumbing) is stable.

But maybe what you really want is:

git describe [--always]

Santi

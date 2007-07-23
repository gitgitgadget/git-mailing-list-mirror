From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: What is a reasonable mixed workflow for git/git-cvsserver?
Date: Mon, 23 Jul 2007 07:59:26 -0300
Message-ID: <46a038f90707230359u5fac77a4i7b6a350d3bb29e3b@mail.gmail.com>
References: <E8B0B250-A428-4CDC-A4D2-FFCF45953076@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 12:59:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICvdT-0006rO-GA
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 12:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756972AbXGWK72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 06:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758100AbXGWK71
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 06:59:27 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:25988 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbXGWK71 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 06:59:27 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1453985wxd
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 03:59:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ne0wdvIyJVTNDIda9rtSUXXPFBbHouKzxuV128RRqREoErLoePUzIAJgr1SqdILuFSMroUJ3lS7YacSfEPJ8gNuiJrln7IuT2UJNiV3pkCvGWrdtkcy93jFugYyyTDj7u5ZUJapjlhgBb/gV1ZkH7wiWod9xpB1h76391IrI/iI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HSuzhC8MlXw8flZFEFc78XJXpx+QdzAfU9jzAz1mcHNvRIZQazhGz5bczV+1Mzu3OPwJpFg6/uGcJlncFTPqlskBfNx4wOYW95SXHIr8fICT/6w9eoBtrW04h5pxkut/lvfDWb5Jy/UTO1uZjfQgmmIhy/FySUx8exFjCUKvoVo=
Received: by 10.90.119.15 with SMTP id r15mr1636008agc.1185188366271;
        Mon, 23 Jul 2007 03:59:26 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Mon, 23 Jul 2007 03:59:26 -0700 (PDT)
In-Reply-To: <E8B0B250-A428-4CDC-A4D2-FFCF45953076@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53428>

On 7/23/07, Steffen Prohaska <prohaska@zib.de> wrote:
> What's a reasonable workflow when some people use git and
> other people use git-cvsserver simultaneously?

It was written on the concept that the core developers would switch to
git and occassional committers and less sophisticated SCM users like
translators would be able to continue using cvs.

Basically, cvs users can no longer tag or open new branches. So your
plan is exactly what we set out to support. Switching branches is not
possibe -- that's unfortunate, but emulating CVS's branching is a
bridge too far :-)

> What is a reasonable way to handle the unsorted commits
> from a shared branch in a more git-ish way? I googled a bit
> but didn't find a good explanation on the web.

I am not sure what you mean by unsorted commits... "proposed patches"?
The git project itself has a proposed-updates branch that might serve
as an example. And repo.or.cz has the strange concept of the mob
branch that you might want to have a look at.

cheers,


martin

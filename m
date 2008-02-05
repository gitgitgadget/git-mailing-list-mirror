From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 05 Feb 2008 02:24:19 -0800 (PST)
Message-ID: <m3zluf4s6r.fsf@localhost.localdomain>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
	<7vodavd9qw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 11:25:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMKzC-0004YK-2V
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 11:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756927AbYBEKY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 05:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756932AbYBEKY0
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 05:24:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:56062 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566AbYBEKYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 05:24:25 -0500
Received: by ug-out-1314.google.com with SMTP id z38so141383ugc.16
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 02:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=ow5vGA8QJFzvBahyjnFBM2KQIkzzrri96l668w6cRq8=;
        b=bc2VG3OJ1S5RxtndYf+mRkxghh7wlvWJB1vLNt7ZepEg46RDncV2lCtlGUjCYNLSQmd64cUX5WgKOq9v2TTgTj9HsLPKz83E0ddfoRhDI87BAEe+/50FMyih15srUqyNijFd1Mbact5qgzP1oXeeDrxlLJxfkbpeMTtPcVjY6i4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=NvSYjir0RD1BlT7PV7AfmHtXPkuWZbfP+OH7UMBFBmYRlWba6gLQlJVYqYlkq/9q6q0SZYP/DOv8Iub/t5WgkQvKe2Ewkdl02JBzUcY5zVd/9dq1RKeKT4jg32TvcyBWFRB8lfNsBUntVsycjwXR9LzjABDn/ftx1GUaUDxmU+U=
Received: by 10.67.122.12 with SMTP id z12mr1122984ugm.18.1202207061826;
        Tue, 05 Feb 2008 02:24:21 -0800 (PST)
Received: from localhost.localdomain ( [83.8.224.128])
        by mx.google.com with ESMTPS id 25sm814798ugn.23.2008.02.05.02.24.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Feb 2008 02:24:19 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m15AOEeL004993;
	Tue, 5 Feb 2008 11:24:14 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m15AOC4B004990;
	Tue, 5 Feb 2008 11:24:12 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <7vodavd9qw.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72642>

Junio C Hamano <gitster@pobox.com> writes:

> * jc/submittingpatches (Sun Feb 3 17:02:28 2008 -0800) 3 commits
>  + Documentation/SubmittingPatches: What's Acked-by and Tested-by?
>  + Documentation/SubmittingPatches: discuss first then submit
>  + Documentation/SubmittingPatches: Instruct how to use [PATCH]
>    Subject header
> 
> These I think are sensible but they did not see much discussion,
> so they are parked here for now.

In those series I think the middle patch could be improved. I guess
that need for brevity overcame need for being explicit. I don't know
if patches meant for discussion are to be send to mailing list only,
or if the patches meant for submissions are to be sent to git mailing
list _and_ maintainer (and is it an error to send them only to the
list) from this description.

The rest patches are IMHO very good improvement.
 
> ----------------------------------------------------------------
> [Will merge to 'master' after 1.5.4.1]
> 
> * ph/describe-match (Mon Dec 24 12:18:22 2007 +0100) 2 commits
>  + git-name-rev: add a --(no-)undefined option.
>  + git-describe: Add a --match option to limit considered tags.

I'd really like that.
 

IIRC there was also patch which did '~' expansion in paths provided
via options to git, but 1.) is was buggy, 2.) it dealt only with
excludefile, and not for example with --git-dir and --work-dir
arguments, 3.) it was not resend for furrther discussion.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
